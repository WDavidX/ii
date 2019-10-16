;; Emacs general settings, applicable to all versions
;; ==========    ==========

(setq load-path-startup load-path)

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/")))

(define-key isearch-mode-map [backspace] 'isearch-delete-char)
;;============================================================
;;========== General modes and varibles
;;============================================================
;; ==========  Modes  ==========
(display-time)
(global-font-lock-mode t)
(show-paren-mode t)
(menu-bar-mode t)
(tool-bar-mode -1)


;; ==========  Enable varibles  ==========
(setq inhibit-splash-screen t)
(setq inhibit-startup-echo-area-message t)
(setq initial-major-mode 'text-mode)
(setq inhibit-startup-message t)  ;; Disable Startup Message
(setq scroll-margin 3 scroll-conservatively 10000 scroll-up-aggressively 0.01 scroll-down-aggressively 0.01) ; scroll margin
(setq compilation-scroll-output t)
(setq frame-title-format (list "%b %p  [%f] " (getenv "USERNAME") " %s %Z   " emacs-version))
(setq require-final-newline t)
;;(setq org-replace-disputed-keys t)
(fset 'yes-or-no-p 'y-or-n-p)  ;; ask by y or n
(setq-default tab-width 4)

;; ==========  Disable varibles  ==========
(setq-default indent-tab-mod nil)
(setq initial-scratch-message nil)
(setq auto-save-default nil)    ;disable auto save
(setq auto-window-vscroll nil)
(setq vc-handled-backends nil)
(setq backup-inhibited t) ;disable backup

;; System Coding
(setq buffer-file-coding-system 'utf-8-unix)
(setq default-file-name-coding-system 'utf-8-unix)
(setq default-keyboard-coding-system 'utf-8-unix)
(setq default-sendmail-coding-system 'utf-8-unix)
(setq default-terminal-coding-system 'utf-8-unix)






;; set new method of kill a whole line
(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))
(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
	   (line-beginning-position 2)))))
(defun copy-line (arg)
      "Copy lines (as many as prefix argument) in the kill ring.
      Ease of use features:
      - Move to start of next line.
      - Appends the copy on sequential calls.
      - Use newline as last char even on the last line of the buffer.
      - If region is active, copy its lines."
      (interactive "p")
      (let ((beg (line-beginning-position))
	    (end (line-end-position arg)))
	(when mark-active
	  (if (> (point) (mark))
	      (setq beg (save-excursion (goto-char (mark)) (line-beginning-position)))
	    (setq end (save-excursion (goto-char (mark)) (line-end-position)))))
	(if (eq last-command 'copy-line)
	    (kill-append (buffer-substring beg end) (< end beg))
	  (kill-ring-save beg end)))
      (kill-append "\n" nil)
      (beginning-of-line (or (and arg (1+ arg)) 2))
      (if (and arg (not (= 1 arg))) (message "%d lines copied" arg)))

(defun my-kill-ring-save (beg end flash)
  (interactive (if (use-region-p)
		   (list (region-beginning) (region-end) nil)
		 (list (line-beginning-position)
		       (line-beginning-position 2) 'flash)))
  (kill-ring-save beg end)
  (when flash
    (save-excursion
      (if (equal (current-column) 0)
	  (goto-char end)
	(goto-char beg))
      (sit-for blink-matching-delay))))
(global-set-key [remap kill-ring-save] 'my-kill-ring-save)

