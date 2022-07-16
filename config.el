(setq user-full-name "Gintautas Kazlauskas"
      user-mail-address "gintautaskazlauskas@protonmail.com"
      display-line-numbers-type 't
      doom-font (font-spec :family "Iosevka" :size 18 :weight 'medium)
      org-directory "~/.org/"
      auth-sources '("~/.authinfo.gpg")
      )

;; Maximize on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Theme
(setq doom-theme 'modus-vivendi)

;; Key maps
(map! :leader
      "r" #'+hydra/window-nav/body
      "c z" #'lsp-ui-doc-glance
      )

(map! :mode smerge-mode
      "C-k" #'smerge-keep-upper
      "C-j" #'smerge-keep-lower
      )

;; Splash
(setq fancy-splash-image (concat doom-private-dir "splash.png"))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;; Discord
(require 'elcord)
(elcord-mode)
(setq elcord-editor-icon 'emacs_material_icon)

;; Switch to new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Smooth scrolling
(setq pixel-scroll-precision-use-momentum 't)
(pixel-scroll-mode 1)
(pixel-scroll-precision-mode 1)

;; Corfu
(global-corfu-mode)
(add-hook 'eglot-mode-hook #'corfu-mode)
(add-hook 'corfu-mode-hook #'corfu-doc-mode)
(setq
  corfu-cycle t
  corfu-auto t
  corfu-quit-no-match 'separator
  corfu-auto-prefix 1
  completion-styles '(basic))

;; Tree sitter
(global-tree-sitter-mode)
(add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode)
