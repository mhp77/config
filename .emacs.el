;;---------------------------------------------------------------------------------------------------------------------------;;
;;###########################################################################################################################;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;; Abstract:
;;   Initialization file ~/.emacs.el contains a sequence of Emacs Lisp function call expressions implementing run-time
;; configuration for the Emacs text editor.
;;
;; Details:
;; - This Emacs initialization file is written for Emacs version 24.3.
;; - The first section facilitates basic customization using a set of parameters with name prefix ‘MHP-’.
;; - The author uses patched versions of some Emacs Lisp libraries. If the corresponding patches are not available on the
;;   system the parameter MHP-WITH-PATCHES should be set to nil.
;;
;; References:
;; - GNU Emacs Manual
;;   --> http://www.gnu.org/software/emacs/manual/emacs.pdf
;; - GNU Emacs Lisp Reference Manual
;;   --> http://www.gnu.org/software/emacs/manual/elisp.pdf
;;
;; Author:
;;   Michael H. Pock || MHP || mhp77@gmx.at
;;
;; © Copyleft 2016, 2019 MHP
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;###########################################################################################################################;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Parameters **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Patching **********

(defconst MHP-WITH-PATCHES t)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Personal Data **********

(defconst MHP-FULL-NAME "Michael H. Pock")

(defconst MHP-SHORT-NAME "MHP")

(defconst MHP-MAIL-ADDRESS "mhp77@gmx.at")

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Colours **********

(defvar MHP-BLACK-NW   "black")
(defvar MHP-RED-NW     "red")
(defvar MHP-GREEN-NW   "green")
(defvar MHP-YELLOW-NW  "yellow")
(defvar MHP-BLUE-NW    "blue")
(defvar MHP-MAGENTA-NW "magenta")
(defvar MHP-CYAN-NW    "cyan")
(defvar MHP-WHITE-NW   "white")
(defvar MHP-BLACK-BW   "black")
(defvar MHP-RED-BW     "red")
(defvar MHP-GREEN-BW   "green")
(defvar MHP-YELLOW-BW  "yellow")
(defvar MHP-BLUE-BW    "blue")
(defvar MHP-MAGENTA-BW "magenta")
(defvar MHP-CYAN-BW    "cyan")
(defvar MHP-WHITE-BW   "white")

(when window-system
  (setq MHP-BLACK-NW   "black")
  (setq MHP-RED-NW     "red3")
  (setq MHP-GREEN-NW   "SpringGreen4")
  (setq MHP-YELLOW-NW  "DarkGoldenRod3")
  (setq MHP-BLUE-NW    "RoyalBlue4")
  (setq MHP-MAGENTA-NW "magenta3")
  (setq MHP-CYAN-NW    "DeepSkyBlue2")
  (setq MHP-WHITE-NW   "grey55")
  (setq MHP-BLACK-BW   "grey12")
  (setq MHP-RED-BW     "IndianRed2")
  (setq MHP-GREEN-BW   "green3")
  (setq MHP-YELLOW-BW  "yellow2")
  (setq MHP-BLUE-BW    "SlateBlue2")
  (setq MHP-MAGENTA-BW "MediumOrchid1")
  (setq MHP-CYAN-BW    "cyan3")
  (setq MHP-WHITE-BW   "grey85"))

;; Setting MHP-BACKGROUND to 'unspecified is not a good idea since the wrong value for frame parameter background-mode might be
;; selected in this case.
(defconst MHP-BACKGROUND    MHP-BLACK-NW)
(defconst MHP-FOREGROUND-NW MHP-WHITE-NW)
(defconst MHP-FOREGROUND-BW MHP-WHITE-BW)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Fill Column **********

(defconst MHP-DEFAULT-FILL-COLUMN 127)

(defconst MHP-TEXT-MODE-FILL-COLUMN 72)


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Development **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Lisp **********

(setq eval-expression-debug-on-error nil)

(setq emacs-lisp-docstring-fill-column (+ MHP-TEXT-MODE-FILL-COLUMN lisp-body-indent 1))

