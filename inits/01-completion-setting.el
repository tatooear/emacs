;;; completions-setting.el ---

;; ==================================
;; 補完
;; ==================================

;; コマンドの複数回実効
(defun my-repeat (arg)
  (interactive "p")
  (unless (eq real-last-command this-command)
    (let ((i 0))
      (while (< i arg)
        (repeat 1)
        (setq i (1+ i))))))

;; 繰り返し処理
(defconst *dmacro-key* [?\C-:] "繰返し指定キー")
(global-set-key *dmacro-key* 'dmacro-exec)
(autoload 'dmacro-exec "dmacro" nil t)

;; (require 'key-combo)
;; (key-combo-mode 1)

;; (setq key-combo-lisp-default
;;       '(
;;         ("-" . (" - " "-" ))
;;         ("(" . ("( `!!' )" "(`!!')" "("))
;;         ("[" . ("[ `!!' ]" "[`!!']" "【`!!'】" ))
;;         ("'" . ("\'`!!''" "\'"))
;;         ("\"" . ("\"`!!'\"" "\""))
;;         ("<" . ("< `!!' >" "<`!!'>"))
;;         ("," . (" , " "," ))
;;         ("=" . (" = " "=" ))
;;         ("`" . ("\``!!'\`" "`"))
;;         )
;;       )

;; (setq key-combo-lisp-mode-hooks
;;       '(lisp-mode-hook
;;         emacs-lisp-mode-hook
;;         lisp-interaction-mode-hook
;;         text-mode-hook
;;         sql-mode-hook))

;; (setq key-combo-common-default
;;       '(("," . (" , " ","))
;;         ("=" . (" = " " === " "=" " == " ))
;;         ("+" . (" + " "++" " += " "+"))
;;         ("-" . (" - " "--" "->" " -= " "-"))
;;         (">" . (" > " " => " " >= " "=>" ">" "&gt;"))
;;         ("%" . (" % " " %= " "%"))
;;         ("!" . (" !== " " ! " "!"))
;;         ("~" . (" =~ " "~"))
;;         (":" . (" : " ":"))
;;         ("&" . (" & " " && " "&" " &= " "&amp;" "&nbsp;"))
;;         ("*" . (" * "  "*"))
;;         ("<" . (" < " " <= " "<" "&lt;"))
;;         ("|" . (" | "" || " "|"))
;;         ("/" . ( " / " "// " "/"))
;;         ("{" . ("{\n`!!'\n}" "{ `!!' }" "{`!!'}" " { " "{"))
;;         ("[" . ("[ `!!' ]" "[ " "["))
;;         ("'" . ("'`!!''" "'"))
;;         ("\"" . ("\"`!!'\"" "\""))
;;         ("(" . ("( `!!' )" "(`!!')" " ( " "(" ))
;;         ("?" . ("<?php `!!' ?>" "<?php" "?>" "<?=" "?" ))
;;         ))

;; (setq key-combo-common-mode-hooks
;;       '(php-mode-hook
;;         javascript-mode-hook
;;         js-mode-hook
;;         js2-mode-hook
;;         web-mode-hook
;;         html-mode-hook
;;         nxml-mode-hook))

;; (key-combo-define-hook key-combo-common-mode-hooks
;;                        'key-combo-common-load-default
;;                        key-combo-common-default)

;; (key-combo-define-hook key-combo-lisp-mode-hooks
;;                        'key-combo-lisp-load-default
;;                        key-combo-lisp-default)

