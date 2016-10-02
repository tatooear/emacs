(require 'sense-region)
(sense-region-on)
(defun sense-region-to-rectangle ()
  (interactive)
  (setq sense-region-status 'rectangle)

  ;; フェイスまわりのデフォルトの挙動が変なので
  ;; この2行を追加
  (copy-face mell-region-face 'sense-region-face)
  (copy-face 'region 'sense-region-region-face)
  (mell-sign-reset-face mell-region-face)
)

(require 'sense-expand-region)
(require 'expand-region)

(use-package region-bindings-mode :ensure t)
(require 'region-bindings-mode)
(region-bindings-mode-enable)

; 矩形分の文字列を置換
(defun replace-rectangle (&optional start end string)
  (interactive "r\nsReplace To: ")
  (save-excursion 
    (let ((region-min   (min start end))
	  (num-of-lines (count-lines start end)))
      (kill-rectangle start end)
      (string-rectangle region-min 
		      (progn
			(goto-char region-min)
			(next-line (1- num-of-lines))
			(point))
		      string))))

;; 矩形の左端に数列を挿入
(eval-when-compile (require 'cl))
(defun number-rectangle (start end format-string from)
  "Delete (don't save) text in the region-rectangle, then number it."
  (interactive
   (list (region-beginning) (region-end)
         (read-string "Number rectangle: " (if (looking-back "^ *") "%d. " "%d"))
         (read-number "From: " 1)))
  (save-excursion
    (goto-char start)
    (setq start (point-marker))
    (goto-char end)
    (setq end (point-marker))
    (delete-rectangle start end)
    (goto-char start)
    (loop with column = (current-column)
          while (<= (point) end)
          for i from from   do
          (insert (format format-string i))
          (forward-line 1)
          (move-to-column column)))
  (goto-char start))

;; リージョンをペアとなる文字で囲う
(defun insert-pair-region (start end str)
  (interactive
   (list (region-beginning) (region-end)
         (read-string "Insert string: ")))
  (save-excursion
    (goto-char start)
    (setq start (point-marker))
    (goto-char end)
    (setq end (point-marker))
    (let* ((pair-str (mapconcat #'insert-pair-region:find-pair str ""))
           (rev-pair-str (apply 'string (reverse (string-to-list pair-str)))))
      (goto-char start)
      (insert-string str)
      (goto-char end)
      (insert-string rev-pair-str)))
  (goto-char start))

(defun insert-pair-region:find-pair (chr)
  (let ((left (assoc chr insert-pair-alist))
        (right (rassoc (list chr) insert-pair-alist)))
    (char-to-string (cond (left (cadr left))
                          (right (car right))
                          (t chr)))))
