;; Setup the starter kit.
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(direx elpy jedi starter-kit starter-kit-lisp starter-kit-bindings starter-kit-eshell starter-kit-js starter-kit-ruby multi-web-mode yaml-mode haml-mode scss-mode color-theme)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Basic defaults
(add-to-list 'load-path "~/.emacs.d/elisp/bin") ; Generic script area.
(setq-default auto-save-default nil) ;Do not autosave.
(setq-default backup-inhibited t)    ;Do not create ~ files.
(setq-default indent-tabs-mode nil)  ;No tabs: required for HAML, and I just hate them anyways.
(setq-default js-indent-level 2)     ;Javascript indent level.

;; Use Emacs 'ls' implementation, basically to sort folders
;; separately from files.
(require 'ls-lisp)
(setq-default ls-lisp-use-insert-directory-program nil)
(setq-default ls-lisp-dirs-first t)
(setq ls-lisp-ignore-case t)

;; el-get package management system.
;; (add-to-list 'load-path "~/.emacs.d/el-get/el-get")

;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (let (el-get-master-branch)
;;       (goto-char (point-max))
;;       (eval-print-last-sexp))))

;; (el-get 'sync)
;; (setq el-get-user-package-directory "~/.emacs.d/el-get-init-files/")

;; PHP mode
(setq warning-suppress-types nil) ;Needed so the following does not fail.
(add-to-list 'load-path "~/.emacs.d/elisp/php-mode-1.5.0")
(require 'php-mode)

;; Multi-web-mode
;(add-to-list 'load-path "~/.emacs.d/elisp/multi-web-mode")
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5" "inc" "aspx"))
(multi-web-global-mode 1)

;; YAML
;(add-to-list 'load-path "~/.emacs.d/elisp/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

;; HAML
;(add-to-list 'load-path "~/.emacs.d/elisp/haml-mode")
(require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))
(add-to-list 'auto-mode-alist '("\\.hamljs$" . haml-mode))

;; SCSS mode
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp/scss-mode"))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(setq-default scss-compile-at-save nil);
(setq-default css-indent-offset 2);

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; General python setup

;; JEDI: Python autocomplete
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(add-hook 'ein:connect-mode-hook 'ein:jedi-setup)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp/emacs-jedi-direx"))
(require 'jedi-direx)
(eval-after-load "python"
  '(define-key python-mode-map "\C-cx" 'jedi-direx:pop-to-buffer))

;; elpy
(elpy-enable)
(elpy-use-ipython)
(elpy-clean-modeline)

;; pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; Generic functions


;; Show all non-ascii characters in a buffer
(defun occur-non-ascii ()
  "Find any non-ascii characters in the current buffer."
  (interactive)
  (occur "[^[:ascii:]]"))

;;;;;;;;;;;;;;;;;
;; Theme setup
(setq color-theme-is-global t)
(color-theme-initialize)
;(color-theme-jsc-dark)
;(color-theme-infodoc)
;(color-theme-jb-simple)
;(color-theme-jb-katester)
;(color-theme-jb-ld-dark)
;(color-theme-jb-resolve)
;(color-theme-jb-retro-orange)
(color-theme-whateveryouwant)
;(color-theme-xp)
;(color-theme-xemacs)

;;;;;;;;;;;;;;;;;
; Other specifics
;(set-background-color "grey20")
;(set-foreground-color "DarkOrange")
;(set-face-background 'region "DarkSlateGray")
;(set-cursor-color "gainsboro")

(setq ispell-program-name "/usr/local/bin/ispell")

;; Start as a server
(server-start)
