;;; helm-setting.el ---
(use-package helm :ensure t)
(use-package helm-package :ensure t)
(use-package helm-gtags :ensure t)
;;(use-package helm-ack :ensure t)
(use-package helm-ag :ensure t)
(use-package helm-descbinds :ensure t)

(require 'helm-config)
(require 'helm-package)
(require 'helm-gtags)
;;(require 'helm-ack)
(require 'helm-ag)
(require 'helm-descbinds)
(helm-mode 1)
(helm-descbinds-mode)

;; (add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
(add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
(add-to-list 'helm-completing-read-handlers-alist '(find-file-at-point . nil))

;; (defadvice helm-buffers-sort-transformer (around ignore activate)
;;   (setq ad-return-value (ad-get-arg 0)))

;; migemo
(use-package migemo :ensure t)
(require 'migemo)
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs"))

;; Set your installed path
(setq migemo-dictionary "/usr/share/cmigemo/utf-8/migemo-dict")

(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)
(setq migemo-coding-system 'utf-8-unix)
(load-library "migemo")
(migemo-init)

;; (use-package helm-migemo :ensure t)
;; (require 'helm-migemo)
;; (eval-after-load "helm-migemo"
;;   '(defun helm-compile-source--candidates-in-buffer (source)
;;      (helm-aif (assoc 'candidates-in-buffer source)
;;          (append source
;;                  `((candidates
;;                     . ,(or (cdr it)
;;                            (lambda ()
;;                              ;; Do not use `source' because other plugins
;;                              ;; (such as helm-migemo) may change it
;;                              (helm-candidates-in-buffer (helm-get-current-source)))))
;;                    (volatile) (match identity)))
;;        source)))

(use-package helm-bm :ensure t)
(use-package helm-css-scss :ensure t)

(require 'helm-bm)
(require 'helm-imenu)
(require 'helm-ring)
(require 'helm-css-scss)

(use-package imenu-anywhere :ensure t)
(require 'imenu-anywhere)

(setq helm-for-current-buffer-sources
      (list helm-source-bm
            helm-source-imenu
            helm-source-imenu-anywhere
            helm-source-mark-ring
            helm-source-bookmarks
            ))

(defun helm-for-current-buffer ()
  (interactive)
  (helm :sources helm-for-current-buffer-sources
        :buffer "*helm-for-current-buffer*"))

;;(require 'helm-ls-git)
(use-package helm-swoop :ensure t)
(require 'helm-swoop)
;; (setq helm-exit-idle-delay nil)

;;; resumable helm/anything buffers
;; (defvar helm-resume-goto-buffer-regexp
;;   (rx (or (regexp "Helm Swoop") "helm imenu" (regexp "helm.+grep") "helm-ag"
;;           "occur"
;;           "*anything grep" "anything current buffer")))
;; (defvar helm-resume-goto-function nil)
;; (defun helm-initialize--resume-goto (resume &rest _)
;;   (when (and (not (eq resume 'noresume))
;;              (ignore-errors
;;                (string-match helm-resume-goto-buffer-regexp helm-last-buffer)))
;;     (setq helm-resume-goto-function
;;           (list 'helm-resume helm-last-buffer))))
;; (advice-add 'helm-initialize :after 'helm-initialize--resume-goto)
;; (defun anything-initialize--resume-goto (resume &rest _)
;;   (when (and (not (eq resume 'noresume))
;;              (ignore-errors
;;                (string-match helm-resume-goto-buffer-regexp anything-last-buffer)))
;;     (setq helm-resume-goto-function
;;           (list 'anything-resume anything-last-buffer))))
;; (advice-add 'anything-initialize :after 'anything-initialize--resume-goto)

;; ;;; next-error/previous-error
;; (defun compilation-start--resume-goto (&rest _)
;;   (setq helm-resume-goto-function 'next-error))
;; (advice-add 'compilation-start :after 'compilation-start--resume-goto)
;; (advice-add 'occur-mode :after 'compilation-start--resume-goto)
;; (advice-add 'occur-mode-goto-occurrence :after 'compilation-start--resume-goto)
;; (advice-add 'compile-goto-error :after 'compilation-start--resume-goto)


;; (defun helm-resume-and- (key)
;;   (unless (eq helm-resume-goto-function 'next-error)
;;     (if (fboundp 'helm-anything-resume)
;;         (setq helm-anything-resume-function helm-resume-goto-function)
;;       (setq helm-last-buffer (cadr helm-resume-goto-function)))
;;     (execute-kbd-macro
;;      (kbd (format "%s %s RET"
;;                   (key-description (car (where-is-internal
;;                                          (if (fboundp 'helm-anything-resume)
;;                                              'helm-anything-resume
;;                                            'helm-resume))))
;;                   key)))
;;     (message "Resuming %s" (cadr helm-resume-goto-function))
;;     t))
;; (defun helm-resume-and-previous ()
;;   "Relacement of `previous-error'"
;;   (interactive)
;;   (or (helm-resume-and- "C-p")
;;       (call-interactively 'previous-error)))
;; (defun helm-resume-and-next ()
;;   "Relacement of `next-error'"
;;   (interactive)
;;   (or (helm-resume-and- "C-n")
;;       (call-interactively 'next-error)))

;; ;;; Replace: next-error / previous-error
;; (ignore-errors (helm-anything-set-keys))