(setq ad-default-compilation-action 'like-original)

(defun mhp-check-is-patched (library custom-group)
  "Check whether LIBRARY is patched. If this is not the case display a
warning message of type CUSTOM-GROUP."
  (unless (stringp library)      (error (error-message-string `(wrong-type-argument stringp ,library))))
  (unless (stringp custom-group) (error (error-message-string `(wrong-type-argument stringp ,custom-group))))
  (when (and (string< "" library) (locate-library library) (not (intern-soft (concat library "-is-patched-mhp"))))
    (beep)
    (display-warning (intern-soft custom-group) (concat "The `" library "' library in use is not patched."))
    (sleep-for 1)))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Debug **********

(setq message-log-max t)


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Faces **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Basic Faces **********

(set-face-attribute 'default
                    nil
                    :background MHP-BACKGROUND :foreground MHP-FOREGROUND-NW :weight 'normal)

(set-face-attribute 'bold-italic
                    nil
                    :slant 'unspecified
                    :inherit 'italic)

(set-face-attribute 'shadow
                    nil
                    :foreground MHP-BLUE-NW :weight 'normal)

(set-face-attribute 'link
                    nil
                    :foreground MHP-CYAN-NW :weight 'normal)

(set-face-attribute 'highlight
                    nil
                    :background MHP-YELLOW-NW :foreground MHP-BLACK-NW :weight 'normal)

(set-face-attribute 'region
                    nil
                    :background MHP-CYAN-NW :foreground MHP-BLACK-NW :weight 'normal)

(set-face-attribute 'secondary-selection
                    nil
                    :background MHP-GREEN-NW :foreground MHP-BLACK-NW :weight 'normal)

(set-face-attribute 'trailing-whitespace
                    nil
                    :background MHP-RED-NW)

(set-face-attribute 'escape-glyph
                    nil
                    :foreground MHP-YELLOW-BW :weight 'bold)

(set-face-attribute 'nobreak-space
                    nil
                    :background 'unspecified :underline t
                    :inherit 'escape-glyph)

(set-face-attribute 'error
                    nil
                    :background MHP-RED-NW :foreground MHP-BLACK-NW :weight 'normal)

(set-face-attribute 'warning
                    nil
                    :background MHP-MAGENTA-NW :foreground MHP-BLACK-NW :weight 'normal)

(set-face-attribute 'success
                    nil
                    :background MHP-GREEN-NW :foreground MHP-BLACK-NW :weight 'normal)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Font Lock **********

(set-face-attribute 'font-lock-comment-face
                    nil
                    :foreground MHP-RED-NW :weight 'normal)
(set-face-attribute 'font-lock-variable-name-face
                    nil
                    :foreground MHP-YELLOW-NW :weight 'normal)
(set-face-attribute 'font-lock-constant-face
                    nil
                    :foreground MHP-MAGENTA-NW :weight 'normal)
(set-face-attribute 'font-lock-string-face
                    nil
                    :foreground MHP-GREEN-NW :weight 'normal)
(set-face-attribute 'font-lock-type-face
                    nil
                    :foreground MHP-GREEN-NW :weight 'normal)
(set-face-attribute 'font-lock-keyword-face
                    nil
                    :foreground MHP-CYAN-NW :weight 'normal)
(set-face-attribute 'font-lock-builtin-face
                    nil
                    :foreground MHP-BLUE-NW :weight 'normal)
(set-face-attribute 'font-lock-function-name-face
                    nil
                    :foreground MHP-BLUE-BW :weight 'bold)
(set-face-attribute 'font-lock-warning-face
                    nil
                    :foreground MHP-RED-BW :weight 'bold
                    :inherit 'unspecified)
(set-face-attribute 'font-lock-regexp-grouping-backslash
                    nil
                    :foreground MHP-MAGENTA-BW :weight 'bold
                    :inherit 'unspecified)
(set-face-attribute 'font-lock-regexp-grouping-construct
                    nil
                    :foreground MHP-MAGENTA-BW :weight 'bold
                    :inherit 'unspecified)
(set-face-attribute 'font-lock-negation-char-face
                    nil
                    :foreground MHP-MAGENTA-NW :weight 'normal)

(global-hi-lock-mode 1)
(set-face-attribute 'hi-blue
                    nil
                    :background MHP-CYAN-NW :foreground MHP-BLACK-BW :weight 'bold)
(set-face-attribute 'hi-green
                    nil
                    :background MHP-GREEN-NW :foreground MHP-BLACK-BW :weight 'bold)
(set-face-attribute 'hi-yellow
                    nil
                    :background MHP-YELLOW-NW :foreground MHP-BLACK-BW :weight 'bold)
(set-face-attribute 'hi-pink
                    nil
                    :background MHP-MAGENTA-NW :foreground MHP-BLACK-BW :weight 'bold)
(set-face-attribute 'hi-black-b
                    nil
                    :foreground MHP-BLACK-BW :weight 'bold)
(set-face-attribute 'hi-blue-b
                    nil
                    :foreground MHP-CYAN-BW :weight 'bold)
(set-face-attribute 'hi-green-b
                    nil
                    :foreground MHP-GREEN-BW :weight 'bold)
(set-face-attribute 'hi-red-b
                    nil
                    :foreground MHP-RED-BW :weight 'bold)


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Environment **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Initialization **********

(setq inhibit-startup-screen t)

(setq inhibit-startup-buffer-menu t)

(setq initial-buffer-choice nil)

(setq initial-scratch-message nil)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Frames **********

(setq frame-title-format
      `(:eval
        (,(lambda ()
            (let ((file (or buffer-file-name (and list-buffers-directory (directory-file-name list-buffers-directory))))
                  (default-directory "~/"))
              (if file
                  (concat (shell-command-to-string "echo -n $(id -urn)")
                          "@"
                          (shell-command-to-string "echo -n $(hostname -s)")
                          ":"
                          (replace-regexp-in-string (regexp-quote (shell-command-to-string "echo -n ${HOME}")) "~" file))
                (buffer-name)))))))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(menu-bar-mode -1)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; On a text terminal, Emacs cannot modify cursor face attributes. Under X, the cursor should have a colour different from the
;; dedicated background colours (i.e. the MHP-<COLOUR>-NW colours).
(set-face-attribute 'cursor
                    nil
                    :background MHP-BLUE-BW)

(set-face-attribute 'vertical-border
                    nil
                    :background MHP-FOREGROUND-NW :foreground MHP-BACKGROUND :weight 'normal
                    :inherit 'unspecified)

(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'right)
(set-face-attribute 'fringe
                    nil
                    :background 'unspecified
                    :inherit 'vertical-border)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Windows **********

(setq split-width-threshold nil)

(defun mhp-kill-other-buffers-and-windows ()
  "Delete all windows of current frame but the selected one and kill the
buffers displayed in these windows."
  (interactive)
  (let ((windows (cdr (window-list))))
    (dolist (element windows) (select-window element) (kill-buffer) (delete-window))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Mode Line **********

(column-number-mode 1)

(size-indication-mode 1)

(set-face-attribute 'mode-line
                    nil
                    :background MHP-CYAN-NW :foreground MHP-BLACK-NW :weight 'normal
                    :inverse-video 'unspecified :box `(:line-width -1 :color ,MHP-CYAN-NW :style released-button))
(set-face-attribute 'mode-line-inactive
                    nil
                    :background MHP-BLUE-NW :foreground MHP-WHITE-NW :weight 'normal
                    :box `(:line-width -1 :color ,MHP-CYAN-NW :style nil))
(set-face-attribute 'mode-line-buffer-id
                    nil
                    :foreground MHP-BLACK-BW :weight 'bold)
(set-face-attribute 'mode-line-highlight
                    nil
                    :box 'unspecified
                    :inherit 'highlight)

(set-face-attribute 'header-line
                    nil
                    :background MHP-GREEN-NW :foreground MHP-BLACK-NW :weight 'normal :underline 'unspecified)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Display **********

(setq-default truncate-lines t)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Minibuffer **********

(setq enable-recursive-minibuffers t)

(setq history-delete-duplicates t)

(set-face-attribute 'minibuffer-prompt
                    nil
                    :foreground MHP-CYAN-NW :weight 'normal)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Mouse **********

(setq mouse-yank-at-point t)

(when (boundp 'mouse-wheel-scroll-amount)
  (setq mouse-wheel-scroll-amount '(0.1)))
(when (boundp 'mouse-wheel-inhibit-click-time)
  (setq mouse-wheel-inhibit-click-time 0.75))

(mouse-avoidance-mode 'animate)


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Editing **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Editing Basics **********

(setq require-final-newline t)

(setq set-mark-command-repeat-pop t)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Killing **********

(setq backward-delete-char-untabify-method 'hungry)

(setq kill-whole-line t)

(when (boundp 'x-select-enable-clipboard)
  (setq x-select-enable-clipboard t))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Undo **********

(setq undo-limit (* 256 1024))
(setq undo-strong-limit (*   2 undo-limit))
(setq undo-outer-limit  (* 128 undo-limit))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Indent **********

(setq-default indent-tabs-mode nil)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Fill **********

(setq-default fill-column MHP-DEFAULT-FILL-COLUMN)

(defvar mhp-local-fill-column (default-value 'fill-column)
  "Auxiliary variable used by `mhp-toggle-fill-column'.")
(make-variable-buffer-local 'mhp-local-fill-column)

(defun mhp-toggle-fill-column ()
  "Switch between default and buffer-local values of `fill-column'."
  (interactive)
  (if (local-variable-p 'fill-column)
      (progn (setq mhp-local-fill-column fill-column) (kill-local-variable 'fill-column))
    (setq fill-column mhp-local-fill-column)))

(setq sentence-end-double-space nil)

(setq comment-auto-fill-only-comments t)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Matching **********

(set-face-attribute 'match
                    nil
                    :background MHP-CYAN-NW :foreground MHP-BLACK-BW :weight 'bold)

(setq search-ring-update t)
(setq isearch-allow-scroll t)
(set-face-attribute 'isearch
                    nil
                    :background MHP-GREEN-NW :foreground MHP-BLACK-BW :weight 'bold)
(set-face-attribute 'lazy-highlight
                    nil
                    :background MHP-BLUE-NW :foreground MHP-BLACK-NW :weight 'normal)
(set-face-attribute 'isearch-fail
                    nil
                    :background MHP-RED-NW :foreground MHP-FOREGROUND-NW :weight 'normal)

(setq list-matching-lines-buffer-name-face 'hi-blue-b)

(eval-after-load 'imenu
  `(,(lambda ()
       (eval-when-compile (require 'imenu))
       (setq imenu-auto-rescan t)
       (setq imenu-auto-rescan-maxout (* 128 1024))
       (setq imenu-space-replacement "_")
       (add-hook 'imenu-after-jump-hook 'recenter))))

(setq query-replace-lazy-highlight nil)

(set-face-attribute 'completions-first-difference
                    nil
                    :inherit 'escape-glyph)

(show-paren-mode 1)
(set-face-attribute 'show-paren-match
                    nil
                    :background MHP-CYAN-NW :foreground MHP-BLACK-NW :weight 'normal)
(set-face-attribute 'show-paren-mismatch
                    nil
                    :background MHP-MAGENTA-NW :foreground MHP-BLACK-NW :weight 'normal)

(defun mhp-move-to-matching-parenthesis ()
  "Move text cursor from a parenthesis onto its matching counterpart."
  (interactive)
  (cond ((looking-at "\\s(") (forward-list 1) (backward-char 1))
        ((looking-at "\\s)") (forward-char 1) (backward-list 1))))

(defun mhp-highlight-nonascii-characters (&optional off)
  "Highlight non-ASCII characters in current buffer. If raw prefix argument
OFF is present unhighlight them."
  (interactive "P")
  (let ((regexp "[[:nonascii:]]"))
    (if off (hi-lock-unface-buffer regexp) (hi-lock-face-buffer regexp 'hi-yellow))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** I18n **********

(setq default-input-method 'ucs)

(add-to-list 'safe-local-variable-values '(default-input-method . latin-9-prefix) t)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Emulations **********

(eval-after-load 'cua-base
  `(,(lambda ()
       (eval-when-compile (require 'cua-base))
       (setq cua-enable-cua-keys nil)
       ;; The default key binding C-<return> does not work on some text terminals (e.g. GNOME Terminal).
       (setq cua-rectangle-mark-key (kbd "C-c SPC"))
       (set-face-attribute 'cua-rectangle
                           nil
                           :background 'unspecified :foreground 'unspecified))))


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** External **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Processes **********

(eval-after-load 'executable
  `(,(lambda ()
       (eval-when-compile (require 'executable))
       (let ((default-directory "~/"))
         (cond ((string= (shell-command-to-string "echo -n $(umask)") "0077") (setq executable-chmod -448))
               (t                                                             (setq executable-chmod -493)))))))

(eval-after-load 'ansi-color
  `(,(lambda ()
       (eval-and-compile (require 'ansi-color))
       (ansi-color-map-update
        'ansi-color-names-vector
        (vector MHP-BLACK-NW MHP-RED-NW MHP-GREEN-NW MHP-YELLOW-NW MHP-BLUE-NW MHP-MAGENTA-NW MHP-CYAN-NW MHP-WHITE-NW)))))

(eval-after-load 'comint
  `(,(lambda ()
       (eval-when-compile (require 'comint))
       (setq comint-prompt-read-only t)
       (setq comint-input-ignoredups t)
       (setq comint-buffer-maximum-size 100000)
       (setq comint-scroll-to-bottom-on-input 'this)
       (setq comint-completion-autolist t)
       (set-face-attribute 'comint-highlight-input
                           nil
                           :foreground MHP-CYAN-BW :weight 'bold))))

(eval-after-load 'shell
  `(,(lambda ()
       (eval-when-compile (require 'shell))
       (setq shell-font-lock-keywords nil)
       (setq shell-dirtrack-verbose nil))))

(add-hook 'shell-mode-hook
          (lambda ()
            ;; See http://debbugs.gnu.org/cgi/bugreport.cgi?bug=11883 why it does not make sense to use shell-apply-ansi-color
            ;; as the value of ansi-color-apply-face-function yet.
            (kill-local-variable 'ansi-color-apply-face-function)
            (add-hook 'comint-output-filter-functions 'comint-truncate-buffer nil t)))

(eval-after-load 'proced
  `(,(lambda ()
       (setq-default proced-auto-update-flag t)
       (set-face-attribute 'proced-sort-header
                           nil
                           :inherit 'highlight))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Locate **********

(eval-after-load 'locate
  `(,(lambda ()
       (eval-when-compile (require 'locate))
       (setq locate-header-face 'match))))


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Help **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** General **********

(setq help-window-select nil)

(temp-buffer-resize-mode 1)
(setq temp-buffer-max-height (lambda (buffer) (/ (1- (frame-height)) 3)))

(set-face-attribute 'help-argument-name
                    nil
                    :inherit 'font-lock-variable-name-face)

(add-hook 'help-mode-hook
          (lambda ()
            (add-to-list (make-local-variable 'face-remapping-alist) '(bold font-lock-function-name-face))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Tool Tips **********

(when (fboundp 'tooltip-mode)
  (tooltip-mode -1))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Apropos **********

(eval-after-load 'apropos
  `(,(lambda ()
       (set-face-attribute 'apropos-symbol
                           nil
                           :foreground MHP-FOREGROUND-BW :weight 'bold
                           :inherit 'unspecified))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Customize **********

(eval-after-load 'cus-edit
  `(,(lambda ()
       (eval-when-compile (require 'cus-edit))
       (setq custom-browse-order-groups 'last)
       (setq custom-buffer-done-kill t)
       (set-face-attribute 'custom-button
                           nil
                           :background MHP-CYAN-NW :foreground MHP-BLACK-NW :weight 'normal)
       (set-face-attribute 'custom-button-mouse
                           nil
                           :background 'unspecified :foreground 'unspecified
                           :inverse-video 'unspecified
                           :inherit 'highlight)
       (set-face-attribute 'custom-button-pressed
                           nil
                           :background 'unspecified :foreground 'unspecified
                           :inverse-video 'unspecified
                           :inherit 'custom-button-mouse)
       (set-face-attribute 'custom-group-tag
                           nil
                           :foreground MHP-CYAN-BW :weight 'bold)
       (set-face-attribute 'custom-variable-tag
                           nil
                           :foreground MHP-BLUE-BW :weight 'bold)
       (set-face-attribute 'custom-state
                           nil
                           :foreground MHP-GREEN-NW :weight 'normal))))

(eval-after-load 'wid-edit
  `(,(lambda ()
       (set-face-attribute 'widget-field
                           nil
                           :background MHP-FOREGROUND-NW :foreground MHP-BACKGROUND :weight 'normal))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Man **********

(eval-after-load 'man
  `(,(lambda ()
       (eval-when-compile (require 'man))
       (when MHP-WITH-PATCHES
         (mhp-check-is-patched "man" "man"))
       ;; Some heuristic ...
       (setq Man-width (+ MHP-TEXT-MODE-FILL-COLUMN 2))
       (setq Man-notify-method 'pushy)
       (modify-syntax-entry ?\. "." Man-mode-syntax-table)
       (set-face-attribute 'Man-overstrike
                           nil
                           :inherit 'font-lock-function-name-face))))

(add-hook 'Man-mode-hook
          (lambda ()
            (set (make-local-variable 'nobreak-char-display) nil)))


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Files **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** General **********

(when MHP-WITH-PATCHES
  (load "files" nil t nil t)
  (mhp-check-is-patched "files" "files"))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Backup **********

(setq backup-directory-alist `(("." . ,(concat user-emacs-directory "backups/"))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Find File **********

(setq find-file-visit-truename t)

(defun mhp-update-buffer-name ()
  "Ensure that name of current buffer is up-to-date."
  (and find-file-visit-truename
       buffer-file-name
       (let ((name (file-name-nondirectory buffer-file-name)))
         (when (string= name "") (setq name buffer-file-name))
         (rename-buffer name t))))

(defun mhp-update-file-name-history ()
  "Put name of file visited by current buffer at the front of
`file-name-history'."
  (let ((file (or buffer-file-name list-buffers-directory)))
    (when file (delete-dups (push (abbreviate-file-name file) file-name-history)))))

(add-hook 'find-file-hook 'mhp-update-buffer-name)
(add-hook 'find-file-hook 'mhp-update-file-name-history)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Auto Revert **********

(global-auto-revert-mode 1)

(eval-after-load 'autorevert
  `(,(lambda ()
       (eval-when-compile (require 'autorevert))
       (setq global-auto-revert-non-file-buffers t))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Dired **********

(setq list-directory-brief-switches "-CF")
(setq list-directory-verbose-switches "-lhF")

(setq directory-free-space-args "-Ph")

(setq dired-listing-switches (concat list-directory-verbose-switches " -a"))

(eval-after-load 'dired
  `(,(lambda ()
       (setq dired-recursive-copies 'always)
       (setq dired-recursive-deletes 'always)
       (set-face-attribute 'dired-header
                           nil
                           :inherit 'hi-red-b)
       (set-face-attribute 'dired-symlink
                           nil
                           :inherit 'hi-blue-b))))

(add-hook 'dired-mode-hook 'mhp-update-file-name-history)

(eval-after-load 'find-dired
  `(,(lambda ()
       (eval-when-compile (require 'find-dired))
       (when MHP-WITH-PATCHES
         (mhp-check-is-patched "find-dired" "find-dired"))
       (setq find-ls-option (concat list-directory-verbose-switches " -d"))
       (setq find-ls-option `(,(concat "-exec "
                                       insert-directory-program " "
                                       find-ls-option " "
                                       "{} "
                                       (shell-quote-argument ";")) . ,find-ls-option))
       (setq find-ls-subdir-switches (or dired-subdir-switches dired-listing-switches)))))

(add-to-list 'completion-ignored-extensions ".mod" t)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Tramp **********

(eval-after-load 'tramp
  `(,(lambda ()
       (eval-when-compile (require 'tramp))
       (setq tramp-auto-save-directory temporary-file-directory))))


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Data **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Tabulated List **********

(when MHP-WITH-PATCHES
  (load "tabulated-list" nil t nil t)
  (mhp-check-is-patched "tabulated-list" ""))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Session **********

(require 'session)

(setq session-initialize t)

(setq session-save-file (concat user-emacs-directory "session"))

(add-hook 'after-init-hook
          (lambda ()
            (session-initialize)
            (condition-case nil
                (let ((file (car file-name-history)))
                  (when (and file (file-readable-p (setq file (or (and find-file-wildcards (car (file-expand-wildcards file)))
                                                                  file))))
                    (unless initial-window-system (setq inhibit-startup-screen t))
                    (let ((find-file
                           (lambda (file)
                             (let* ((buffers (buffer-list))
                                    (number-files 0)
                                    (count-files
                                     (lambda (buffer)
                                       (when (or (buffer-local-value 'buffer-file-name buffer)
                                                 (buffer-local-value 'list-buffers-directory buffer))
                                         (setq number-files (1+ number-files)))))
                                    new-buffer)
                               (mapc count-files buffers)
                               (cond ((eq initial-buffer-choice nil)
                                      (and (= number-files 0)
                                           (find-file file)
                                           (not inhibit-startup-screen)
                                           (boundp 'file-count) (setq file-count (1+ file-count))))
                                     ((eq initial-buffer-choice t)
                                      (and (= number-files 0)
                                           (find-file file)
                                           (switch-to-buffer (get-buffer-create "*scratch*"))))
                                     ((stringp initial-buffer-choice)
                                      (and (<= number-files 1)
                                           (setq new-buffer (find-file file))
                                           (= number-files 1)
                                           (null (memq new-buffer buffers))
                                           (switch-to-buffer nil)))
                                     (t
                                      (and (= number-files 0)
                                           (find-file file))))))))
                      (add-hook 'emacs-startup-hook `(lambda () (,find-file ,file))))))
              ((error quit) nil))) t)

(require 'advice)

(defadvice session-initialize (after mhp-after-session-initialize preactivate activate)
  "Upgrade hook set-up after initializing the session."
  ;; We prefer mhp-update-file-name-history for the purpose of augmenting the filename history.
  (remove-hook 'find-file-hook 'session-set-file-name-history)
  (when (or (eq session-initialize t) (memq 'session session-initialize))
    (when (boundp 'emacs-save-session-functions)
      (add-hook 'emacs-save-session-functions
                (lambda ()
                  (with-current-buffer (car (buffer-list)) (session-save-session)) nil)))))

(defadvice session-save-session (before mhp-before-session-save-session preactivate activate)
  "Call `mhp-update-file-name-history' before saving the session."
  (mhp-update-file-name-history))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Tar **********

(eval-after-load 'tar-mode
  `(,(lambda ()
       (eval-when-compile (require 'tar-mode))
       (setq tar-mode-show-date t)
       (setq tar-update-datestamp t))))


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Convenience **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Buffer Menu **********

(when MHP-WITH-PATCHES
  (load "buff-menu" nil t nil t)
  (mhp-check-is-patched "buff-menu" "Buffer-menu"))

(setq Buffer-menu-name-width 21)
(setq Buffer-menu-mode-width 18)

(set-face-attribute 'buffer-menu-buffer
                    nil
                    :weight 'unspecified
                    :inherit 'font-lock-function-name-face)

(defadvice list-buffers (around mhp-around-list-buffers preactivate activate)
  "Adjust height of window displaying the buffer list."
  (with-selected-window ad-do-it
    (shrink-window (- (window-height) (funcall temp-buffer-max-height nil)))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Tabbar **********

(eval-after-load 'tabbar
  `(,(lambda ()
       (eval-and-compile (require 'tabbar))
       (when MHP-WITH-PATCHES
         (mhp-check-is-patched "tabbar" "tabbar"))
       (set-face-attribute 'tabbar-default
                           nil
                           :background 'unspecified :foreground 'unspecified :height 'unspecified
                           :inherit 'header-line)
       (set-face-attribute 'tabbar-button
                           nil
                           :foreground MHP-RED-NW :weight 'normal
                           :box 'unspecified)
       (set-face-attribute 'tabbar-button-highlight
                           nil
                           :box '(:line-width -1 :style released-button)
                           :inherit 'tabbar-button)
       (set-face-attribute 'tabbar-unselected
                           nil
                           :box '(:line-width -1 :style pressed-button))
       (set-face-attribute 'tabbar-selected
                           nil
                           :foreground MHP-BLACK-BW :weight 'bold
                           :box '(:line-width -1 :style released-button))
       (set-face-attribute 'tabbar-highlight
                           nil
                           :underline 'unspecified))))

(when window-system
  (require 'tabbar) (tabbar-mode 1))


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Applications **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Ispell **********

(eval-after-load 'ispell
  `(,(lambda ()
       (eval-when-compile (require 'ispell))
       (when MHP-WITH-PATCHES
         (mhp-check-is-patched "ispell" "ispell"))
       (setq ispell-program-name (or (executable-find "aspell") ispell-program-name))
       (when (string-match-p "aspell" ispell-program-name)
         (setq ispell-extra-args '("--tex-check-comments")))
       ;; We use setq-default since ispell-check-comments might already exist as a buffer-local variable.
       (setq-default ispell-check-comments 'exclusive)
       (setq ispell-query-replace-choices t)
       (setq ispell-highlight-face 'match)
       (setq ispell-lazy-highlight nil))))

(defadvice ispell-comments-and-strings (around mhp-around-ispell-comments-and-strings preactivate)
  "Once the spellcheck is complete move point to preceding position."
  (let ((pos (point)))
    ad-do-it
    (goto-char pos)))

(add-to-list 'ispell-skip-region-alist '("\\$Id:"            "\\$")   t)
(add-to-list 'ispell-skip-region-alist '("Local Variables:$" "End:$") t)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Mail **********

(setq user-full-name MHP-FULL-NAME)
(setq user-mail-address MHP-MAIL-ADDRESS)


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Communication **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Goto Address **********

(eval-after-load 'goto-addr
  `(,(lambda ()
       (eval-and-compile (require 'goto-addr))
       (setq goto-address-fontify-maximum-size t)
       (setq goto-address-fontify-p nil))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Browse URL **********

(setq browse-url-browser-function 'browse-url-firefox)


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Tools **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Compilation **********

(eval-after-load 'compile
  `(,(lambda ()
       (eval-when-compile (require 'compile))
       (setq compilation-skip-threshold 0)
       (setq compilation-skip-visited t)
       (setq compilation-auto-jump-to-first-error t)
       (setq compilation-message-face 'comint-highlight-prompt)
       (setq compilation-enter-directory-face 'font-lock-warning-face)
       (setq compilation-leave-directory-face 'font-lock-function-name-face)
       (set-face-attribute 'compilation-line-number
                           nil
                           :foreground MHP-GREEN-NW :weight 'normal
                           :inherit 'unspecified)
       (set-face-attribute 'compilation-column-number
                           nil
                           :foreground MHP-BLUE-NW :weight 'normal
                           :inherit 'unspecified)
       (set-face-attribute 'compilation-mode-line-fail
                           nil
                           :foreground 'unspecified :weight 'unspecified)
       (set-face-attribute 'compilation-mode-line-exit
                           nil
                           :foreground 'unspecified :weight 'unspecified)
       (setcar (car (nthcdr 2 compilation-mode-font-lock-keywords))
               " --?o\\(?:utfile\\|utput\\)?\\(?:=\\| +\\)\\([[:graph:]]+\\)"))))

(add-hook 'compilation-mode-hook
          (lambda ()
            (set (make-local-variable 'compilation-window-height) (funcall temp-buffer-max-height nil))))

(add-hook 'compilation-shell-minor-mode-hook
          (lambda ()
            (set (make-local-variable 'compilation-window-height) (funcall temp-buffer-max-height nil))
            (set (make-local-variable 'compilation-auto-jump-to-first-error) nil)))

(eval-after-load 'compile
  `(,(lambda ()
       (setq compilation-error-regexp-alist-alist
             `((gnu         ,(concat "^\\(\\(.+?\\):\\([[:digit:]]+\\)\\(?::\\([[:digit:]]+\\)\\)?"
                                     "\\(?:: ?\\(?:[Ee]rror\\|\\([Ww]arning\\)\\)\\)?:\\) ")
                            2 3 4 (5 . nil) 1)
               (gnu-fortran ,(concat "^\\(\\(?:In file \\)?\\(.+?\\):\\([[:digit:]]+\\)\\(?:\\.\\([[:digit:]]+\\)\\)?:\\)\n"
                                     "\\(?:.*\n\\)\\{3\\}"
                                     "\\(\\(?:\\(?:Fatal \\)?Error\\|\\(Warning\\)\\)\\(?: ([[:digit:]]+)\\)?:\\)")
                            2 3 4 (6 . nil) 1 (5 compilation-message-face))
               (intel       ,(concat "^\\(.+?\\)(\\([[:digit:]]+\\)): "
                                     "\\(?:error\\|\\(warning\\|remark\\)\\) #[[:digit:]]+:")
                            1 2 nil (3 . nil))))
       (setq compilation-error-regexp-alist (mapcar 'car compilation-error-regexp-alist-alist)))))

(setq next-error-highlight t)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** GUD **********

(eval-after-load 'gud
  `(,(lambda ()
       (eval-when-compile (require 'gud))
       (setq gud-pdb-command-name "pdb3")
       (gud-tooltip-mode 1))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Grep **********

(eval-after-load 'grep
  `(,(lambda ()
       (eval-when-compile (require 'grep))
       (add-to-list 'grep-files-aliases '("f90" . "*.[fF]90") t)
       (defface grep-hit   `((t :foreground ,MHP-MAGENTA-NW :weight normal))
         "Face used for highlighting grep hits."
         :group 'grep)
       (defface grep-match `((t :foreground ,MHP-RED-BW     :weight bold))
         "Face used for highlighting grep matches."
         :group 'grep)
       (setq grep-hit-face 'grep-hit)
       (setq grep-match-face 'grep-match)
       (setq grep-context-face nil)
       (setcar (car grep-mode-font-lock-keywords) "^\\([[:alnum:]_/.+-]+\\):")
       (font-lock-add-keywords 'grep-mode
                               '(("^--$" (0 compilation-message-face t)))
                               'append))))

(add-hook 'grep-mode-hook
          (lambda ()
            (set (make-local-variable 'compilation-skip-visited) nil)
            (set (make-local-variable 'compilation-auto-jump-to-first-error) nil)))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Diff **********

(setq diff-switches "-adu")

;; We want to preactivate advice for diff-backup. Obviously, this will only work if diff-backup is fully defined at compile
;; time.
(eval-after-load 'diff
  `(,(lambda ()
       (eval-and-compile (require 'diff)))))

(defadvice diff-backup (before mhp-before-diff-backup preactivate)
  "If current buffer visits a file do not prompt for a filename."
  (interactive `(,(if buffer-file-name buffer-file-truename (read-file-name "Diff (file with backup): "))
                 ,(diff-switches))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** VC **********

(setq vc-follow-symlinks t)

(eval-after-load 'vc-annotate
  `(,(lambda ()
       (eval-when-compile (require 'vc-annotate))
       (setq vc-annotate-background MHP-BACKGROUND)
       (setq vc-annotate-color-map `(( 20 . ,MHP-RED-NW)
                                     ( 89 . ,MHP-YELLOW-NW)
                                     (158 . ,MHP-CYAN-NW)
                                     (227 . ,MHP-GREEN-NW)
                                     (296 . ,MHP-MAGENTA-NW)
                                     (365 . ,MHP-BLUE-NW)))
       (setq vc-annotate-very-old-color MHP-BLUE-NW))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** PCL-CVS **********

(eval-after-load 'log-view
  `(,(lambda ()
       (set-face-attribute 'log-view-file
                           nil
                           :foreground MHP-RED-BW :weight 'bold)
       (set-face-attribute 'log-view-message
                           nil
                           :foreground MHP-BLUE-BW :weight 'bold))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Copyright **********

(eval-after-load 'copyright
  `(,(lambda ()
       (eval-when-compile (require 'copyright))
       (setq copyright-limit nil)
       (setq copyright-regexp (replace-regexp-in-string
                               (regexp-quote "[Cc]opyright") "[Cc]opy\\(?:right\\|left\\)" copyright-regexp nil t))
       (setq copyright-names-regexp MHP-SHORT-NAME))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Skeleton **********

(eval-after-load 'skeleton
  `(,(lambda ()
       (eval-when-compile (require 'skeleton))
       (when MHP-WITH-PATCHES
         (mhp-check-is-patched "skeleton" ""))
       (setq skeleton-pair t))))


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Major Modes **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** General **********

(defun mhp-set-up-major-modes ()
  "Provide common set-up for various major modes."
  (interactive)
  (auto-fill-mode 1)
  (abbrev-mode 1)
  (goto-address-mode 1)
  (add-hook 'before-save-hook 'copyright-update nil t)
  (set (make-local-variable 'comment-add) 1)
  (setq show-trailing-whitespace t)
  ;; Setting font-lock-keywords directly instead of setting it via font-lock-defaults has drawbacks as we shall see ...
  (font-lock-add-keywords nil
                          '(("\t" (0 'underline append))
                            ("\\(?:^\\|[[:blank:]]\\)\\(FIXME\\|NOTE\\|TODO\\)[.:]" (1 'hi-yellow t)))
                          'append))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Text **********

(add-hook 'text-mode-hook
          (lambda ()
            (mhp-set-up-major-modes)
            (setq fill-column MHP-TEXT-MODE-FILL-COLUMN)
            (set (make-local-variable 'comment-auto-fill-only-comments) nil)
            (set (make-local-variable 'ispell-check-comments) t)))

(add-to-list 'auto-mode-alist '("/README\\'"           . text-mode))
(add-to-list 'auto-mode-alist '("/svn-commit\\.tmp\\'" . text-mode))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Outlines **********

(defvar outline-minor-mode-prefix)
(setq outline-minor-mode-prefix (kbd "C-c o"))

(eval-after-load 'outline
  `(,(lambda ()
       (eval-and-compile (require 'outline))
       (setq outline-blank-line t)
       (set-face-attribute 'outline-4
                           nil
                           :inherit 'font-lock-type-face)
       (set-face-attribute 'outline-5
                           nil
                           :inherit 'font-lock-constant-face)
       (set-face-attribute 'outline-6
                           nil
                           :inherit 'font-lock-builtin-face)
       (set-face-attribute 'outline-7
                           nil
                           :inherit 'font-lock-comment-face))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Org **********

(eval-after-load 'org
  `(,(lambda ()
       (eval-when-compile (require 'org))
       (setq org-log-done 'time)
       (set-face-attribute 'org-meta-line
                           nil
                           :inherit 'font-lock-preprocessor-face)
       (set-face-attribute 'org-document-info-keyword
                           nil
                           :inherit 'org-meta-line)
       (set-face-attribute 'org-document-title
                           nil
                           :foreground MHP-CYAN-BW :weight 'bold)
       (set-face-attribute 'org-document-info
                           nil
                           :foreground MHP-CYAN-NW :weight 'normal)
       (set-face-attribute 'org-checkbox
                           nil
                           :foreground MHP-FOREGROUND-BW :weight 'bold
                           :inherit 'unspecified)
       (set-face-attribute 'org-block
                           nil
                           :inherit 'font-lock-string-face)
       (set-face-attribute 'org-table
                           nil
                           :foreground 'unspecified
                           :inherit 'org-block)
       (set-face-attribute 'org-formula
                           nil
                           :foreground 'unspecified
                           :inherit 'font-lock-preprocessor-face))))

(add-hook 'org-mode-hook
          (lambda ()
            (kill-local-variable 'comment-add)
            (make-local-variable 'ispell-skip-region-alist)
            (add-to-list 'ispell-skip-region-alist '("^#\\+options:" forward-line)  t)
            ;; Due to the element of ispell-skip-region-alist responsible for skipping filenames and the like, we have to
            ;; prepend the following element.
            (add-to-list 'ispell-skip-region-alist '("#\\+begin_src" "#\\+end_src") nil)
            (set (make-local-variable 'outline-blank-line) nil)
            (set (make-local-variable 'org-tags-column) (- fill-column))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** TeX **********

(setq latex-run-command "latexmk")
(setq tex-run-command "latexmk -latex=tex -pdflatex=pdftex")
(setq tex-start-options "-pdf -pv")
(setq tex-start-commands "")

(eval-after-load 'tex-mode
  `(,(lambda ()
       (eval-when-compile (require 'tex-mode))
       (when MHP-WITH-PATCHES
         (mhp-check-is-patched "tex-mode" "tex"))
       (setq tex-compile-commands '(((concat tex-command " " tex-start-options
                                             " -pvc %f"))
                                    ((concat tex-command " " tex-start-options
                                             " -pvc -g %f"))
                                    ((concat tex-command " " tex-start-options
                                             " -pvc -gg %f"))
                                    ((concat tex-command " " tex-start-options
                                             " -pvc -rules %f"))
                                    ((concat tex-command " " tex-start-options
                                             " -pvc -diagnostics %f"))
                                    ((concat tex-command " " tex-start-options
                                             " -pv -e '$pdf_previewer = q/xpdf %%O %%S 2>\\/dev\\/null/' %f"))
                                    ((concat tex-command " " tex-start-options
                                             " -c"))
                                    ((concat tex-command " " tex-start-options
                                             " -C"))
                                    ((concat tex-command " " tex-start-options
                                             " -commands"))))
       (setq latex-indent-within-escaped-parens t)
       (define-key tex-mode-map (kbd "C-j") nil)
       (define-key tex-mode-map (kbd "C-M-j") 'tex-terminate-paragraph)
       (set-face-attribute 'tex-verbatim
                           nil
                           :foreground MHP-YELLOW-NW :weight 'normal))))

(add-hook 'tex-mode-hook
          (lambda ()
            (if (and (member (file-name-extension (or buffer-file-name "")) '("tex")) (not (eq major-mode 'plain-tex-mode)))
                (progn (outline-minor-mode 1) (outline-hide-body))
              (kill-local-variable 'fill-column)
              (kill-local-variable 'comment-auto-fill-only-comments)
              (kill-local-variable 'ispell-check-comments)
              (set (make-local-variable 'tex-fontify-script) nil))))

(add-to-list 'latex-block-names "filecontents"  t)
(add-to-list 'latex-block-names "filecontents*" t)

(eval-after-load 'tex-mode
  `(,(lambda ()
       (add-to-list 'latex-noindent-environments "filecontents" t))))

(eval-after-load 'tex-mode
  `(,(lambda ()
       (add-to-list 'tex-verbatim-environments "filecontents*" t))))

(setq ispell-tex-skip-alists `(,(delete-dups
                                 (append
                                  (car ispell-tex-skip-alists)
                                  '(("\\\\WarningFilter\\*?"      ispell-tex-arg-end 1)
                                    ("\\\\foreignlanguage"        ispell-tex-arg-end 2)
                                    ("\\\\ac\\(\\*\\|e?[slf]\\)?" ispell-tex-arg-end 1)
                                    ("\\\\printglossary"          ispell-tex-arg-end 0)
                                    ("\\\\defbibnote"             ispell-tex-arg-end 1)
                                    ("\\\\printbibliography"      ispell-tex-arg-end 0))))
                               ,(delete-dups
                                 (append
                                  (cadr ispell-tex-skip-alists)
                                  '()))))

(add-to-list 'auto-mode-alist '("[^/]\\.def\\'" . latex-mode))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** BibTeX **********

(eval-after-load 'bibtex
  `(,(lambda ()
       (eval-when-compile (require 'bibtex))
       (setq bibtex-dialect 'biblatex)
       (setq bibtex-comment-start "%")
       (setq bibtex-maintain-sorted-entries 'crossref)
       (setq bibtex-field-delimiters 'double-quotes)
       (setq bibtex-align-at-equal-sign t)
       (setq bibtex-text-indentation (+ bibtex-field-indentation (length "journalsubtitle = ")))
       (setq bibtex-contline-indentation (+ bibtex-text-indentation 1))
       (setq bibtex-entry-format '(opts-or-alts sort-fields realign unify-case delimiters last-comma whitespace page-dashes))
       (setq bibtex-autokey-names-stretch 1)
       (setq bibtex-autokey-additional-names "etal")
       (setq bibtex-autokey-name-case-convert-function 'identity)
       (setq bibtex-autokey-year-length 4)
       (setq bibtex-autokey-titlewords 0)
       (setq bibtex-autokey-titlewords-stretch 0)
       (setq bibtex-autokey-before-presentation-function (lambda (autokey) (concat autokey "a"))))))

(add-hook 'bibtex-mode-hook
          (lambda ()
            (run-hooks 'text-mode-hook)
            (when buffer-file-name
              (outline-minor-mode 1) (outline-hide-body))
            (kill-local-variable 'fill-column)))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Programming **********

(add-hook 'prog-mode-hook
          (lambda ()
            (mhp-set-up-major-modes)))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** F90 **********

(eval-after-load 'f90
  `(,(lambda ()
       (eval-when-compile (require 'f90))
       (when MHP-WITH-PATCHES
         (mhp-check-is-patched "f90" "f90"))
       (setq f90-smart-end 'no-blink)
       (setq f90-break-delimiters "[[:blank:]]")
       (setq f90-beginning-ampersand nil)
       (font-lock-add-keywords 'f90-mode
                               '(("\\w[[:blank:]]*\\(%\\)" (1 'font-lock-keyword-face keep))
                                 ("\\.\\w+\\." (0 'font-lock-keyword-face keep))
                                 ("\\(\\w+_[ft]\\)[[:blank:]]*(" (1 'font-lock-keyword-face keep)))
                               'append)
       (let* ((def "^#[[:blank:]]*define[[:blank:]]+")
              (name "[[:alpha:]_]\\w*")
              (arg name)
              (funmacro (concat "\\(" def name "(\\)[[:blank:]]*" arg "\\([[:blank:]]*,[[:blank:]]*" arg "\\)*"))
              (set-up-search-region (lambda () (goto-char (match-end 1)) (match-end 0))))
         (font-lock-add-keywords 'f90-mode
                                 `((,funmacro (,arg (,set-up-search-region) nil (0 'font-lock-variable-name-face t))))
                                 'append)))))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Sh **********

(eval-after-load 'sh-script
  `(,(lambda ()
       (eval-when-compile (require 'sh-script))
       (setq sh-backslash-column fill-column)
       (setq sh-basic-offset 2)
       (setq sh-indent-comment t)
       (set-face-attribute 'sh-heredoc
                           nil
                           :foreground 'unspecified :weight 'unspecified
                           :inherit 'font-lock-string-face)
       (set-face-attribute 'sh-quoted-exec
                           nil
                           :foreground 'unspecified
                           :inherit 'font-lock-constant-face))))

(add-hook 'sh-mode-hook
          (lambda ()
            ;; If sh-set-shell is called later on the keywords added by mhp-set-up-major-modes will be removed. So we need to
            ;; add them once more ...
            (add-hook 'sh-set-shell-hook 'mhp-set-up-major-modes nil t)))

(add-to-list 'auto-mode-alist '("/profile\\'"                                       . sh-mode))
(add-to-list 'auto-mode-alist '("/bash\\(rc\\|_profile\\|_common\\|\\.bashrc\\)\\'" . sh-mode))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Python **********

(eval-after-load 'python
  `(,(lambda ()
       (eval-when-compile (require 'python))
       (setq python-skeleton-autoinsert t)
       (setq python-shell-interpreter "python3")
       (setq python-shell-font-lock-enable nil))))

(add-hook 'python-mode-hook
          (lambda ()
            (setq fill-column 79)
            (kill-local-variable 'comment-add)))

(add-to-list 'auto-mode-alist '("/SConstruct\\'" . python-mode))
(add-to-list 'auto-mode-alist '("/SConscript\\'" . python-mode))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Perl **********

(eval-after-load 'perl-mode
  `(,(lambda ()
       (eval-when-compile (require 'perl-mode))
       (setq perl-indent-level 2)
       (setq perl-continued-statement-offset 2)
       (setq perl-continued-brace-offset -2))))

(add-to-list 'auto-mode-alist '("/LatexMk\\'"       . perl-mode))
(add-to-list 'auto-mode-alist '("/\\.?latexmkrc\\'" . perl-mode))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Makefile **********

(eval-after-load 'make-mode
  `(,(lambda ()
       (eval-when-compile (require 'make-mode))
       (setq makefile-backslash-column fill-column)
       (setq makefile-target-colon " :")
       (setq makefile-tab-after-target-colon nil)
       (define-key makefile-mode-map (kbd "C-c =") 'makefile-insert-macro)
       (define-key makefile-mode-map (kbd "C-c $") 'makefile-insert-macro-ref)
       (define-key makefile-mode-map (kbd "C-c :") 'makefile-insert-target)
       (define-key makefile-mode-map (kbd "C-c .") 'makefile-insert-special-target)
       (define-key makefile-mode-map (kbd "C-c %") 'makefile-insert-target-ref)
       (set-face-attribute 'makefile-space
                           nil
                           :background 'unspecified :underline nil
                           :inherit 'trailing-whitespace))))

(add-hook 'makefile-mode-hook
          (lambda ()
            (kill-local-variable 'indent-tabs-mode)
            (kill-local-variable 'indent-line-function)
            (font-lock-add-keywords nil
                                    '(("\\\\$" (0 'font-lock-string-face keep)))
                                    'append)))

(add-hook 'makefile-gmake-mode-hook
          (lambda ()
            (set (make-local-variable 'makefile-macro-assign) " := ")))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Conf **********

(eval-after-load 'conf-mode
  `(,(lambda ()
       (eval-when-compile (require 'conf-mode))
       (put 'conf-assignment-column 'safe-local-variable 'integerp))))

(add-hook 'conf-mode-hook
          (lambda ()
            (run-hooks 'prog-mode-hook)))

(eval-after-load 'conf-mode
  `(,(lambda ()
       (add-to-list 'conf-space-keywords-alist '("/\\.?inputrc\\'"                  . "set")                   t)
       (add-to-list 'conf-space-keywords-alist '("/\\.?unburden-home-dir\\.list\\'" . "[drm][[:blank:]]+[df]") t))))

(add-to-list 'auto-mode-alist '("/\\.?inputrc\\'"                  . conf-space-mode))
(add-to-list 'auto-mode-alist '("/\\.?unburden-home-dir\\.list\\'" . conf-space-mode))
(add-to-list 'auto-mode-alist '("/\\.?xpdfrc\\'"                   . conf-space-mode))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Diff Mode **********

(eval-after-load 'diff-mode
  `(,(lambda ()
       (eval-when-compile (require 'diff-mode))
       (define-key diff-mode-map (kbd "M-DEL") nil)
       (define-key diff-mode-map (kbd "M-SPC") nil)
       (set-face-attribute 'diff-context
                           nil
                           :inherit 'unspecified)
       (set-face-attribute 'diff-header
                           nil
                           :background 'unspecified :foreground MHP-BLUE-BW :weight 'bold)
       (set-face-attribute 'diff-file-header
                           nil
                           :background 'unspecified :foreground MHP-RED-BW :weight 'bold)
       (set-face-attribute 'diff-changed
                           nil
                           :foreground MHP-GREEN-NW :weight 'normal)
       (set-face-attribute 'diff-added
                           nil
                           :background 'unspecified :foreground MHP-CYAN-NW :weight 'normal)
       (set-face-attribute 'diff-removed
                           nil
                           :background 'unspecified :foreground MHP-YELLOW-NW :weight 'normal)
       (set-face-attribute 'diff-refine-changed
                           nil
                           :background MHP-BLUE-NW
                           :inverse-video 'unspecified)
       (set-face-attribute 'diff-refine-added
                           nil
                           :background 'unspecified)
       (set-face-attribute 'diff-refine-removed
                           nil
                           :background 'unspecified))))

(add-hook 'diff-mode-hook
          (lambda ()
            (run-hooks 'prog-mode-hook)
            (kill-local-variable 'show-trailing-whitespace)
            (font-lock-remove-keywords nil
                                       '(("\t" (0 'underline append))))
            (set (make-local-variable 'comment-start) "#")))


;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;
;;
;; ********** Key Bindings **********
;;
;;
;;---------------------------------------------------------------------------------------------------------------------------;;
;;***************************************************************************************************************************;;
;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Current Global Key Map **********

(global-set-key (kbd "DEL") 'backward-delete-char-untabify)

(global-set-key (kbd "C-<tab>") (kbd "<tab>"))

(global-set-key (kbd "<f5>") 'compile)
(global-set-key (kbd "<f6>") 'shell)
(global-set-key (kbd "<f7>") 'customize-browse)
(global-set-key (kbd "<f8>") 'conf-mode)

(global-set-key (kbd "C-c c") 'mhp-toggle-fill-column)
(global-set-key (kbd "C-c d") 'diff-backup)
(global-set-key (kbd "C-c f") 'find-file-at-point)
(global-set-key (kbd "C-c F") 'find-name-dired)
(global-set-key (kbd "C-c g") 'lgrep)
(global-set-key (kbd "C-c G") 'rgrep)
(global-set-key (kbd "C-c i") 'ispell-buffer)
(global-set-key (kbd "C-c I") 'ispell-comments-and-strings)
(global-set-key (kbd "C-c n") 'mhp-highlight-nonascii-characters)
(global-set-key (kbd "C-c p") 'mhp-move-to-matching-parenthesis)
(global-set-key (kbd "C-c v") 'set-variable)

;;---------------------------------------------------------------------------------------------------------------------------;;


;; ********** Other Key Maps **********

(unless (lookup-key ctl-x-4-map "1")
  (define-key ctl-x-4-map "1" 'mhp-kill-other-buffers-and-windows))

(unless (lookup-key help-map "A")
  (define-key help-map "A" 'apropos))
(unless (lookup-key help-map "o")
  (define-key help-map "o" 'describe-face))

;;---------------------------------------------------------------------------------------------------------------------------;;


;; LocalWords: ispell Tabbar mhp setq Conf alist PCL GUD ansi color
