;;; default-setting.el ---
(use-package moe-theme :ensure t)
(require 'moe-theme)
(moe-dark)
;;(setq moe-theme-mode-line-color 'green)

(setq default-frame-alist
      (append '((width                . 150)  ; フレーム幅
                (height               . 38 ) ; フレーム高
             ;; (left                 . 70 ) ; 配置左位置
             ;; (top                  . 28 ) ; 配置上位置
                (line-spacing         . 0  ) ; 文字間隔
                (left-fringe          . 10 ) ; 左フリンジ幅
                (right-fringe         . 0 ) ; 右フリンジ幅
                (menu-bar-lines       . 1  ) ; メニューバー
                (cursor-type          . box) ; カーソル種別
                (alpha                . 85) ;  透明度
                (foreground-color . "white");; 文字が白
                (background-color . "black") ;; 背景は黒
                (border-color     . "black")
                (cursor-color     . "yellow")
                ;;(font . "Inconsolata-15")
                ) default-frame-alist) )
(setq initial-frame-alist default-frame-alist)

;;1234567890|
;;あいうえお|
;;かきくけこ|

(set-face-attribute 'default nil :family "Inconsolata" :height 150) ;; デフォルト フォント
(set-face-attribute 'variable-pitch nil :family "Inconsolata" :height 150) ;; プロポーショナル フォント
(set-face-attribute 'fixed-pitch nil :family "Inconsolata" :height 150 ) ;; 等幅フォント
(set-face-attribute 'tooltip nil :family "Inconsolata" :height 150) ;; ツールチップ表示フォント


(dolist (target '(japanese-jisx0212
                  japanese-jisx0213-2
                  japanese-jisx0213.2004-1
                  katakana-jisx0201
                  japanese-jisx0208
                  latin-jisx0201
                  ))

  (set-fontset-font (frame-parameter nil 'font)
                    target
                    (font-spec :family "MeiryoKe_Gothic" :registry "unicode-bmp" :lang 'ja :height 150)))
                    ;; (font-spec :family "源ノ角ゴシック Normal" :registry "unicode-bmp" :lang 'ja :height 160)))

;; (set-default-font "Inconsolata-15")
;; (set-face-font 'variable-pitch "Inconsolata-15")

;; (cond (window-system
;;        (set-face-attribute 'default nil
;;                            :family "Inconsolata"
;;                            :height 150)
;;        (setq face-font-rescale-alist
;;              '(
;;                (".*Inconsolata.*" . 1.0)
;;                (".*MeiryoKe_Gothic.*" . 1.0)
;;                ))
;;        ))

;; ============================================
;; 言語設定
;; ============================================
(set-language-environment "Japanese")
(set-default-coding-systems 'utf-8-unix) ;; デフォルトの文字コード
(prefer-coding-system 'utf-8-unix) ;; テキストファイル／新規バッファの文字コード
(set-file-name-coding-system 'utf-8-unix) ;; ファイル名の文字コード
;;(set-file-name-coding-system 'japanese-shift-jis) ;; ファイル名の文字コード
;;(set-file-name-coding-system 'shift-jis) ;; ファイル名の文字コード
;;(set-file-name-coding-system 'cp932)
;;(setq default-file-name-coding-system 'japanese-shift-jis)
(set-keyboard-coding-system 'utf-8-unix) ;; キーボード入力の文字コード
(setq default-process-coding-system '(undecided-dos . utf-8-unix)) ;; サブプロセスのデフォルト文字コード

(use-package mozc :ensure t)
(require 'mozc)
(use-package mozc-popup :ensure t)
(require 'mozc-popup)
(setq default-input-method "japanese-mozc")
(setq mozc-candidate-style 'popup)

;; (require 'mozc-cursor-color)
(require 'mozc-isearch)
(require 'mozc-mode-line-indicator)

(add-hook 'input-method-activate-hook
          (function (lambda ()
                      (set-cursor-color "red")
                      ;; (set-face-background 'mode-line "grey10")
                      ;; (set-face-foreground 'mode-line "hot pink")
                      )))
(add-hook 'input-method-inactivate-hook
          (function (lambda ()
                      (set-cursor-color "yellow")
          ;; (set-face-background 'mode-line "grey10")
          ;; (set-face-foreground 'mode-line "green")
          )))

;; (setq default-input-method "W32-IME")
;; (setq-default w32-ime-mode-line-state-indicator "[Aa] ")
;; (setq w32-ime-mode-line-state-indicator-list '("[Aa]" "[あ]" "[Aa]"))
;; (w32-ime-initialize)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; 文字コード
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package cp5022x :ensure t)
(require 'cp5022x)
(define-coding-system-alias 'iso-2022-jp 'cp50220)
(define-coding-system-alias 'euc-jp 'cp51932)
(define-coding-system-alias 'shift_jis 'cp932)

;; decode-translation-table の設定
(coding-system-put 'euc-jp :decode-translation-table
     (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
(coding-system-put 'iso-2022-jp :decode-translation-table
     (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
(coding-system-put 'utf-8 :decode-translation-table
     (get 'japanese-ucs-jis-to-cp932-map 'translation-table))

;; encode-translation-table の設定
(coding-system-put 'euc-jp :encode-translation-table
     (get 'japanese-ucs-cp932-to-jis-map 'translation-table))
(coding-system-put 'iso-2022-jp :encode-translation-table
     (get 'japanese-ucs-cp932-to-jis-map 'translation-table))
(coding-system-put 'cp932 :encode-translation-table
     (get 'japanese-ucs-jis-to-cp932-map 'translation-table))
(coding-system-put 'utf-8 :encode-translation-table
     (get 'japanese-ucs-jis-to-cp932-map 'translation-table))

;; charset と coding-system の優先度設定
(set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
          'katakana-jisx0201 'iso-8859-1 'cp1252 'unicode)
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)

;; East Asian Ambiguous
(defun set-east-asian-ambiguous-width (width)
  (while (char-table-parent char-width-table)
    (setq char-width-table (char-table-parent char-width-table)))
  (let ((table (make-char-table nil)))
    (dolist (range
         '(#x00A1 #x00A4 (#x00A7 . #x00A8) #x00AA (#x00AD . #x00AE)
          (#x00B0 . #x00B4) (#x00B6 . #x00BA) (#x00BC . #x00BF)
          #x00C6 #x00D0 (#x00D7 . #x00D8) (#x00DE . #x00E1) #x00E6
          (#x00E8 . #x00EA) (#x00EC . #x00ED) #x00F0
          (#x00F2 . #x00F3) (#x00F7 . #x00FA) #x00FC #x00FE
          #x0101 #x0111 #x0113 #x011B (#x0126 . #x0127) #x012B
          (#x0131 . #x0133) #x0138 (#x013F . #x0142) #x0144
          (#x0148 . #x014B) #x014D (#x0152 . #x0153)
          (#x0166 . #x0167) #x016B #x01CE #x01D0 #x01D2 #x01D4
          #x01D6 #x01D8 #x01DA #x01DC #x0251 #x0261 #x02C4 #x02C7
          (#x02C9 . #x02CB) #x02CD #x02D0 (#x02D8 . #x02DB) #x02DD
          #x02DF (#x0300 . #x036F) (#x0391 . #x03A9)
          (#x03B1 . #x03C1) (#x03C3 . #x03C9) #x0401
          (#x0410 . #x044F) #x0451 #x2010 (#x2013 . #x2016)
          (#x2018 . #x2019) (#x201C . #x201D) (#x2020 . #x2022)
          (#x2024 . #x2027) #x2030 (#x2032 . #x2033) #x2035 #x203B
          #x203E #x2074 #x207F (#x2081 . #x2084) #x20AC #x2103
          #x2105 #x2109 #x2113 #x2116 (#x2121 . #x2122) #x2126
          #x212B (#x2153 . #x2154) (#x215B . #x215E)
          (#x2160 . #x216B) (#x2170 . #x2179) (#x2190 . #x2199)
          (#x21B8 . #x21B9) #x21D2 #x21D4 #x21E7 #x2200
          (#x2202 . #x2203) (#x2207 . #x2208) #x220B #x220F #x2211
          #x2215 #x221A (#x221D . #x2220) #x2223 #x2225
          (#x2227 . #x222C) #x222E (#x2234 . #x2237)
          (#x223C . #x223D) #x2248 #x224C #x2252 (#x2260 . #x2261)
          (#x2264 . #x2267) (#x226A . #x226B) (#x226E . #x226F)
          (#x2282 . #x2283) (#x2286 . #x2287) #x2295 #x2299 #x22A5
          #x22BF #x2312 (#x2460 . #x24E9) (#x24EB . #x254B)
          (#x2550 . #x2573) (#x2580 . #x258F) (#x2592 . #x2595)
          (#x25A0 . #x25A1) (#x25A3 . #x25A9) (#x25B2 . #x25B3)
          (#x25B6 . #x25B7) (#x25BC . #x25BD) (#x25C0 . #x25C1)
          (#x25C6 . #x25C8) #x25CB (#x25CE . #x25D1)
          (#x25E2 . #x25E5) #x25EF (#x2605 . #x2606) #x2609
          (#x260E . #x260F) (#x2614 . #x2615) #x261C #x261E #x2640
          #x2642 (#x2660 . #x2661) (#x2663 . #x2665)
          (#x2667 . #x266A) (#x266C . #x266D) #x266F #x273D
          (#x2776 . #x277F) (#xE000 . #xF8FF) (#xFE00 . #xFE0F)
          #xFFFD
          ))
  (set-char-table-range table range width))
    (optimize-char-table table)
    (set-char-table-parent table char-width-table)
    (setq char-width-table table)))
(set-east-asian-ambiguous-width 2)

;; 全角チルダ/波ダッシュをWindowsスタイルにする
(let ((table (make-translation-table-from-alist '((#x301c . #xff5e))) ))
  (mapc
   (lambda (coding-system)
     (coding-system-put coding-system :decode-translation-table table)
     (coding-system-put coding-system :encode-translation-table table)
     )
   '(utf-8 cp932 utf-16le)))

;; cp932エンコードの表記変更
(coding-system-put 'cp932 :mnemonic ?P)
(coding-system-put 'cp932-dos :mnemonic ?P)
(coding-system-put 'cp932-unix :mnemonic ?P)
(coding-system-put 'cp932-mac :mnemonic ?P)

;; UTF-8エンコードの表記変更
(coding-system-put 'utf-8 :mnemonic ?U)
(coding-system-put 'utf-8-with-signature :mnemonic ?u)

;; 改行コードの表記追加
(setq eol-mnemonic-dos       ":Dos ")
(setq eol-mnemonic-mac       ":Mac ")
(setq eol-mnemonic-unix      ":Unx ")
(setq eol-mnemonic-undecided ":??? ")

;; ============================================
;; タブ、スペースの設定
;; ============================================
(setq-default tab-width 4) ;;タブ幅を 4 に設定
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)) ;;タブ幅の倍数を設定
;;タブではなくスペースを使う
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)

;;行番号を表示
(require 'linum)
;; (require 'hlinum)
;; (hlinum-activate)
(setq linum-format "%04d") ; 5 桁分の領域を確保して行番号のあとにスペースを入れ
(global-linum-mode t)      ; デフォルトで linum-mode を有効にする
;;(fringe-mode 0)
(fringe-mode)

(tool-bar-mode 0)                      ;; ツールバーを表示しない

(require 'server)
(server-start)

(remove-hook
 'kill-buffer-query-functions
 'server-kill-buffer-query-function)
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")
;;(global-auto-revert-mode)

;; 改行
(use-package smart-newline :ensure t)
(require 'smart-newline)
(smart-newline-mode 1)

(show-paren-mode t)
(transient-mark-mode 1)                ;;選択範囲に色を付ける
(setq highlight-nonselected-windows t) ;;バッファを切り替えても色はついたままの状態にする

;; 現在行に色をつける
(require 'hl-line)
;;(global-hl-line-mode)

(defun global-hl-line-timer-function ()
  (global-hl-line-unhighlight-all)
  (let ((global-hl-line-mode t))
    (global-hl-line-highlight)))

(setq global-hl-line-timer
      (run-with-idle-timer 0.1 t 'global-hl-line-timer-function))

;;(smart-cursor-color-mode 1)

;;括弧内を強調表示する
(use-package mic-paren :ensure t)
(require 'mic-paren)
(paren-activate)
;(setq paren-match-face '(underline paren-face)) ;下線
(setq paren-match-face 'bold paren-sexp-mode t) ; bold
(setq paren-sexp-mode t)

;; 全角半角を目立たす方法
(defface my-face-tab         '((t (:background "gray20"))) nil :group 'my-faces)
(defface my-face-zenkaku-spc '((t (:background "LightBlue"))) nil :group 'my-faces)
(defface my-face-spc-at-eol  '((t (:foreground "Red" :underline t))) nil :group 'my-faces)
(defvar my-face-tab         'my-face-tab)
(defvar my-face-zenkaku-spc 'my-face-zenkaku-spc)
(defvar my-face-spc-at-eol  'my-face-spc-at-eol)
(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(("\t" 0 my-face-tab append)
     ("　" 0 my-face-zenkaku-spc append)
     ("[ \t]+$" 0 my-face-spc-at-eol append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

(require 'whitespace)
(setq whitespace-style '(empty))
(setq whitespace-action '(auto-cleanup))
(global-whitespace-mode 1)

;; (setq whitespace-style '(face           ; faceで可視化
;;                          trailing       ; 行末
;;                          tabs           ; タブ
;;                          spaces         ; スペース
;;                          empty          ; 先頭/末尾の空行
;;                          space-mark     ; 表示のマッピング
;;                          tab-mark
;;                          ))
(use-package rainbow-mode :ensure t)
(require 'rainbow-mode)

(use-package rainbow-delimiters :ensure t)
(require 'rainbow-delimiters)

;; 操作の強調表示
(use-package volatile-highlights :ensure t)
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; カラーコードの色を確認する
;; (require 'cl-lib)
;; (require 'cl)
;; (require 'popup)

;; ;; ;; popup-tipの引数で、ポップアップさせる変数を指定する
;; (defvar popup-color-string
;;   (let ((x 9) (y 3)) ;; ポップアップのサイズを指定
;;     (mapconcat 'identity
;;                (loop with str = (make-string x ?\ ) repeat y collect str)
;;                "\n"))
;;   "*String displayed in tooltip.")

;; (defun popup-color-at-point ()
;;   "Popup color specified by word at point."
;;   (interactive)
;;   (let ((word (word-at-point))
;;         (bg (plist-get (face-attr-construct 'popup-tip-face) :background)))
;;     (when word
;;       (unless (member (downcase word) (mapcar #'downcase (defined-colors)))
;;         (setq word (concat "#" word)))
;;       (set-face-background 'popup-tip-face word)
;;       (message "%s: %s"
;;                (propertize "Popup color"
;;                            'face `(:background ,word))
;;                (propertize (substring-no-properties word)
;;                            'face `(:foreground ,word)))
;;       (popup-tip popup-color-string)
;;       (set-face-background 'popup-tip-face bg))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mode line
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(line-number-mode t)
(column-number-mode t)
;; 選択範囲の情報表示
(defun count-lines-and-chars ()
  (if mark-active
      (format "[%3d:%4d]"
              (count-lines (region-beginning) (region-end))
              (- (region-end) (region-beginning)))
    ""))
(add-to-list 'default-mode-line-format
             '(:eval (count-lines-and-chars)))

;;(setq-default header-line-format '("%f"))
;;(setq-default header-line-format '("%b : L%l C%c : %f"))
(setq frame-title-format '("%f"))
;;(setq icon-title-format "%b - %F")

(set-default 'mode-line-buffer-identification
             ;;'(buffer-file-name ("%f")))
             '(buffer-file-name ("%b")))

(defvar mode-line-cleaner-alist
  '( ;; For minor-mode, first char is 'space'
    (yas-minor-mode . " YS")
    (undo-tree-mode . " UT")
    (flycheck-mode . " FC")
    (abbrev-mode . "")
    (php-completion-mode . "")
    (gtags-mode . " GT")
    (emmet-mode . " EM")
    (git-gutter+-mode . " GG")
    (rainbow-mode . " RB")
    (helm-mode . "")
    (magit-mode . "Git")
    ;; Major modes
    (lisp-interaction-mode . "LI")
    (emacs-lisp-mode . "EL")
    ))

(defun clean-mode-line ()
  (interactive)
  (loop for (mode . mode-str) in mode-line-cleaner-alist
        do
        (let ((old-mode-str (cdr (assq mode minor-mode-alist))))
          (when old-mode-str
            (setcar old-mode-str mode-str))
          ;; major mode
          (when (eq mode major-mode)
            (setq mode-name mode-str)))))

(add-hook 'after-change-major-mode-hook 'clean-mode-line)

(defun my-copy-file-path ()
  "show the full path file name in the minibuffer and copy to kill ring."
  (interactive)
  (when buffer-file-name
    (kill-new (file-truename buffer-file-name))
    (message (buffer-file-name))))


;; ============================================
;; スクロール設定
;; ============================================
;;1行ずつスクロールさせる
(setq scroll-conservatively 35
       scroll-margin 0
       scroll-step 1)

;; 画面スクロール
(defun next-line-recenter()
  (interactive)
  (next-line)
  (recenter)
  )

(defun previous-line-recenter()
  (interactive)
  (previous-line)
  (recenter)
  )

(require 'inertial-scroll)
(inertias-global-minor-mode 1)

(setq inertias-scroll-initial-velocity 10)
(setq inertias-initial-velocity 20)
(setq inertias-friction 120)
(setq inertias-update-time 50)
(setq inertias-rest-coef 0.1)

(setq scroll-preserve-screen-position t) ; スクロール時のカーソル位置を維持
(setq scroll-margin 0) ;; スクロール開始の残り行数
(setq scroll-conservatively 10000) ;; スクロール時の行数
(setq scroll-step 0) ;; スクロール時の行数（scroll-marginに影響せず）
(setq next-screen-context-lines 1) ;; 画面スクロール時の重複表示する行数
;;(setq redisplay-dont-pause t) ;; キー入力中の画面更新を抑止
(setq recenter-positions '(top bottom)) ;; recenter-top-bottomのポジション
(setq hscroll-margin 1) ;; 横スクロール開始の残り列数
(setq hscroll-step 1) ;; 横スクロール時の列数

;; ============================================
;; その他
;; ===========================================
(setq default-directory "~/")
(setq inhibit-startup-message t)       ;; 起動時の画面はいらない
(setq initial-scratch-message "")      ;; scratch message の削除
;;(set-scroll-bar-mode 'right)           ;;スクロールバーを右側に
(set-scroll-bar-mode 'nil)           ;;スクロールバーを右側に
(auto-compression-mode t)              ;;圧縮されたファイルも編集＆日本語infoの文字化け防止
(fset 'yes-or-no-p 'y-or-n-p)          ;;"yes or no"を"y or n"にする
(setq mouse-drag-copy-region t) ;; マウスコピー可にする
(setq x-select-enable-clipboard t)
(setq-default cursor-in-non-selected-windows t) ;; 非アクティブウィンドウのカーソル表示
(setq w32-ime-buffer-switch-p nil) ;; バッファ切り替え時の状態引継ぎ設定
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
(setq recenter-positions '(middle top bottom))
