(setq user-full-name "Gintautas Kazlauskas"
      user-mail-address "gintautaskazlauskas@protonmail.com"
      display-line-numbers-type 't
      doom-font (font-spec :family "FuraCode Nerd Font Mono" :size 15 :weight 'medium)
      org-directory "~/.org/"
      auth-sources '("~/.authinfo.gpg")
      )

;; Maximize on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Speed up company mode
(setq company-idle-delay 0
      company-minimum-prefix-length 1)

;; Theme
(setq doom-theme 'magic-girl)

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

;; Smooth scrolling
(setq pixel-scroll-precision-use-momentum 't)
(pixel-scroll-mode 1)
(pixel-scroll-precision-mode 1)
