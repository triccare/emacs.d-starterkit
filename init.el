;; Start as a server
(server-start)

;; Setup the starter kit.
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(undo-tree
                      direx
                      elpy
                      jedi
                      starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      starter-kit-js
                      yaml-mode
                      haml-mode
                      scss-mode
                      jedi-direx)
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

;; Replace the undo system
(global-undo-tree-mode)

;; Use Emacs 'ls' implementation, basically to sort folders
;; separately from files.
(require 'ls-lisp)
(setq-default ls-lisp-use-insert-directory-program nil)
(setq-default ls-lisp-dirs-first t)
(setq ls-lisp-ignore-case t)

;; PHP mode
(setq warning-suppress-types nil) ;Needed so the following does not fail.
(add-to-list 'load-path "~/.emacs.d/elisp/php-mode-1.5.0")
(require 'php-mode)

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
;(add-to-list 'load-path "~/.emacs.d/elisp/themes")
;(autoload 'color-theme-jde-whateveryouwant "jde-whateveryouwant")
;(setq color-theme-is-global t)
;(color-theme-initialize)
;(color-theme-jde-whateveryouwant)
;(color-theme-jsc-dark)
;(color-theme-infodoc)
;(color-theme-jb-simple)
;(color-theme-jb-katester)
;(color-theme-jb-ld-dark)
;(color-theme-jb-resolve)
;(color-theme-jb-retro-orange)
;(color-theme-whateveryouwant)
;(color-theme-xp)
;(color-theme-xemacs)

;;;;;;;;;;;;;;;;;
; Other specifics
;(set-background-color "grey20")
;(set-foreground-color "DarkOrange")
;(set-face-background 'region "DarkSlateGray")
;(set-cursor-color "gainsboro")

;(setq ispell-program-name "/usr/local/bin/ispell")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes (quote (misterioso))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
