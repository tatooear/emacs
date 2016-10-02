;;; compile-setting.el ---

;; ================================
;; compile
;; ================================
(use-package auto-async-byte-compile :ensure t)
(require 'auto-async-byte-compile)
(setq auto-async-byte-compile-exclude-files-regexp ".revive.el")
(add-hook 'emacs-lisp-mode-hook 'enable-auto-async-byte-compile-mode)

;; ================================
;; flycheck
;; ================================
(use-package flycheck :ensure t)
(use-package flycheck-pos-tip :ensure t)

(require 'flycheck) ;; 文法チェック
(require 'flycheck-pos-tip)

;; ================================
;; git
;; ================================
(use-package magit :ensure t)
(require 'magit)
