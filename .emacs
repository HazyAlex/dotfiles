;; Make startup faster by reducing the frequency of garbage collection.
(eval-and-compile
  (setq gc-cons-threshold 402653184
        gc-cons-percentage 0.6))


;; ==========================
;;  MELPA  & Visual settings
;; ==========================
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(eval-when-compile
  (require 'use-package))


(setq inhibit-startup-screen t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)
(show-paren-mode t)
(set-frame-font "Fira Code Retina-13" nil t)

(setq backup-directory-alist
`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*", temporary-file-directory t)))

(setq delete-by-moving-to-trash t)

(setq visible-bell 1)

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)

;; ==================
;;  CUSTOM FUNCTIONS
;; ==================
(defun split-and-follow-horizontally ()
  (interactive)
  (split-window-below)
  (balance-windows)
  (other-window 1))

(defun split-and-follow-vertically ()
  (interactive)
  (split-window-right)
  (balance-windows)
  (other-window 1))

(global-set-key (kbd "C-x 2") 'split-and-follow-horizontally)
(global-set-key (kbd "C-x 3") 'split-and-follow-vertically)

;; ==========
;;  PACKAGES
;; ==========
(use-package smex
  :bind (("M-x" . smex)
	 ("M-X" . smex-major-mode-commands)
	 ("C-c C-c M-x" . execute-extended-command)))

(ido-mode 1)
(global-subword-mode 1)

(use-package which-key
  :defer 2
  :config (which-key-mode))

(use-package smart-hungry-delete
  :defer 2
  :init (smart-hungry-delete-add-default-hooks)
  :bind (("<backspace>" . smart-hungry-delete-backward-char)
         ("C-d"         . smart-hungry-delete-forward-char)))

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-bullets-bullet-list '("◉" "○" "●" "✿")))

(use-package company
  :defer 1
  :config (global-company-mode))

(use-package evil
  :config (evil-mode 1))

;; ========
;;  CUSTOM
;; ========
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(company-quickhelp-color-background "#e8e8e8")
 '(company-quickhelp-color-foreground "#444444")
 '(custom-enabled-themes (quote (solarized-light)))
 '(custom-safe-themes
   (quote
    ("c433c87bd4b64b8ba9890e8ed64597ea0f8eb0396f4c9a9e01bd20a04d15d358" "d91ef4e714f05fff2070da7ca452980999f5361209e679ee988e3c432df24347" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "19b9349a6b442a2b50e5b82be9de45034f9b08fa36909e0b1be09433234610bb" default)))
 '(fci-rule-color "#eeeeee")
 '(nrepl-message-colors
   (quote
    ("#8f4e8b" "#8f684e" "#c3a043" "#397460" "#54ab8e" "#20a6ab" "#3573b1" "#DC8CC3")))
 '(package-selected-packages
   (quote
    (ox-gfm spacemacs-theme hungry-delete solarized-theme evil markdown-mode tramp use-package company company-c-headers company-math org-bullets smart-hungry-delete which-key smex helm-smex)))
 '(vc-annotate-background "#f9f9f9")
 '(vc-annotate-color-map
   (quote
    ((20 . "#844880")
     (40 . "#8f4e8b")
     (60 . "#8f684e")
     (80 . "#cfb56e")
     (100 . "#c3a043")
     (120 . "#c3a043")
     (140 . "#2a5547")
     (160 . "#397460")
     (180 . "#3b7863")
     (200 . "#438972")
     (220 . "#4c9a80")
     (240 . "#54ab8e")
     (260 . "#20a6ab")
     (280 . "#234d76")
     (300 . "#295989")
     (320 . "#2e659c")
     (340 . "#3573b1")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold 16777216
      gc-cons-percentage 0.1)
