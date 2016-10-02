;;; .emacs --- dot emacs file

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.

;; This file is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
;; PURPOSE.  See the GNU General Public License for more details.

;; You should have received a copy of the GNU General Public
;; License along with this file; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.

;;; Code:

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ site-lisp                                                     ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; (let ( (default-directory
;;          (file-name-as-directory (concat user-emacs-directory "site-lisp")))
;;        )
;;   (add-to-list 'load-path default-directory)
;;   (normal-top-level-add-subdirs-to-load-path)
;;   )

;;(add-to-list 'load-path "~/.emacs.d")

(defun add-to-load-path (&rest paths)
  (let (path)
    (dolist (path paths paths)
      (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
        (add-to-list 'load-path default-directory)
        (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
            (normal-top-level-add-subdirs-to-load-path))))))

;; elispとconfディレクトリをサブディレクトリごとload-pathに追加
(add-to-load-path "elpa" "git" )

;; パスを追加する
;; (add-to-list 'exec-path "/opt/local/bin")
;; (add-to-list 'exec-path "/opt/local/sbin")
;; (add-to-list 'exec-path "/usr/local/sbin")
;; (add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/inits")
(add-to-list 'load-path "~/.emacs.d/elpa")
(add-to-list 'load-path "~/.emacs.d/git")
;; (add-to-list 'exec-path "C:/Users/tokushou/gnupack/app/cygwin/cygwin/bin")
;; (add-to-list 'exec-path "C:/Users/tokushou/gnupack/app/cygwin/cygwin/usr/bin")
;; (add-to-list 'exec-path "C:/Users/tokushou/gnupack/app/cygwin/cygwin/usr/local/bin")
;; (add-to-list 'exec-path "/bin")
;; (add-to-list 'exec-path "/usr/bin")
;; (add-to-list 'exec-path "/usr/local/bin")
;;(add-to-list 'exec-path "c:/users/tokushou/gnupack/home/.emacs.d")
;;(add-to-list 'exec-path "c:/users/tokushou/gnupack/home/.emacs.d/site-lisp")

;;@ setup-cygwin
;; (setq cygwin-mount-cygwin-bin-directory
;; (concat (getenv "CYGWIN_DIR") "\\bin"))

;;(require 'setup-cygwin)
(require 'cl-lib)
;; (require 'exec-path-from-shell)
;; (exec-path-from-shell-initialize)

;; elpa
(require 'package)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; (when (not (package-installed-p 'use-package))
;;   (package-refresh-contents)
;;   (package-install 'use-package))
(require 'use-package)

;; emacsclient
(require 'server)
;;(server-start)
(when (and (>= emacs-major-version 23)
           (equal window-system 'w32))
  (defun server-ensure-safe-dir (dir) "Noop" t))
  ; Suppress error "directory ~/.emacs.d/server is unsafe" on windows.
(unless (server-running-p)
  (server-start))
(remove-hook
  'kill-buffer-query-functions
  'server-kill-buffer-query-function)

;; (use-package init-loader
;;              :ensure t)
(require 'init-loader)
(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")
(put 'downcase-region 'disabled nil)
