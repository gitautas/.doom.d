(setq user-full-name "Gintautas Kazlauskas"
      user-mail-address "gintautas.kazlauskas@hopin.to"
      display-line-numbers-type 't
      doom-font (font-spec :family "FuraCode Nerd Font Mono" :size 15 :weight 'medium)
      org-directory "~/.org/"
      auth-sources '("~/.authinfo.gpg")
      )


;; Maximize on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Speed up company mode
(setq company-dabbrev-downcase 0
      company-idle-delay 0
      company-minimum-prefix-length 1)

;; Theme
(setq doom-theme 'magic-girl)
;; (setq doom-theme 'doom-dracula)

;; Hide modeline in popup
(remove-hook 'emacs-everywhere-init-hooks #'hide-mode-line-mode)

;; Switch to new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; Key maps
(map! :leader
      "r" #'+hydra/window-nav/body
      "c z" #'lsp-ui-doc-glance
      "o w" #'xwidget-webkit-browse-url
      )

(map! :leader
      :prefix "d"
      "l" (prog1
              #'lsp-workspace-restart
              #'lsp)
      )

;;; Lang

;;V
(add-to-list 'auto-mode-alist '("\\(\\.v?v\\|\\.vsh\\)$" . v-mode))
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration
    '(v-mode . "V")))
(add-hook! 'v-mode-hook #'lsp)

;; Meson
(add-hook 'meson-mode-hook 'company-mode)

;; Splash
(setq fancy-splash-image (concat doom-private-dir "splash.png"))
(remove-hook '+doom-dashboard-functions #'doom-dashboard-widget-shortmenu)

;; Discord
(require 'elcord)
(elcord-mode)
(setq elcord-editor-icon 'emacs_material_icon)


;; Remote
(with-eval-after-load 'lsp-mode
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "gopls")
      :major-modes '(go-mode)
      :remote? t
      :server-id 'gopls-remote))
  (lsp-register-client
    (make-lsp-client :new-connection (lsp-tramp-connection "clangd")
      :major-modes '(c-mode)
      :remote? t
      :server-id 'clangd-remote)))
(require 'tramp)
(add-to-list 'tramp-connection-properties
             (list (regexp-quote "/ssh:gintautas@192.168.1.105:")
                   "remote-shell" "/usr/bin/zsh"))

;; Ligatures
(add-hook 'typescript-tsx-mode-hook
            (lambda ()
              (push '("await" . ?Δ) prettify-symbols-alist)))
(add-hook 'python-mode-hook
            (lambda ()
              (push '("await" . ?Δ) prettify-symbols-alist)))
(add-hook 'js2-mode-hook
            (lambda ()
              (push '("await" . ?Δ) prettify-symbols-alist)))

;; Smooth scrolling
(setq pixel-scroll-precision-use-momentum 't)
(pixel-scroll-mode 1)
(pixel-scroll-precision-mode 1)
