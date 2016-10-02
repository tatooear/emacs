;;; mdk-setting.el ---

;; ================================
;; move
;; ================================
(use-package point-undo :ensure t)
(use-package goto-chg :ensure t)
(use-package jaunte :ensure t)
(use-package thingopt :ensure t)
(use-package ace-jump-mode :ensure t)

(require 'point-undo) ;;カーソルの移動
(require 'goto-chg) ;;変更箇所へ移動
;;(require 'yafastnav)
(require 'jaunte)
(setq jaunte-hint-unit 'symbol)

(require 'thingopt)
(define-thing-commands)

(require 'ace-jump-mode)
(defun ace-jump-push-mark ()
  "Push the current position information onto the `ace-jump-mode-mark-ring'."
  ;; add mark to the emacs basic push mark

  ;; リージョンがアクティブのときはマークをプッシュしないように修正
  (unless (region-active-p)
    (push-mark (point) t))
  ;; 修正ここまで

  ;; we also push the mark on the `ace-jump-mode-mark-ring', which has
  ;; more information for better jump back
  (let ((pos (make-aj-position :offset (point)
                               :visual-area (make-aj-visual-area :buffer (current-buffer)
                                                                 :window (selected-window)
                                                                 :frame  (selected-frame)))))
    (setq ace-jump-mode-mark-ring (cons pos ace-jump-mode-mark-ring)))
  (if (> (length ace-jump-mode-mark-ring) ace-jump-mode-mark-ring-max)
      (setcdr (nthcdr (1- ace-jump-mode-mark-ring-max) ace-jump-mode-mark-ring) nil)))


(setq line-move-visual t)
(defun next-line-visual (&optional arg try-vscroll)
  "Move cursor vertically down ARG lines.
If the variable `line-move-visual' is nil, this command moves
by display lines.  Otherwise, it moves by buffer lines."
  (interactive "^p\np")
  (or arg (setq arg 1))
  (setq line-move-visual (not line-move-visual))
  (next-line arg try-vscroll)
  (setq line-move-visual (not line-move-visual)))

(defun previous-line-visual (&optional arg try-vscroll)
  "Move cursor vertically up ARG lines.
If the variable `line-move-visual' is nil, this command moves
by display lines.  Otherwise, it moves by buffer lines."
  (interactive "^p\np")
  (or arg (setq arg 1))
  (setq line-move-visual (not line-move-visual))
  (previous-line arg try-vscroll)
  (setq line-move-visual (not line-move-visual)))

;; ================================
;; history
;; ================================
(use-package redo+ :ensure t)
(require 'redo+) ;;やり直し

;;; undo-tree: Undo の分岐を視覚化する
(use-package undo-tree :ensure t)
(require 'undo-tree)
(global-undo-tree-mode)

;;; undohist: 閉じたバッファも Undo できる
(use-package undohist :ensure t)
(require 'undohist)
(undohist-initialize)

;; ================================
;; copy
;; ================================
(setq x-select-enable-clipboard t) ;;クリップボードの共有
(setq clipmon-autoinsert-sound nil)
(use-package duplicate-thing :ensure t)
(require 'duplicate-thing)

(defun copy-whole-line (&optional arg)
  "Copy current line."
  (interactive "p")
  (or arg (setq arg 1))
  (if (and (> arg 0) (eobp) (save-excursion (forward-visible-line 0) (eobp)))
      (signal 'end-of-buffer nil))
  (if (and (< arg 0) (bobp) (save-excursion (end-of-visible-line) (bobp)))
      (signal 'beginning-of-buffer nil))
  (unless (eq last-command 'copy-region-as-kill)
    (kill-new "")
    (setq last-command 'copy-region-as-kill))
  (cond ((zerop arg)
         (save-excursion
           (copy-region-as-kill (point) (progn (forward-visible-line 0) (point)))
           (copy-region-as-kill (point) (progn (end-of-visible-line) (point)))))
        ((< arg 0)
         (save-excursion
           (copy-region-as-kill (point) (progn (end-of-visible-line) (point)))
           (copy-region-as-kill (point)
                                (progn (forward-visible-line (1+ arg))
                                       (unless (bobp) (backward-char))
                                       (point)))))
        (t
         (save-excursion
           (copy-region-as-kill (point) (progn (forward-visible-line 0) (point)))
           (copy-region-as-kill (point)
                                (progn (forward-visible-line arg) (point))))))
  (message (substring (car kill-ring-yank-pointer) 0 -1)))

(defun duplicate-this-line-forward (n)
  "Duplicates the line point is on.  The point is next line.
 With prefix arg, duplicate current line this many times."
  (interactive "p")
  (when (eq (point-at-eol)(point-max))
    (save-excursion (end-of-line) (insert "\n")))
  (save-excursion
    (beginning-of-line)
    (dotimes (i n)
      (insert-buffer-substring (current-buffer) (point-at-bol)(1+ (point-at-eol))))))

(defun print-buffer-file-name ()
  "Display the file name visited in current buffer in the echo area
 and put it into `kill-ring'"
  (interactive)
  (let ((file-name buffer-file-name))
    (if file-name
    (progn (setq kill-ring (cons file-name kill-ring))
           (setq kill-ring-yank-pointer kill-ring)
           (message "%s" file-name))
      (message "not visiting a file"))))

;; ================================
;; edit
;; ================================
(use-package multiple-cursors :ensure t)
(require 'multiple-cursors)

(defun mc/edit-lines-or-string-rectangle (s e)
  "C-x r tで同じ桁の場合にmc/edit-lines (C-u M-x mc/mark-all-dwim)"
  (interactive "r")
  (if (eq (save-excursion (goto-char s) (current-column))
          (save-excursion (goto-char e) (current-column)))
      (call-interactively 'mc/edit-lines)
    (call-interactively 'string-rectangle)))

(defun mc/mark-all-dwim-or-mark-sexp (arg)
  "C-u C-M-SPCでmc/mark-all-dwim, C-u C-u C-M-SPCでC-u M-x mc/mark-all-dwim"
  (interactive "p")
  (cl-case arg
    (16 (mc/mark-all-dwim t))
    (4 (mc/mark-all-dwim nil))
    (1 (mark-sexp 1))))

(use-package phi-search-migemo :ensure t)
(require 'phi-search-migemo)

(use-package auto-highlight-symbol :ensure t)
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)
(ahs-set-idle-interval 0.5)
;; ================================
;; delete & kill
;; ================================

;; kill-ring に同じ内容の文字列を複数入れない
(defadvice kill-new (before ys:no-kill-new-duplicates activate)
  (setq kill-ring (delete (ad-get-arg 0) kill-ring)))

(defun my-kill-ring-save-or-backward-kill-line (&optional arg)
  "マークがアクティブかどうかで動作を切り替える関数.
アクティブでない：カーソル位置から行頭まで削除する.
アクティブ：リージョンをコピー."
 (interactive "p")
 (if mark-active
     (progn
       (kill-ring-save (region-beginning) (region-end))
       (setq mark-active nil))
   (kill-line 0)))
;;   (kill-line (- (or arg 0)))))

;; アクティブでない：カーソル位置から一単語削除する アクティブ：リージョンを切り取り."
(defun my-kill-region-or-backward-kill-word (&optional arg)
 (interactive "p")
  (if mark-active
      (progn
        (kill-region (region-beginning) (region-end))
        (setq mark-active nil))
    (backward-kill-word (or arg 1))))

(defun kill-line-all ()
 (interactive)
 (beginning-of-line)
 (delete-region (point) (progn (end-of-line)(point)))
 (delete-indentation)
 (next-line 1)
 (beginning-of-line)
)
