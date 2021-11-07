;; ==========================
;;  MELPA  & Visual settings
;; ==========================

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)

(eval-when-compile
  (require 'use-package))

;; Set GC to 512MB or 5 sec idle
(setq gc-cons-threshold (* 512 1024 1024))
(setq gc-cons-percentage 0.5)
(run-with-idle-timer 5 t #'garbage-collect)

(setq inhibit-startup-screen t)
(setq inhibit-startup-message t)
(put 'inhibit-startup-echo-area-message 'saved-value t)
(setq inhibit-startup-echo-area-message (user-login-name))
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode -1)
(setq show-paren-delay 0)
(setq show-paren-style 'parenthesis) ;; 'mixed, 'expression
(show-paren-mode 1)
(blink-cursor-mode 0)

;; Wrap text
(add-hook 'text-mode-hook 'visual-line-mode)

(defun gui/remove-fringe ()
  "Romove fringe margin - wrapped lines indicator"
  (fringe-mode '(0 . 0))
  (remove-hook 'focus-in-hook #'gui/remove-fringe))

(add-hook 'focus-in-hook #'gui/remove-fringe)
;; Reload changed files automatically
(global-auto-revert-mode t)

;; UTF-8
(prefer-coding-system 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq coding-system-for-write 'utf-8)
(set-language-environment 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(unless (eq system-type 'windows-nt)
  (set-selection-coding-system 'utf-8))
(setq buffer-file-coding-system 'utf-8)

(setq backup-directory-alist
`((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*", temporary-file-directory t)))

;; Windows only - More memory usage for performance
(setq inhibit-compacting-font-caches t)

(setq delete-by-moving-to-trash t)
(setq visible-bell 1)
(defalias 'yes-or-no-p 'y-or-n-p)

;; set window title
(setq frame-title-format '("" "%b"))


;; Font settings
(setq default-frame-alist '((font . "Fira Code Retina-12")))
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))

(setq line-spacing 0.1)

;; Fira Code ligatures
;; This works when using emacs --daemon + emacsclient
(add-hook 'after-make-frame-functions (lambda (frame) (set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")))

;; This works when using emacs without server/client
(set-fontset-font t '(#Xe100 . #Xe16f) "Fira Code Symbol")
(defconst fira-code-font-lock-keywords-alist
(mapcar (lambda (regex-char-pair)
	  `(,(car regex-char-pair)
	    (0 (prog1 ()
		 (compose-region (match-beginning 1)
				 (match-end 1)
				 ;; The first argument to concat is a string containing a literal tab
				 ,(concat "	" (list (decode-char 'ucs (cadr regex-char-pair)))))))))
	'(("[^=]\\(:=\\)"                #Xe10c)
	  ("\\(!=\\)"                    #Xe10e)
	  ("\\(!==\\)"                   #Xe10f)
	  ("\\(-->\\)"                   #Xe113)
	  ("[^-]\\(->\\)"                #Xe114)
	  ("\\(->>\\)"                   #Xe115)
	  ("\\(-<\\)"                    #Xe116)
	  ("\\(-<<\\)"                   #Xe117)
	  ("\\(-~\\)"                    #Xe118)
	  ("\\(#{\\)"                    #Xe119)
	  ("\\(#\\[\\)"                  #Xe11a)
	  ("\\(##\\)"                    #Xe11b)
	  ("\\(###\\)"                   #Xe11c)
	  ("\\(####\\)"                  #Xe11d)
	  ("\\(#(\\)"                    #Xe11e)
	  ("\\(#\\?\\)"                  #Xe11f)
	  ("\\(#_\\)"                    #Xe120)
	  ("\\(#_(\\)"                   #Xe121)
	  ("\\(\\.-\\)"                  #Xe122)
	  ("\\(\\.=\\)"                  #Xe123)
	  ("\\(\\?=\\)"                  #Xe127)
	  ("\\(/=\\)"                    #Xe12c)
	  ("\\(/==\\)"                   #Xe12d)
	  ("\\(/>\\)"                    #Xe12e)
	  ("\\(&&\\)"                    #Xe131)
	  ("\\(||\\)"                    #Xe132)
	  ("\\(||=\\)"                   #Xe133)
	  ("[^|]\\(|=\\)"                #Xe134)
	  ("\\(|>\\)"                    #Xe135)
	  ("\\(\\^=\\)"                  #Xe136)
	  ("\\(\\$>\\)"                  #Xe137)
	  ("\\(\\+>\\)"                  #Xe13a)
	  ("\\(=:=\\)"                   #Xe13b)
	  ("[^!/]\\(==\\)[^>]"           #Xe13c)
	  ("\\(===\\)"                   #Xe13d)
	  ("\\(==>\\)"                   #Xe13e)
	  ("[^=]\\(=>\\)"                #Xe13f)
	  ("\\(=>>\\)"                   #Xe140)
	  ("\\(<=\\)"                    #Xe141)
	  ("\\(=<<\\)"                   #Xe142)
	  ("\\(=/=\\)"                   #Xe143)
	  ("\\(>-\\)"                    #Xe144)
	  ("\\(>=\\)"                    #Xe145)
	  ("\\(>=>\\)"                   #Xe146)
	  ("[^-=]\\(>>\\)"               #Xe147)
	  ("\\(>>-\\)"                   #Xe148)
	  ("\\(>>=\\)"                   #Xe149)
	  ("\\(>>>\\)"                   #Xe14a)
	  ("\\(<\\*\\)"                  #Xe14b)
	  ("\\(<\\*>\\)"                 #Xe14c)
	  ("\\(<|\\)"                    #Xe14d)
	  ("\\(<|>\\)"                   #Xe14e)
	  ("\\(<!--\\)"                  #Xe151)
	  ("\\(<-\\)"                    #Xe152)
	  ("\\(<--\\)"                   #Xe153)
	  ("\\(<->\\)"                   #Xe154)
	  ("\\(<\\+\\)"                  #Xe155)
	  ("\\(<\\+>\\)"                 #Xe156)
	  ("\\(<=\\)"                    #Xe157)
	  ("\\(<==\\)"                   #Xe158)
	  ("\\(<=>\\)"                   #Xe159)
	  ("\\(<=<\\)"                   #Xe15a)
	  ("[^-=]\\(<<\\)"               #Xe15c)
	  ("\\(<<-\\)"                   #Xe15d)
	  ("\\(<<=\\)"                   #Xe15e)
	  ("\\(<<<\\)"                   #Xe15f)
	  ("\\(<~\\)"                    #Xe160)
	  ("\\(<~~\\)"                   #Xe161)
	  ("\\(</\\)"                    #Xe162)
	  ("\\(</>\\)"                   #Xe163)
	  ("\\(~@\\)"                    #Xe164)
	  ("\\(~-\\)"                    #Xe165)
	  ("\\(~=\\)"                    #Xe166)
	  ("\\(~>\\)"                    #Xe167)
	  ("[^<]\\(~~\\)"                #Xe168)
	  ("\\(~~>\\)"                   #Xe169)
	  ("[^:=]\\(:\\)[^:=]"           #Xe16c)
	  ("[^\\+<>]\\(\\+\\)[^\\+<>]"   #Xe16d)
	  ("[^\\*/<>]\\(\\*\\)[^\\*/<>]" #Xe16f))))

(defun add-fira-code-symbol-keywords ()
  (font-lock-add-keywords nil fira-code-font-lock-keywords-alist))
(add-hook 'prog-mode-hook 'add-fira-code-symbol-keywords)
;; (add-hook
;;  'python-mode-hook
;;  (lambda ()
;;    (mapc (lambda (pair) (push pair prettify-symbols-alist))
;;          '(("in"       . #x2208)
;;            ("not in"   . #x2209)
;;            ("return"   . #x27fc)
;;            ("yield"    . #x27fb)
;;            ("for"      . #x2200)
;;            ("int"      . #x2124)
;;            ("float"    . #x211d)
;;            ("True"     . #x1d54b)
;;            ("False"    . #x1d53d)))))


;; Change theme on keybind, and a fix for org-mode colors
(use-package doom-themes
  :config
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

(defun disable-all-themes ()
    (while custom-enabled-themes
      (disable-theme (car custom-enabled-themes))))

(global-set-key (kbd "C-<f1>")
                (lambda () (interactive)
		  (disable-all-themes)
                  (load-theme 'spacemacs-light t)
		  (set-face-attribute 'org-hide nil
				      :background
				      (face-attribute 'default :background)
				      :foreground
				      (face-attribute 'default :background))))

(global-set-key (kbd "C-<f2>")
                (lambda () (interactive)
		  (disable-all-themes)
                  (load-theme 'cyberpunk t)
		  (set-face-attribute 'org-hide nil
				      :background
				      (face-attribute 'default :background)
				      :foreground
				      (face-attribute 'default :background))))

;; Escape ALWAYS Quits
;; (define-key evil-normal-state-map [escape] 'keyboard-quit)
;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
;; (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
;; (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
;; (global-set-key [escape] 'keyboard-quit)

;; ==========
;;  PACKAGES
;; ==========
(use-package smex
  :init 
  (ido-mode 1)
  :bind (("M-x" . smex)
	 ("M-X" . smex-major-mode-commands)
	 ("C-c C-c M-x" . execute-extended-command)))

(use-package which-key
  :defer 2
  :diminish which-key-mode
  :config (which-key-mode))

(use-package recentf
    :bind ("\C-x\ \C-r" . recentf-open-files)
    :config
        (setq recentf-max-menu-items 25)
        (setq recentf-max-saved-items 25)
        (setq recentf-keep '(file-remote-p file-readable-p)))


;; Dim buffers that are not used
(use-package dimmer
  :init (dimmer-mode t)
  :config (setq dimmer-fraction 0.3))


;; Evil Mode
(use-package evil
  :init (evil-mode 1)
  :config
  (defun evil-command-window-ex nil) ;; Disable command history
  (define-key evil-normal-state-map (kbd "C-u") 'evil-scroll-up)
  (define-key evil-visual-state-map (kbd "C-u") 'evil-scroll-up))
  ;; https://github.com/emacs-evil/evil/issues/721
  ;; Treat underscores as part of the word
  ;; (add-hook 'after-change-major-mode-hook
  ;; 	    (lambda ()
  ;; 	      (modify-syntax-entry ?_ "w"))))


;; Creating: C-n / C-p
;; Cycling:  M-n / M-p
;; Skip: C-t
(use-package evil-mc
  :init (global-evil-mc-mode 1)
  :config
  (define-key evil-normal-state-map (kbd "gn") 'evil-mc-make-and-goto-next-match)
  (define-key evil-normal-state-map (kbd "gp") 'evil-mc-make-and-goto-prev-match)
  (define-key evil-normal-state-map [escape] 'evil-mc-undo-all-cursors))

(use-package evil-commentary
  :init (evil-commentary-mode))
;; (define-key evil-normal-state-map (kbd "gc") 'evil-commentary)
;; (define-key evil-normal-state-map (kbd "gy") 'evil-commentary-yank))


(use-package org-evil)


(use-package smart-hungry-delete
  :init (smart-hungry-delete-add-default-hooks)
  :config
  (global-set-key (kbd "<backspace>") 'smart-hungry-delete-backward-char)
  (global-set-key (kbd "C-d") 'smart-hungry-delete-forward-char))


;; ORG
(use-package org-bullets
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  (setq org-bullets-bullet-list '("◉" "○" "●" "✿"))
  ;; (setq org-pretty-entities t
  ;; 	org-hide-leading-stars t
  ;; 	org-hide-emphasis-markers t
  ;; 	org-fontify-whole-heading-line t
  ;; 	org-fontify-done-headline t
  ;; 	org-fontify-quote-and-verse-blocks t)
  ;; Pretty Checkboxes - Not working?
  (add-hook 'org-mode-hook (lambda ()
			     "Beautify Org Checkbox Symbol"
			     (push '("[ ]" . "☐") prettify-symbols-alist)
			     (push '("[X]" . "☑") prettify-symbols-alist)
			     (push '("[-]" . "❍") prettify-symbols-alist)
			     (prettify-symbols-mode)))
  (defface org-checkbox-done-text
    '((t (:foreground "#71696A")))
    "Face for the text part of a checked org-mode checkbox."))


(use-package company
  :defer 1
  :diminish company-mode
  :config (global-company-mode))


(use-package projectile
  :init (projectile-mode +1)
  :diminish projectile-mode
  :config
  (define-key projectile-mode-map (kbd "<f2>") 'projectile-command-map)
  (define-key evil-ex-map "g" 'projectile-grep)
  (define-key evil-ex-map "f" 'projectile-find-file)
  (define-key evil-normal-state-map "\\" 'projectile-find-file)
  (setq projectile-use-native-indexing t)
  (setq projectile-enable-caching t))


(use-package diminish
  :ensure t
  :init
  (diminish 'evil-mc-mode)
  (diminish 'undo-tree-mode)
  (diminish 'eldoc-mode)
  (diminish 'recentf-mode)
  (diminish 'abbrev-mode)
  (diminish 'evil-commentary-mode))

;; --------
;;  C, C++
;; --------
(add-hook 'c-mode-common-hook
  (lambda() 
    (define-key evil-normal-state-map (kbd "C-\\") 'ff-find-other-file)))

(use-package clang-format+
  :init (add-hook 'c-mode-common-hook #'clang-format+-mode)
  :diminish clang-format+-mode
  :config
  (setq c-default-style "linux"
	c-basic-offset 4))

(setq compilation-window-height 9)

(defun ct/create-proper-compilation-window ()
  "Setup the *compilation* window with custom settings."
  (when (not (get-buffer-window "*compilation*"))
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer "*compilation*")
          ;; Reduce window height
          (shrink-window (- h compilation-window-height))
          ;; Prevent other buffers from displaying inside
          (set-window-dedicated-p w t))))))

;; Set compilation window
(add-hook 'compilation-mode-hook 'ct/create-proper-compilation-window)

;; Rust
(use-package rust-mode)

(use-package lsp-mode
  :config
  (setq lsp-rust-server 'rust-analyzer)
  (setq lsp-enable-snippet nil))


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
 '(ansi-color-names-vector
   ["#323f4e" "#f48fb1" "#53e2ae" "#f1fa8c" "#92b6f4" "#BD99FF" "#79e6f3" "#f8f8f2"])
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(custom-enabled-themes '(cyberpunk))
 '(custom-safe-themes
   '("c4bdbbd52c8e07112d1bfd00fee22bf0f25e727e95623ecb20c4fa098b74c1bd" "b89a4f5916c29a235d0600ad5a0849b1c50fab16c2c518e1d98f0412367e7f97" "890a1a44aff08a726439b03c69ff210fe929f0eff846ccb85f78ee0e27c7b2ea" "819ab08867ef1adcf10b594c2870c0074caf6a96d0b0d40124b730ff436a7496" "71e5acf6053215f553036482f3340a5445aee364fb2e292c70d9175fb0cc8af7" "3d3807f1070bb91a68d6638a708ee09e63c0825ad21809c87138e676a60bda5d" "34b3219ae11acd81b2bb7f3f360505019f17d7a486deb8bb9c1b6d13c6616d2e" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "e1ef2d5b8091f4953fe17b4ca3dd143d476c106e221d92ded38614266cea3c8b" "b5fff23b86b3fd2dd2cc86aa3b27ee91513adaefeaa75adc8af35a45ffb6c499" "2cdc13ef8c76a22daa0f46370011f54e79bae00d5736340a5ddfe656a767fddf" "6c3b5f4391572c4176908bb30eddc1718344b8eaff50e162e36f271f6de015ca" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "2809bcb77ad21312897b541134981282dc455ccd7c14d74cc333b6e549b824f3" "aded61687237d1dff6325edb492bde536f40b048eab7246c61d5c6643c696b7f" "4cf9ed30ea575fb0ca3cff6ef34b1b87192965245776afa9e9e20c17d115f3fb" "79278310dd6cacf2d2f491063c4ab8b129fee2a498e4c25912ddaa6c3c5b621e" "5d09b4ad5649fea40249dd937eaaa8f8a229db1cec9a1a0ef0de3ccf63523014" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "3c2f28c6ba2ad7373ea4c43f28fcf2eed14818ec9f0659b1c97d4e89c99e091e" "bf387180109d222aee6bb089db48ed38403a1e330c9ec69fe1f52460a8936b66" "9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "e2acbf379aa541e07373395b977a99c878c30f20c3761aac23e9223345526bcc" "912cac216b96560654f4f15a3a4d8ba47d9c604cbc3b04801e465fb67a0234f0" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "d71aabbbd692b54b6263bfe016607f93553ea214bc1435d17de98894a5c3a086" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default))
 '(fci-rule-color "#5c5e5e")
 '(highlight-changes-colors '("#d33682" "#6c71c4"))
 '(highlight-symbol-colors
   '("#3b6b40f432d6" "#07b9463c4d36" "#47a3341e358a" "#1d873c3f56d5" "#2d86441c3361" "#43b7362d3199" "#061d417f59d7"))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   '(("#073642" . 0)
     ("#5b7300" . 20)
     ("#007d76" . 30)
     ("#0061a8" . 50)
     ("#866300" . 60)
     ("#992700" . 70)
     ("#a00559" . 85)
     ("#073642" . 100)))
 '(hl-bg-colors
   '("#866300" "#992700" "#a7020a" "#a00559" "#243e9b" "#0061a8" "#007d76" "#5b7300"))
 '(hl-fg-colors
   '("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36"))
 '(hl-paren-colors '("#2aa198" "#b58900" "#268bd2" "#6c71c4" "#859900"))
 '(hl-sexp-background-color "#efebe9")
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(inhibit-startup-echo-area-message nil)
 '(jdee-db-active-breakpoint-face-colors (cons "#0d0d0d" "#81a2be"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0d0d0d" "#b5bd68"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0d0d0d" "#5a5b5a"))
 '(lsp-ui-doc-border "#93a1a1")
 '(nrepl-message-colors
   '("#dc322f" "#cb4b16" "#b58900" "#5b7300" "#b3c34d" "#0061a8" "#2aa198" "#d33682" "#6c71c4"))
 '(objed-cursor-color "#cc6666")
 '(package-selected-packages
   '(cyberpunk-theme dimmer diminish evil-mc rust-mode lsp-mode clang-format+ projectile spacemacs-theme doom-themes org-evil evil-commentary which-key use-package smex smart-hungry-delete org-bullets hungry-delete evil company))
 '(pdf-view-midnight-colors (cons "#f8f8f2" "#323f4e"))
 '(pixel-scroll-mode nil)
 '(pos-tip-background-color "#073642")
 '(pos-tip-foreground-color "#93a1a1")
 '(recentf-mode t)
 '(rustic-ansi-faces
   ["#1d1f21" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#c9b4cf" "#8abeb7" "#c5c8c6"])
 '(server-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(vc-annotate-background "#1d1f21")
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   (list
    (cons 20 "#b5bd68")
    (cons 40 "#c8c06c")
    (cons 60 "#dcc370")
    (cons 80 "#f0c674")
    (cons 100 "#eab56d")
    (cons 120 "#e3a366")
    (cons 140 "#de935f")
    (cons 160 "#d79e84")
    (cons 180 "#d0a9a9")
    (cons 200 "#c9b4cf")
    (cons 220 "#ca9aac")
    (cons 240 "#cb8089")
    (cons 260 "#cc6666")
    (cons 280 "#af6363")
    (cons 300 "#936060")
    (cons 320 "#765d5d")
    (cons 340 "#5c5e5e")
    (cons 360 "#5c5e5e")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#002b36" "#073642" "#a7020a" "#dc322f" "#5b7300" "#859900" "#866300" "#b58900" "#0061a8" "#268bd2" "#a00559" "#d33682" "#007d76" "#2aa198" "#839496" "#657b83"))
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-level-1 ((t (:inherit bold :foreground "#ff1493" :weight bold :height 1.1))))
 '(org-level-2 ((t (:inherit bold :foreground "#2aa198" :weight bold :height 1.05))))
 '(org-level-3 ((t (:foreground "#5faf00" :weight normal :height 1.05)))))
