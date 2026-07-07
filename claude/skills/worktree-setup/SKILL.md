---
name: worktree-setup
description: >
  MayChannel iOS の git worktree を作成し、依存（CocoaPods / Swift Package / Mint）を
  共有キャッシュ経由で素早くセットアップする。worktree で作業を始めたい時に使う。
  「worktree を作って」「worktree で作業したい」「worktree セットアップ」等で呼ばれる。
disable-model-invocation: true
allowed-tools: [Bash, Read, EnterWorktree, AskUserQuestion]
---

# worktree-setup

MayChannel iOS 用の git worktree を作成し、ビルド依存を **共有キャッシュ経由** で
素早く整えるための Skill。worktree ごとに依存をフル解決し直すコストを避ける。

> このリポジトリ（MayChannel iOS）専用。`MayChannel.xcworkspace` がカレントにある前提。

## 背景（キャッシュ共有の仕組み）

依存のダウンロード系キャッシュは **すでに全 worktree 共有済み**：

| 種類 | 場所 | 共有状況 |
|---|---|---|
| Mint | `~/.mint` | ✅ 共有済み（`MINT_PATH` 未設定のため自動共有。追加作業不要） |
| CocoaPods DLキャッシュ | `~/Library/Caches/CocoaPods` | ✅ 共有済み |
| SPM DLキャッシュ | `~/Library/Caches/org.swift.swiftpm` | ✅ 共有済み |

重複コストが出るのは「展開・統合」の部分：

- **SPM の `SourcePackages`（DerivedData 配下・数 GB/worktree）** → `-clonedSourcePackagesDirPath` で共有ディレクトリに集約する
- **`Pods/`（数百 MB/worktree）** → `pod install` を走らせる（DLキャッシュが効くので初回より速い。`Pods/` のシンボリックリンク共有は xcworkspace 統合の整合事故リスクがあるため**しない**）

共有 SourcePackages のパス（固定）:

```
$HOME/Library/Developer/Xcode/MayChannel-SharedSourcePackages
```

## 手順

### 1. worktree を作成

- worktree 名が引数で渡されていればそれを使う。なければ AskUserQuestion で確認（用途がわかる名前を推奨）。
- `EnterWorktree`（`name` 指定）で作成する。`.claude/settings.local.json` の `worktree.baseRef: "fresh"` により、常に最新の `origin/main` から枝を切る。
- 以降の手順はすべて worktree 内（カレントが worktree に切り替わっている）で実行する。

### 2. 共有 SourcePackages ディレクトリを用意

```bash
mkdir -p "$HOME/Library/Developer/Xcode/MayChannel-SharedSourcePackages"
```

### 3. CocoaPods をインストール

```bash
bundle exec pod install
```

- DLキャッシュ共有済みのため、Podfile.lock に変化がなければ比較的速い。
- 失敗時のみ `bundle exec pod install --repo-update`。

### 4. Swift Package を共有ディレクトリに解決

```bash
xcodebuild -resolvePackageDependencies \
  -workspace MayChannel.xcworkspace \
  -scheme MayChannel \
  -clonedSourcePackagesDirPath "$HOME/Library/Developer/Xcode/MayChannel-SharedSourcePackages"
```

### 5. Mint（必要時のみ）

`~/.mint` 共有済みのため通常は不要。Mintfile が更新されている等で念のため揃えたい時のみ：

```bash
mint bootstrap
```

## セットアップ後にユーザーへ伝えること

- **この worktree でビルド/テストする時は必ず `-clonedSourcePackagesDirPath "$HOME/Library/Developer/Xcode/MayChannel-SharedSourcePackages"` を付ける**こと。付けないと worktree 専用の DerivedData に SourcePackages が再展開され、共有の意味がなくなる。
  - 例: `xcodebuild test -workspace MayChannel.xcworkspace -scheme MayChannel -destination '...' -clonedSourcePackagesDirPath "$HOME/Library/Developer/Xcode/MayChannel-SharedSourcePackages"`
- ⚠️ **XcodeBuildMCP の `test_sim` / `build_sim` は `-clonedSourcePackagesDirPath` を指定できない**ため、共有が効かず worktree 専用 SourcePackages を作る。worktree で SPM 共有の恩恵を受けたい場合は直接 `xcodebuild` を使う。重いフルビルド/テストは本体ディレクトリで行う使い分けも有効。
- ⚠️ 共有 SourcePackages を**複数 worktree で同時にビルドすると競合**しうる。worktree 間でビルドを同時実行しない。

## 関連

- 片付けは `worktree-cleanup` Skill を使う。
