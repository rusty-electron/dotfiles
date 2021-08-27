(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(unless (package-installed-p 'spacemacs-theme)
  (package-refresh-contents)
  (package-install 'spacemacs-theme))

(unless (package-installed-p 'evil)
  (package-refresh-contents)
  (package-install 'evil))

;; org file start

(org-babel-load-file (expand-file-name "~/.emacs.d/config.org")) 

;; (global-set-key (kbd "<s-return>") 'ansi-term)

;; org file end
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default))
 '(package-selected-packages
   '(projectile markdown-mode fzf fzf\.el symon diminish spaceline company-mode space-line company dashboard rainbow-delimiters sudo-edit hungry-delete switch-window rainbow-mode avy smex ido-vertical-mode org-bullets beacon spacemacs-dark spacemacs-theme which-key use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :extend nil :stipple nil :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "ADBO" :family "Iosevka")))))
