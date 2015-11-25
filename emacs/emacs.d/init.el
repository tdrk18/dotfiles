;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; [PKG管理] パッケージ取得先追加
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; [基本] 背景色・透過
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 背景色設定
(custom-set-faces
   '(default ((t (:background "#000022" :foreground "#EEEEEE"))))
    '(cursor (
              (((class color) (background dark )) (:background "#FFFFFF"))
              (((class color) (background light)) (:background "#999999"))
              (t ())
              )))
;; フレーム透過設定
(add-to-list 'default-frame-alist '(alpha . (0.95 1.00)))
;; カラーテーマ
(load-theme 'railscasts t nil)
; (load-theme 'molokai t nil)
; (load-theme 'solarized t nil)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 標準機能
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;フォント変更
(set-default-font "Ricty-15")

;; スタートアップメッセージ非表示
(setq inhibit-startup-screen t)
;; tool-bar
;; (tool-bar-mode 0)

;; menu-bar
(menu-bar-mode 1)

;; TABの表示幅(初期値8から4に変更)
(setq default-tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120 124 128 132 136 140 144 148 152 156 160 164 168 172 176 180 184 188 192 196 200 204 208 212 216))

;; TABでなくスペースを使う
(setq-default indent-tabs-mode nil)

;; 改行コード表示
(setq eol-mnemonic-dos "(CRLF)")
(setq eol-mnemonic-mac "(CR)")
(setq eol-mnemonic-unix "(LF)")

;; メニューバーにファイルのフルパスを表示
(setq frame-title-format (format "%%f"))

;; ファイルの拡張子とモードの関連付け
(add-to-list 'auto-mode-alist '("\\.ddl$" . sql-mode))

;; 履歴を次回Emacs起動時にも保存する
(savehist-mode 1)

;; 対応する括弧を表示させる
(show-paren-mode 1)

;; 言語設定
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)

;; 編集行を目立たせる（現在行をハイライト表示する）
(defface hlline-face
         '((((class color)
             (background dark))
            (:background "#2D344C"))
           (((class color)
             (background light))
            (:background "ForestGreen"))
           (t
             ()))
         "*Face used by hl-line.")
(setq hl-line-face 'hlline-face)
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)