(require 'smartchr) ;;特定入力補完
(defun smartchr-custom-keybindings ()
  (local-set-key (kbd "=") (smartchr '(" = " " == "  "=")))
  (local-set-key (kbd "+") (smartchr '(" + " "++"  "+" " += " )))
  (local-set-key (kbd "-") (smartchr '(" - " "--"  "-" " -= " )))
  (local-set-key (kbd "&") (smartchr '("&" " && "  " & ")))
  ;; !! がカーソルの位置
  (local-set-key (kbd "(") (smartchr '("( `!!' )" "(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[ `!!' ]" "[`!!']" "[ [`!!'] ]" "[")))
  (local-set-key (kbd "{") (smartchr '("{" "{\n`!!'\n}" "{ `!!' }" "{`!!'}")))
  (local-set-key (kbd "'") (smartchr '("\'`!!''" "\'")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd "/") (smartchr '("/" "// " " / ")))
  (local-set-key (kbd ">") (smartchr '(" > " " >= " ">")))
  (local-set-key (kbd "<") (smartchr '(" < " " <= " "<")))
  (local-set-key (kbd ",") (smartchr '(" , " "," )))
  )

(defun smartchr-custom-keybindings-text ()
  (local-set-key (kbd "-") (smartchr '(" - " "-" )))
  (local-set-key (kbd "(") (smartchr '("( `!!' )" "(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[ `!!' ]" "[`!!']" "【`!!'】" )))
  (local-set-key (kbd "'") (smartchr '("\'`!!''" "\'")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd "<") (smartchr '("< `!!' >" "<`!!'>")))
  (local-set-key (kbd ",") (smartchr '(" , " "," )))
  )

(defun smartchr-custom-keybindings-html ()
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"" "&quot;")))
  (local-set-key (kbd "`") (smartchr '("\``!!''" "\`")))
  (local-set-key (kbd "<") (smartchr '("<" "&lt;" )))
  (local-set-key (kbd ">") (smartchr '(">" "&gt;" )))
  (local-set-key (kbd "&") (smartchr '("&" "&amp;" "&nbsp;")))
  (local-set-key (kbd "?") (smartchr '("<?php `!!' ?>" "<?php" "?>" "<?=" "?")))
  )

(defun smartchr-custom-keybindings-php ()
  (local-set-key (kbd "=") (smartchr '(" = " " === " "=" "=>" "==" )))
  (local-set-key (kbd "+") (smartchr '(" + " "++"  "+" " += " )))
  (local-set-key (kbd "-") (smartchr '( "->" " - " "--" "-"  )))
  (local-set-key (kbd "(") (smartchr '("( `!!' )" "(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[ `!!' ]" "[`!!']" "[")))
  (local-set-key (kbd "{") (smartchr '("{" "{\n`!!'\n}" "{ `!!' }" "{`!!'}")))
  (local-set-key (kbd "'") (smartchr '("\'`!!''" "\'")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd ">") (smartchr '(" > " " >= " ">")))
  (local-set-key (kbd "<") (smartchr '(" < " " <= " "<")))
  (local-set-key (kbd "/") (smartchr '("/" "// " " / ")))
  (local-set-key (kbd ",") (smartchr '(" , " "," )))
  (local-set-key (kbd "?") (smartchr '("<?php `!!' ?>" "<?php" "?>" "<?=" "?")))
  (local-set-key (kbd "`") (smartchr '("\``!!'\`" "`")))
  (local-set-key (kbd "&") (smartchr '("&" " && "  " & ")))
  (local-set-key (kbd "!") (smartchr '("!" " !== "  " !! " " != " )))
  )

(defun smartchr-custom-keybindings-sql ()
  (local-set-key (kbd "=") (smartchr '(" = " "=" )))
  (local-set-key (kbd "'") (smartchr '("\'`!!''" "\'")))
  (local-set-key (kbd "(") (smartchr '("( `!!' )" "(`!!')" "(")))
  (local-set-key (kbd "`") (smartchr '("\``!!'\`" "`")))
  (local-set-key (kbd ",") (smartchr '(" , " "," )))
  )

(add-hook 'c-mode-common-hook 'smartchr-custom-keybindings)
(add-hook 'js2-mode-hook 'smartchr-custom-keybindings)
(add-hook 'emacs-lisp-mode-common-hook 'smartchr-custom-keybindings)
(add-hook 'text-mode-hook 'smartchr-custom-keybindings-text)
(add-hook 'css-mode-hook 'smartchr-custom-keybindings-text)
;; (add-hook 'mmm-global-mode 'smartchr-custom-keybindings-html)
(add-hook 'nxml-mode-hook 'smartchr-custom-keybindings-html)
(add-hook 'html-mode-hook 'smartchr-custom-keybindings-html)
(add-hook 'php-mode-hook 'smartchr-custom-keybindings-php)
(add-hook 'sql-mode-hook 'smartchr-custom-keybindings-sql)
(add-hook 'web-mode-hook 'smartchr-custom-keybindings-php)
(add-hook 'fundamental-mode-hook 'smartchr-custom-keybindings-php)

;; 囲む
(require 'emacs-surround)
(add-to-list 'emacs-surround-alist '("(" . (" ( " . " ) ")))
(add-to-list 'emacs-surround-alist '("p" . ("<p>" . "</p>")))
(add-to-list 'emacs-surround-alist '("v" . ("<div>" . "</div>")))
(add-to-list 'emacs-surround-alist '("s" . ("<span>" . "</span>")))
(add-to-list 'emacs-surround-alist '("h" . ("<th>" . "</th>")))
(add-to-list 'emacs-surround-alist '("r" . ("<tr>" . "</tr>")))
(add-to-list 'emacs-surround-alist '("t" . ("<td>" . "</td>")))

(ffap-bindings)

;; auto-complete
(use-package auto-complete :ensure t)
(require 'auto-complete-config)
(global-auto-complete-mode t) ;; 対象の全てで補完を有効にする

(setq ac-auto-start 2)
(setq ac-disable-faces nil) ;;コメントや文字列リテラルでも補完を行う

(setq ac-sources '(ac-source-functions
                   ac-source-yasnippet
                   ac-source-features
                   ac-source-abbrev
                   ac-source-imenu
                   ac-source-gtags
                   ac-source-css-property
                   ac-source-words-in-same-mode-buffers
                   ac-source-dictionary))

;;look コマンドを使って英単語を補完する
(defun my-ac-look ()
  "look コマンドの出力をリストで返す"
  (interactive)
  (unless (executable-find "look")
    (error "look コマンドがありません"))
  (let ((search-word (thing-at-point 'word)))
    (with-temp-buffer
      (call-process-shell-command "look" nil t 0 search-word)
      (split-string-and-unquote (buffer-string) "\n"))))

(defun ac-complete-look ()
  (interactive)
  (let ((ac-menu-height 50)
        (ac-candidate-limit t))
  (auto-complete '(ac-source-look))))

(defvar ac-source-look
  '((candidates . my-ac-look)
    (requires . 2)))  ;; 2文字以上ある場合にのみ対応させる

;;補完対象とするモードの ac-sources に対して
(push 'ac-source-look ac-sources) ;追加

;; 補完対象モードの追加
(setq ac-modes
      (append ac-modes
              '(html-mode nxml-mode php-mode text-mode js2-mode css-mode web-mode)))

(use-package ac-ispell :ensure t)
(require 'ac-ispell)
(custom-set-variables
 '(ac-ispell-requires 2)
 '(ac-ispell-fuzzy-limit 2))

(eval-after-load "auto-complete"
  '(progn
     (ac-ispell-setup)))

;; yasnippet
;; スニペットの位置を設定します。
;; (require 'yasnippet)
;; (yas-global-mode 1)
;; (custom-set-variables '(yas-trigger-key "TAB"))

(use-package emmet-mode :ensure t)
(require 'emmet-mode)
(add-hook 'php-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'nxml-mode-hook 'emmet-mode)
(add-hook 'emmet-mode-hook (lambda () (setq emmet-indentation 2))) ;; indent 2 spaces
(setq emmet-move-cursor-between-quotes t) ;; 最初のクオートの中にカーソル

;; ;; prefixなしで previewを表示しないようにする
(eval-after-load "emmet-mode"
  '(progn
     ;; Preview is disable as default
     (setq emmet-preview-default nil)))

(use-package ac-emmet :ensure t)
(require 'ac-emmet)
(add-hook 'web-mode-hook 'ac-emmet-html-setup)
(add-hook 'php-mode-hook 'ac-emmet-html-setup)
(add-hook 'html-mode-hook 'ac-emmet-html-setup)

(add-hook 'css-mode-hook 'ac-emmet-css-setup)
(add-hook 'web-mode-hook 'ac-emmet-css-setup)
(add-hook 'html-mode-hook 'ac-emmet-css-setup)
(add-hook 'php-mode-hook 'ac-emmet-css-setup)

;;(require 'ac-helm)
(use-package ac-mozc :ensure t)
(require 'ac-mozc)

;;zlc
;; (require 'zlc)
;; (zlc-mode 1)
;; (setq zlc-select-completion-immediately t)
;; (let ((map minibuffer-local-map))
;;   ;;; like menu select
;;   (define-key map (kbd "<down>")  'zlc-select-next-vertical)
;;   (define-key map (kbd "<up>")    'zlc-select-previous-vertical)
;;   (define-key map (kbd "<right>") 'zlc-select-next)
;;   (define-key map (kbd "<left>")  'zlc-select-previous)

;;   ;;; reset selection
;;   ;;(define-key map (kbd "C-c") 'zlc-reset)
;;   )

;;カーソルの位置にある数字列をインクリメント
(defun operate-string-as-number (number op)
  (let ((col (current-column))
        (p (if (integerp number) number 1))
        )
    (skip-chars-backward "-0123456789")
    (or (looking-at "-?[0123456789]+")
        (error "No number at point"))
      (replace-match
       (number-to-string (funcall op (string-to-number (match-string 0)) p)))
    (move-to-column col)))
(defun increment-string-as-number (number)
  (interactive "P")
  (operate-string-as-number number (lambda (x y) (+ x y)))
  )

(defun decrement-string-as-number (number)
  (interactive "P")
  (operate-string-as-number number (lambda (x y) (- x y)))
  )
