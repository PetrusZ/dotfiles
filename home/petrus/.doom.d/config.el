;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Petrus.Z"
      user-mail-address "silencly07@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "Hack NF" :size 14))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one

;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to ;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

; (setq evil-org-key-theme '(textobjects insert navigation additional shift todo heading))

(setq default-input-method "rime")
(setq rime-show-candidate 'posframe)
(setq rime-user-data-dir "~/.doom.d/etc/rime")

(load! "fonts")

;; https://blog.csdn.net/xh_acmagic/article/details/78939246
;; (defun +my/better-font()
;;   (interactive)
;;   ;; english font
;;   (if (display-graphic-p)
;;       (progn
;;         (set-face-attribute 'default nil :font (format   "%s:pixelsize=%d" "Hack NF" 14)) ;; 11 13 17 19 23
;;         ;; chinese font
;;         (dolist (charset '(kana han symbol cjk-misc bopomofo))
;;           (set-fontset-font (frame-parameter nil 'font)
;;                             charset
;;                             (font-spec :family "Source Han Sans CN")))) ;; 14 16 20 22 28
;;     ))

;; (defun +my|init-font(frame)

;;     (if (display-graphic-p)
;;         (+my/better-font))))

;; (if (and (fboundp 'daemonp) (daemonp))
;;     (add-hook 'after-make-frame-functions #'+my|init-font)
;;   (+my/better-font))

;; (after! org
;;   (set-face-attribute 'org-table nil :family "Noto Sans Mono")
;; )

(defcustom which-key-idle-delay 0.5
  "Delay (in seconds) for which-key buffer to popup. This
 variable should be set before activating `which-key-mode'.

A value of zero might lead to issues, so a non-zero value is
recommended
(see https://github.com/justbur/emacs-which-key/issues/134)."
  :group 'which-key
  :type 'float)

(map! :ne "<f3>" 'neotree-toggle)
(map! :i "C-g" 'evil-normal-state)
(map! :i "C-h" 'evil-delete-backward-char-and-join)
(map! :nv "j" `evil-next-visual-line)
(map! :nv "k" `evil-previous-visual-line)
(map! :i "S-SPC" 'toggle-input-method)

(autoload 'cmake-font-lock-activate "cmake-font-lock" nil t)
(add-hook 'cmake-mode-hook 'cmake-font-lock-activate)

; (define-key evil-normal-state-map (kbd "<f3>") 'neotree-toggle)
; (global-set-key (kbd "<f1>") 'func)

;; (define-key input-decode-map "\C-i" [C-i])
;; (setq evil-want-C-i-jump t)

;; copied from spacemacs/translate-C-i
(defun me/translate-C-i (_)
  "If the raw key sequence does not include <tab> or <kp-tab>, andwe are in the gui, translate to [C-i]. Otherwise, [9] (TAB)."
  (interactive)
  (if (and (not (cl-position 'tab (this-single-command-raw-keys)))
           (not (cl-position 'kp-tab (this-single-command-raw-keys)))
           (display-graphic-p))
      [C-i] [?\C-i]))
(define-key key-translation-map [?\C-i] 'me/translate-C-i)
(map! [C-i] #'better-jumper-jump-forward)

(setq org-file-apps
      (quote
       ((auto-mode . emacs)
        ("\\.mm\\'" . default)
        ("\\.x?html?\\'" . "chromium-browser %s")
        ("\\.pdf\\'" . default))))

;; (setq org-capture-templates
;;    '(("K" "Cliplink capture task" entry (file "")
;;       "* TODO %(org-cliplink-capture) \n  SCHEDULED: %t\n" :empty-lines 1)))

(setq org-publish-use-timestamps-flag t)
(setq org-publish-project-alist
    '(
      ("site-orgs"
       :base-directory "~/Documents/org/src/"
       :base-extension "org"
       :publishing-directory "~/Documents/org/publish/"
       :recursive t
       :publishing-function org-html-publish-to-html
       :headline-levels 5
       :section-numbers nil
       :auto-preamble t
       :with-toc t
       :with-sub-superscript nil

       :sitemap-file-entry-format "%d ====> %t"
       :sitemap-sort-files anti-chronologically
       :sitemap-filename "sitemap.org"
       :sitemap-title "Codeplayer"
       :auto-sitemap t

       :html-doctype "html5"
       :html-validation-link nil
       :html-link-home "/index.html"
       :html-link-up "../index.html"

       :author "Petrus.Z"
       :email "silencly07@gmail.com"
       :html-head-extra "<style> #content{max-width:1400px;}</style>"
       :language "zh-CN"
       )
      ("site-static"
       :base-directory "~/Documents/org/src/pics/"
       :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
       :publishing-directory "~/Documents/org/publish/pics"
       :recursive t
       :publishing-function org-publish-attachment
       )
      ("site" :components ("site-orgs" "site-static"))
      ;;
      ))

;; (setq org-static-blog-publish-title "Codeplayer")
;; (setq org-static-blog-publish-url "https://codeplayer.org/")
;; (setq org-static-blog-publish-directory "~/Documents/org/blog/")
;; (setq org-static-blog-posts-directory "~/Documents/org/")
;; (setq org-static-blog-drafts-directory "~/Documents/drafts/")
;; (setq org-static-blog-enable-tags t)
;; (setq org-export-with-toc nil)
;; (setq org-export-with-section-numbers nil)

;; ;; This header is inserted into the <head> section of every page:
;; ;;   (you will need to create the style sheet at
;; ;;    ~/projects/blog/static/style.css
;; ;;    and the favicon at
;; ;;    ~/projects/blog/static/favicon.ico)
;; (setq org-static-blog-page-header
;; "<meta name=\"author\" content=\"Petrus.Z\">
;; <meta name=\"referrer\" content=\"no-referrer\">
;; <link href= \"static/style.css\" rel=\"stylesheet\" type=\"text/css\" /> ")

;; ;; This preamble is inserted at the beginning of the <body> of every page:
;; ;;   This particular HTML creates a <div> with a simple linked headline
;; (setq org-static-blog-page-preamble
;; "<div class=\"header\">
;;   <a href=\"https://codeplayer.org\">Codeplayer.org</a>
;; </div>")

;; ;; This postamble is inserted at the end of the <body> of every page:
;; ;;   This particular HTML creates a <div> with a link to the archive page
;; ;;   and a licensing stub.
;; (setq org-static-blog-page-postamble
;; "<div id=\"archive\">
;;   <a href=\"https://codeplayer.org.org/archive.html\">Other posts</a>
;; </div>
;; <center><a rel=\"license\" href=\"https://creativecommons.org/licenses/by-sa/3.0/\"><img alt=\"Creative Commons License\" style=\"border-width:0\" src=\"https://i.creativecommons.org/l/by-sa/3.0/88x31.png\" /></a><br /><span xmlns:dct=\"https://purl.org/dc/terms/\" href=\"https://purl.org/dc/dcmitype/Text\" property=\"dct:title\" rel=\"dct:type\">bastibe.de</span> by <a xmlns:cc=\"https://creativecommons.org/ns#\" href=\"https://bastibe.de\" property=\"cc:attributionName\" rel=\"cc:attributionURL\">Bastian Bechtold</a> is licensed under a <a rel=\"license\" href=\"https://creativecommons.org/licenses/by-sa/3.0/\">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.</center>")