;; 行番号、桁番号を表示する
(line-number-mode 1)
(column-number-mode 1)
;; 行番号表示
(require 'linum)
(global-linum-mode 1)

;; バックアップファイルを作らない
(setq make-backup-files nil)

;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;; Emacsからの質問を y/n で回答
(fset 'yes-or-no-p 'y-or-n-p)

;; ログの記録行数を増やす
(setq message-log-max 10000)

;; 履歴をたくさん保存する
(setq history-length 10000)

;; キーストロークをエコーエリアに早く表示する
(setq echo-keystrokes 0.1)

;; 大きいファイルを開こうとしたときに警告を発生させる
;; デフォルトは10MBなので50MBに拡張する
(setq large-file-warning-threshold (* 50 1024 1024))

;; 特殊文字の色付け
;; http://masutaka.net/chalow/2011-10-12-1.html
(global-whitespace-mode 1)
(setq whitespace-style '(face tabs tab-mark spaces space-mark newline newline-mark))
(setq whitespace-space-regexp "\\(\u3000+\\)")
(setq whitespace-display-mappings
'((space-mark   ?\u3000 [?\u25a1])   ; 全角スペースを□で表わす
(tab-mark     ?\t     [?\u00BB ?\t] [?\\ ?\t])  ; tab - left quote mark
(newline-mark ?\n     [?\u21B5 ?\n] [?$ ?\n])   ; eol - overscore
))
(set-face-foreground 'whitespace-tab "#7594FF")
(set-face-background 'whitespace-tab 'nil)
(set-face-foreground 'whitespace-space "#7594FF")
(set-face-background 'whitespace-space 'nil)
(set-face-foreground 'whitespace-newline "#7594FF")
(set-face-background 'whitespace-newline 'nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; [基本] トラックパッド用のスクロール設定
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun scroll-down-with-lines ()
    "" (interactive) (scroll-down 3))
(defun scroll-up-with-lines ()
    "" (interactive) (scroll-up 3))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)
(global-set-key [double-wheel-up] 'scroll-down-with-lines)
(global-set-key [double-wheel-down] 'scroll-up-with-lines)
(global-set-key [triple-wheel-up] 'scroll-down-with-lines)
(global-set-key [triple-wheel-down] 'scroll-up-with-lines)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; [基本] グローバルキーマッピング (外部IMEの日本語オン／オフを切替えず使いたい関数用)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; kill buffer を Ctrl-x Ctrl-k で可能に (デフォルトは Ctrl-x k)
(global-set-key (kbd "C-x C-k") 'kill-buffer)

;; 別ウィンドウへの切り替えを Ctrl-x Ctrl-o で可能に (デフォルトは Ctrl-x o)
(global-set-key (kbd "C-x C-o") 'other-window)

;; 単一ウィンドウに戻すのを Ctrl-x Ctrl-1 で可能に (デフォルトは Ctrl-x 1)
(global-set-key (kbd "C-x C-1") 'delete-other-windows)

;; 縦ウィンドウ分割を Ctrl-x Ctrl-2 で可能に (デフォルトは Ctrl-x 2)
(global-set-key (kbd "C-x C-2") 'split-window-below)

;; 縦ウィンドウ分割を Ctrl-x Ctrl-3 で可能に (デフォルトは Ctrl-x 3)
(global-set-key (kbd "C-x C-3") 'split-window-right)

;; フレームの作成・削除を Ctrl-;, Ctrl-: で可能に (デフォルトは C-x 5 2, C-x 5 0)
(global-set-key (kbd "C-;") 'make-frame-command)
(global-set-key (kbd "C-:") 'delete-frame)

;; Ctrl-x Ctrl-d (デフォルトは Ctrl-x d) でも dired を起動する
(global-set-key (kbd "C-x C-d") 'dired)

;; Ctrl-x 方向キーで分割ウィンドウを移動
(global-set-key (kbd "C-x <left>")  'windmove-left)
(global-set-key (kbd "C-x <down>")  'windmove-down)
(global-set-key (kbd "C-x <up>")    'windmove-up)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(setq windmove-wrap-around t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; パッケージ関連
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; smartparens - 括弧補完
;;
(require 'smartparens-config)
(smartparens-global-mode t)

;;
;; powerline
;;
(require 'powerline)
(require 'moe-theme)
(moe-theme-set-color 'cyan)
;; (Available colors: blue, orange, green ,magenta, yellow, purple, red, cyan, w/b.)
(powerline-moe-theme)

;;
;; Auto Complete
;;
(require 'auto-complete-config)
(ac-config-default)
(add-to-list 'ac-modes 'text-mode)         ;; text-modeでも自動的に有効にする
(add-to-list 'ac-modes 'fundamental-mode)  ;; fundamental-mode
(add-to-list 'ac-modes 'org-mode)
(add-to-list 'ac-modes 'yatex-mode)
(ac-set-trigger-key "TAB")
(setq ac-use-menu-map t)       ;; 補完メニュー表示時にC-n/C-pで補完候補選択
(setq ac-use-fuzzy t)          ;; 曖昧マッチ

;;
;; neotree
;;
;;(add-to-list 'load-path "/some/path/neotree")
(require 'neotree)
(global-set-key (kbd "C-q") 'neotree-toggle)

;;
;; git-gutter
;;
(global-git-gutter-mode t)
(setq git-gutter:window-width 2)
(setq git-gutter:added-sign "✚")
(setq git-gutter:deleted-sign-sign "✘")
(setq git-gutter:modified-sign "➜") ;; 空白 2つ
(set-face-foreground 'git-gutter:added  "green")
(set-face-foreground 'git-gutter:deleted  "magenta")
(set-face-background 'git-gutter:modified "yellow")

;;
;; quickrun
;;
(require 'quickrun)
(global-set-key "\C-cc" 'quickrun-compile-only)

;;
;; minimap
;;
(require 'minimap)

;;
;; volatile-highlights
;;
(require 'volatile-highlights)
(volatile-highlights-mode t)

;;
;; hlinum
;;
;(require 'hlinum)
;(hlinum-activate)

;;
;; undohist
;;
(require 'undohist)
(undohist-initialize)

;;
;; tabbar
;;
;; グループ化せずに*scratch*以外のタブを表示
(require 'tabbar)
(tabbar-mode 1)

;; タブ上でマウスホイール操作無効
(tabbar-mwheel-mode -1)

;; グループ化しない
(setq tabbar-buffer-groups-function nil)

;; 左に表示されるボタンを無効化
(dolist (btn '(tabbar-buffer-home-button
                tabbar-scroll-left-button
                tabbar-scroll-right-button))
  (set btn (cons (cons "" nil)
                 (cons "" nil))))

;; タブの長さ
(setq tabbar-separator '(2.2))

;; 外観変更
(set-face-attribute
  'tabbar-default nil
  :family "MeiryoKe_Gothic"
  :background "#34495E"
  :foreground "#EEEEEE"
  :height 0.95
  )
(set-face-attribute
  'tabbar-unselected nil
  :background "#34495E"
  :foreground "#EEEEEE"
  :box nil
  )
(set-face-attribute
  'tabbar-modified nil
  :background "#E67E22"
  :foreground "#EEEEEE"
  :box nil
  )
(set-face-attribute
  'tabbar-selected nil
  :background "#E74C3C"
  :foreground "#EEEEEE"
  :box nil)
(set-face-attribute
  'tabbar-button nil
  :box nil)
(set-face-attribute
  'tabbar-separator nil
  :height 2.0)

;; タブに表示させるバッファの設定
(defvar my-tabbar-displayed-buffers
  '("*scratch*" "*Messages*" "*Backtrace*" "*Colors*" "*Faces*" "*vc-")
  "*Regexps matches buffer names always included tabs.")

(defun my-tabbar-buffer-list ()
  "Return the list of buffers to show in tabs.
  Exclude buffers whose name starts with a space or an asterisk.
  The current buffer and buffers matches `my-tabbar-displayed-buffers'
  are always included."
  (let* ((hides (list ?\  ?\*))
         (re (regexp-opt my-tabbar-displayed-buffers))
         (cur-buf (current-buffer))
         (tabs (delq nil
                     (mapcar (lambda (buf)
                               (let ((name (buffer-name buf)))
                                 (when (or (string-match re name)
                                           (not (memq (aref name 0) hides)))
                                   buf)))
                             (buffer-list)))))
    ;; Always include the current buffer.
    (if (memq cur-buf tabs)
      tabs
      (cons cur-buf tabs))))
(setq tabbar-buffer-list-function 'my-tabbar-buffer-list)


;; Ctrl-Tab, Ctrl-Shift-Tab でタブを切り替える
(dolist (func '(tabbar-mode tabbar-forward-tab tabbar-forward-group tabbar-backward-tab tabbar-backward-group))
  (autoload func "tabbar" "Tabs at the top of buffers and easy control-tab navigation"))
(defmacro defun-prefix-alt (name on-no-prefix on-prefix &optional do-always)
  `(defun ,name (arg)
     (interactive "P")
     ,do-always
     (if (equal nil arg)
       ,on-no-prefix
       ,on-prefix)))
(defun-prefix-alt shk-tabbar-next (tabbar-forward-tab) (tabbar-forward-group) (tabbar-mode 1))
(defun-prefix-alt shk-tabbar-prev (tabbar-backward-tab) (tabbar-backward-group) (tabbar-mode 1))
(global-set-key [(control tab)] 'shk-tabbar-next)
(global-set-key [(control shift tab)] 'shk-tabbar-prev)


;;
;; for YaTex
;; YaTeX mode
(setq auto-mode-alist
    (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
(setq tex-command "platex")
(setq dviprint-command-format "dvipdfmx %s")
;; use Preview.app
(setq dvi2-command "open -a Preview")
(setq bibtex-command "pbibtex")
