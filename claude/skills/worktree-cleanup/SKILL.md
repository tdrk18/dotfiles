---
name: worktree-cleanup
description: >
  MayChannel iOS の git worktree を安全に片付ける。各 worktree の未コミット変更・
  未 push commit を検査し、消える内容を提示してから worktree・ブランチ・物理ディレクトリを削除する。
  「worktree を消して」「worktree を片付けて」「古い worktree を整理して」等で呼ばれる。
disable-model-invocation: true
allowed-tools: [Bash, AskUserQuestion, ExitWorktree]
---

# worktree-cleanup

溜まった git worktree を **安全に** 削除する Skill。
削除は復元不可になりうるため、**中身を検査して影響を提示し、ユーザーの明示的な確認を得てから**実行する。

## 大原則

- 検査せずに削除しない。特に **未 push commit / 未コミット変更があるものは破棄＝復元不可**。
- 削除前に必ず対象・影響・実行内容を提示し、AskUserQuestion で確認を取る。
- 安全に消せるもの（クリーン＆ origin/main マージ済み）と、要判断のものを分けて提示する。

## 手順

### 1. 最新化と一覧取得

```bash
GIT_SSH_COMMAND="ssh -o ConnectTimeout=15" git fetch origin main
git worktree list
```

メインのリポジトリ本体（カレント）は対象外。それ以外の worktree を検査する。

### 2. 各 worktree を検査

各 worktree パス `$wt` について以下を収集：

```bash
git -C "$wt" symbolic-ref --short HEAD            # ブランチ名（detached なら別扱い）
git -C "$wt" status --porcelain | wc -l           # 未コミット変更の数（dirty）
git -C "$wt" rev-list --count origin/main..HEAD   # origin/main にない commit 数
git merge-base --is-ancestor "$(git -C "$wt" rev-parse HEAD)" origin/main; echo $?  # 0 ならマージ済み
```

dirty の中身が `Pods/` や `.build/` 等の **生成物のみ** なら実質クリーン扱いでよい（`git -C "$wt" status --short` で中身確認）。

### 3. 未 push commit を持つ worktree は退避可否を確認

`origin/main..HEAD` に commit がある場合、それがリモートに存在するか確認：

```bash
git -C "$wt" rev-parse --abbrev-ref --symbolic-full-name @{u}   # upstream 有無
git ls-remote --heads origin "<branch>"                         # リモート同名ブランチ
gh pr list --head "<branch>" --state all                        # 関連 PR
```

- どれも無い＝**ローカルにしか無い作業**。削除すると完全に失われる。commit 一覧（`git -C "$wt" log --oneline origin/main..HEAD`）を提示する。

### 4. 分類して提示

- **✅ 安全に削除**: dirty なし（or 生成物のみ）かつ origin/main にマージ済み
- **⚠️ 要判断**: 未コミット変更あり / 未マージ・未 push commit あり（中身・commit 一覧を明示）

表形式で提示し、AskUserQuestion でどれを削除するか選ばせる。⚠️ 側は「push して退避してから削除」「構わず破棄」「やめておく」の選択肢を用意する。

### 5. 削除実行（承認後のみ）

```bash
git worktree remove --force "<path>"   # worktree 管理エントリ＋ディレクトリ削除
git branch -D "<branch>"               # 紐づくローカルブランチ削除（detached なら不要）
git worktree prune
```

- worktree と無関係な独立ブランチ（対応する worktree が無いもの）は削除対象に含めない。

### 6. 物理ディレクトリの後始末

`git worktree remove` でディレクトリ削除が `Operation not permitted` になる場合がある（サンドボックス制約）。その場合は管理エントリとブランチだけ先に消え、空ディレクトリが残る。残ったディレクトリは `rm -rf` が必要だが、これもサンドボックス／権限ポリシーでブロックされることがある。**ブロックされたらユーザーに手動実行用のコマンドを提示する**（勝手にサンドボックス無効で強行しない）。

```bash
# 例（ユーザー手動）
rm -rf "<残った worktree ディレクトリ>"
```

### 7. 最終確認

```bash
git worktree list
git branch | grep -E '<削除したブランチのパターン>' || echo "(削除済み)"
```

## 関連

- 作成・セットアップは `worktree-setup` Skill を使う。
