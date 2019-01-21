;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(
    ;; Python
    better-defaults
    ein
    elpy
    flycheck
    py-autopep8
    ;; FRONTEND
    web-mode
    ;; VUE
    vue-mode
    ;; OTHER
    auto-complete
    atom-one-dark-theme
    hackernews
    neotree
    rainbow-delimiters
))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

;;(setq inhibit-startup-message t) ;; hide the startup message

(global-linum-mode t) ;; enable line numbers globally

(load-theme 'atom-one-dark t) ;; load theme

;; we need to be able to type M-3 to get a hash
(fset 'insertHash "#")
(global-set-key (kbd "M-3") 'insertHash)

;; set font and font size
(set-face-attribute 'default nil :height 140) ;; 14px

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i --simple-prompt")

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

;; GUI stuff

;; split window into 3 to get cracking
(defun split-3-windows-horizontally-evenly ()
  (interactive)
  (command-execute 'split-window-horizontally)
  (command-execute 'split-window-horizontally)
  (command-execute 'balance-windows)
)

;; no scrollbars, thanks
(scroll-bar-mode -1)

;; bigger window on load
(when window-system (set-frame-size (selected-frame) 200 60))

;; neotree
(global-set-key [f8] 'neotree-toggle)

;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (atom-one-dark-theme vue-mode py-autopep8 material-theme flycheck elpy ein better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
