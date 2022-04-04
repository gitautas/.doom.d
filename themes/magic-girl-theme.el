;;; magic-girl-theme.el --- inspired by TheKey.Company's Magic Girl keycap set. -*- no-byte-compile: t; -*-
(require 'doom-themes)

;;
(defgroup magic-girl-theme nil
  "Options for doom-themes"
  :group 'doom-themes)

(defcustom magic-girl-brighter-modeline nil
  "If non-nil, more vivid colors will be used to style the mode-line."
  :group 'magic-girl-theme
  :type 'boolean)

(defcustom magic-girl-brighter-comments nil
  "If non-nil, comments will be highlighted in more vivid colors."
  :group 'magic-girl-theme
  :type 'boolean)

(defcustom magic-girl-comment-bg magic-girl-brighter-comments
  "If non-nil, comments will have a subtle, darker background. Enhancing their
legibility."
  :group 'magic-girl-theme
  :type 'boolean)

(defcustom magic-girl-padded-modeline doom-themes-padded-modeline
  "If non-nil, adds a 4px padding to the mode-line. Can be an integer to
determine the exact padding."
  :group 'magic-girl-theme
  :type '(choice integer boolean))

(eval-and-compile
  (defcustom magic-girl-region-highlight t
    "Determines the selection highlight style. Can be 'frost, 'snowstorm or t
(default)."
    :group 'magic-girl-theme
    :type 'symbol))

;;
(def-doom-theme magic-girl
  "A dark theme inspired by Nord."

  ;; name        default   256       16
  ((bg         '("#091F2C" nil       nil            ))
   (bg-alt     '("#272C36" nil       nil            ))
   (base0      '("#191C25" nil       nil            ))
   (base1      '("#242832" nil       nil            ))
   (base2      '("#2C333F" nil       nil            ))
   (base3      '("#373E4C" nil       nil            ))
   (base4      '("#434C5E" nil       nil            ))
   (base5      '("#4C566A" nil       nil            ))
   (base6      '("#9099AB" nil       nil            ))
   (base7      '("#D8DEE9" nil       nil            ))
   (base8      '("#F0F4FC" nil       nil            ))
   (fg         '("#F5B1CC" nil       nil            ))
   (fg-alt     '("#E5E9F0" nil       nil            ))

   (grey       base4)
   (red        '("#E45C96" nil       nil            ))
   (orange     '("#D08770" nil       nil            ))
   (green      '("#A288D9" nil       nil            ))
   (teal       '("#93E8D3" nil       nil            ))
   (yellow     '("#E45C96" nil       nil            ))
   (blue       '("#81A1C1" nil       nil            ))
   (dark-blue  '("#5E81AC" nil       nil            ))
   (magenta    '("#B48EAD" nil       nil            ))
   (violet     '("#5D80AE" nil       nil            ))
   (cyan       '("#88C0D0" nil       nil            ))
   (dark-cyan  '("#507681" nil       nil            ))

   ;; face categories -- required for all themes
   (highlight      blue)
   (vertical-bar   (doom-darken base1 0.2))
   (selection      dark-blue)
   (builtin        blue)
   (comments       (if magic-girl-brighter-comments dark-cyan (doom-lighten base5 0.2)))
   (doc-comments   (doom-lighten (if magic-girl-brighter-comments dark-cyan base5) 0.25))
   (constants      blue)
   (functions      cyan)
   (keywords       blue)
   (methods        cyan)
   (operators      blue)
   (type           teal)
   (strings        green)
   (variables      base7)
   (numbers        magenta)
   (region         (pcase magic-girl-region-highlight
                     (`frost teal)
                     (`snowstorm base7)
                     (_ base4)))
   (error          red)
   (warning        yellow)
   (success        green)
   (vc-modified    orange)
   (vc-added       green)
   (vc-deleted     red)

   ;; custom categories
   (hidden     `(,(car bg) "black" "black"))
   (-modeline-bright magic-girl-brighter-modeline)
   (-modeline-pad
    (when magic-girl-padded-modeline
      (if (integerp magic-girl-padded-modeline) magic-girl-padded-modeline 4)))

   (region-fg
    (when (memq magic-girl-region-highlight '(frost snowstorm))
      base0))

   (modeline-fg     nil)
   (modeline-fg-alt base6)

   (modeline-bg
    (if -modeline-bright
        (doom-blend bg base5 0.2)
      `(,(doom-darken (car bg) 0.1) ,@(cdr base0))))
   (modeline-bg-l
    (if -modeline-bright
        (doom-blend bg base5 0.2)
      base1))
   (modeline-bg-inactive   `(,(car bg) ,@(cdr base1)))
   (modeline-bg-inactive-l (doom-darken bg 0.1)))


  ;; --- extra faces ------------------------
  (((region &override) :foreground region-fg)

   ((line-number &override) :foreground (doom-lighten 'base5 0.2))
   ((line-number-current-line &override) :foreground base7)
   ((paren-face-match &override) :foreground bg :background teal :weight 'ultra-bold)
   ((paren-face-mismatch &override) :foreground base7 :background red :weight 'ultra-bold)
   ((vimish-fold-overlay &override) :inherit 'font-lock-comment-face :background base3 :weight 'light)
   ((vimish-fold-fringe &override)  :foreground teal)

   (font-lock-comment-face
    :foreground comments
    :background (if magic-girl-comment-bg (doom-lighten bg 0.05)))
   (font-lock-doc-face
    :inherit 'font-lock-comment-face
    :foreground doc-comments)

   (doom-modeline-bar :background (if -modeline-bright modeline-bg highlight))

   (fringe :foreground teal :background modeline-bg)
   (tab-line
    :background modeline-bg :foreground blue
    :box `(:line-width 4 :color ,modeline-bg))
   (tab-line-tab
    :inherit 'tab-line
    :box '(:line-width 1))
   (tab-line-tab-current
    :inherit 'tab-line-tab
    :foreground fg-alt
    :background blue)
   (tab-line-tab-inactive
    :inherit 'tab-line-tab
    :foreground bg-alt
    :background dark-blue)

   (mode-line
    :background modeline-bg :foreground modeline-fg
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg)))
   (mode-line-inactive
    :background modeline-bg-inactive :foreground modeline-fg-alt
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive)))
   (mode-line-emphasis
    :foreground (if -modeline-bright base8 highlight))

   (doom-modeline-project-root-dir :foreground base6)
   (solaire-mode-line-face
    :inherit 'mode-line
    :background modeline-bg-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-l)))
   (solaire-mode-line-inactive-face
    :inherit 'mode-line-inactive
    :background modeline-bg-inactive-l
    :box (if -modeline-pad `(:line-width ,-modeline-pad :color ,modeline-bg-inactive-l)))

   ;; ediff
   (ediff-fine-diff-A    :background (doom-darken violet 0.4) :weight 'bold)
   (ediff-current-diff-A :background (doom-darken base0 0.25))

   ;; elscreen
   (elscreen-tab-other-screen-face :background "#353a42" :foreground "#1e2022")

   ;; highlight-symbol
   (highlight-symbol-face :background (doom-lighten base4 0.1) :distant-foreground fg-alt)

   ;; highlight-thing
   (highlight-thing :background (doom-lighten base4 0.1) :distant-foreground fg-alt)

   ;; ivy
   ((ivy-current-match &override) :foreground region-fg :weight 'semi-bold)


   ;; --- major-mode faces -------------------
   ;; css-mode / scss-mode
   (css-proprietary-property :foreground orange)
   (css-property             :foreground green)
   (css-selector             :foreground blue)

   ;; markdown-mode
   (markdown-markup-face :foreground base5)
   (markdown-header-face :inherit 'bold :foreground red)
   ((markdown-code-face &override) :background (doom-lighten base3 0.05))

   ;; org-mode
   (org-hide :foreground hidden)
   (solaire-org-hide-face :foreground hidden))


  ;; --- extra variables ---------------------
  ()
  )

;;; magic-girl-theme.el ends here
