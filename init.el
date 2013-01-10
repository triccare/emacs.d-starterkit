;; Setup the starter kit.
(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Basic defaults
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

;; Show all non-ascii characters in a buffer
(defun occur-non-ascii ()
  "Find any non-ascii characters in the current buffer."
  (interactive)
  (occur "[^[:ascii:]]"))

;;;;;;;;;;;;;;;;;
; Other specifics
(set-background-color "black")
(set-foreground-color "DarkOrange")
(set-face-background 'region "DarkSlateGray")
(set-cursor-color "gainsboro")
(global-set-key (kbd "C-<f13>") 'other-window)
