;;; save-setting.el ---

;; 変更ファイルのバックアップ
(setq make-backup-files nil)

;; 変更ファイルの番号つきバックアップ
(setq version-control nil)

;; 編集中ファイルのバックアップ
(setq auto-save-list-file-name nil)
(setq auto-save-list-file-prefix nil)

;;保存時実行属性付与
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

(load "saveplace")                     ;;前回編集していた場所を記憶
(setq-default save-place t)

(setq delete-auto-save-files t)

(use-package psession :ensure t)
(require 'psession)
(psession-mode 1)

;; (require 'session)
;; (setq session-initialize '(de-saveplace session keys menus places)
;;       session-globals-include '((kill-ring 50)
;;                                   ;;(session-file-alist 500 t)
;;                                   (file-name-history 10000)
;;                                   search-ring regexp-search-ring))
;;   ;; これがないと file-name-history に500個保存する前に max-string に達する
;;(setq session-globals-max-string 100000000)
;; ;;   ;; デフォルトでは30!
;;   (setq history-length t)
;; (setq session-undo-check -1)
;; (add-hook 'after-init-hook 'session-initialize)
;;(add-hook 'after-save-hook 'session-save-session)
;;(setq my-timer-for-session-save-session (run-at-time t 30 'session-save-session))
(require 'recentf) ;;; 最近使ったファイル」を（メニューに）表示する
(setq recentf-max-saved-items 2000)
(setq recentf-exclude '("~/.emacs.d/.recentf"))
;;(setq recentf-auto-cleanup 30)
(recentf-mode 1)

(use-package recentf-ext :ensure t)
(require 'recentf-ext) ;;; 最近使ったファイル」を（メニューに）表示する

(use-package auto-save-buffers-enhanced :ensure t)
(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 1) ; 指定のアイドル秒で保存
(auto-save-buffers-enhanced t)

(require 'bm)
(defun bm-find-files-in-repository ()
  (interactive)
  (cl-loop for (key . _) in bm-repository
           when (file-exists-p key)
           do (find-file-noselect key)))
(defun bm-repository-load-and-open ()
  (interactive)
  (bm-repository-load)
  (bm-find-files-in-repository))

(setq bm-repository-file "~/.emacs.d/.bm-repository")
(setq-default bm-buffer-persistence t)
(setq bm-restore-repository-on-load t)
(add-hook 'after-init-hook 'bm-repository-load-and-open)

(defun bm-buffer-restore-safe ()
  (ignore-errors (bm-buffer-restore)))
(add-hook 'find-file-hooks 'bm-buffer-restore-safe)
(add-hook 'kill-buffer-hook 'bm-buffer-save)

(defun bm-save-to-repository ()
  (interactive)
  (unless noninteractive
    (bm-buffer-save-all)
    (bm-repository-save)))

(add-hook 'kill-emacs-hook 'bm-save-to-repository)
(run-with-idle-timer 30 t 'bm-save-to-repository)
(add-hook 'after-revert-hook 'bm-buffer-restore)
(add-hook 'vc-before-checkin-hook 'bm-buffer-save)
(add-hook 'before-save-hook 'bm-buffer-save)


(add-hook 'kill-emacs-hook '(lambda nil
                              (bm-save-to-repository)
                              (recentf-save-list)
                              ;;(session-save-session)
                              (win-save-all-configurations)
                              ))

(run-with-idle-timer 10 t 'recentf-save-list)

;;Idle Auto Save Buffers
;; (setq win-auto-all-save-timer
;;       (run-with-idle-timer 10 t 'win-save-all-configurations))

;; (setq recentf-auto-save-timer
;;       (run-with-idle-timer 10 t 'recentf-save-list))
;; (setq session-auto-save-timer
;;       (run-with-idle-timer 10 t 'session-save-session))

;; (setq psession-auto-save-timer
;;       (run-with-idle-timer 10 t 'psession-save-winconf))

;; (setq bm-buffer-auto-save-timer
;;       (run-with-idle-timer 10 t 'bm-buffer-save-all))
;; (setq bm-repository-auto-save-timer
;;       (run-with-idle-timer 10 t 'bm-repository-save))
