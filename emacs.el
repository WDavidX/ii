;; Emacs general settings, applicable to all versions
;; ==========    ==========

(defvar ii-dir (if load-file-name
                  ;; File is being loaded.
                  (file-name-directory load-file-name)
                  ;; File is being evaluated using, for example, `eval-buffer'.
                  default-directory))                       


;;(defvar ii-dir (concat emacs-home-dir "ii/"))

;;(if (eq system-type 'windows-nt)
;;	( progn
;;    ;;(setq-default default-directory default-directory)
;;    ;;(load-file (concat(default-directory "ii/")))
;;    (defvar ii-dir default-directory)
;;  ))  
;;(message ii-dir)

(define-key isearch-mode-map [backspace] 'isearch-delete-char)
;;============================================================
;;========== General modes and varibles
;;============================================================
;; ==========  Modes  ==========
(display-time)
(global-font-lock-mode t)
(show-paren-mode t)
(menu-bar-mode -1)
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
(setq org-replace-disputed-keys t)
(fset 'yes-or-no-p 'y-or-n-p)  ;; ask by y or n
(setq-default tab-width 4)

;; ==========  Disable varibles  ==========
(setq-default indent-tab-mod nil)
(setq initial-scratch-message nil)
(setq auto-save-default nil)    ;disable auto save
(setq auto-window-vscroll nil)
(setq vc-handled-backends nil)
(setq backup-inhibited t) 		;disable backup

;; System Coding
(setq buffer-file-coding-system 'utf-8-unix)
(setq default-file-name-coding-system 'utf-8-unix)
(setq default-keyboard-coding-system 'utf-8-unix)
(setq default-sendmail-coding-system 'utf-8-unix)
(setq default-terminal-coding-system 'utf-8-unix)

;;============================================================
;;========== Evaluation of the configuration 
;;============================================================
(if (>= emacs-major-version 19)
	( progn
	  (message "Loading setup for Emacs 19")	  
	 ))
;;============================================================
;;========== Evaluation of the configuration 
;;============================================================
(if (>= emacs-major-version 20)
	( progn
 	  (message "Loading setup for Emacs 20")
    ))
;;============================================================
;;========== Evaluation of the configuration 
;;============================================================
(if (>= emacs-major-version 21)
	( progn
	  (message "Loading setup for Emacs 21")	  
	  (global-linum-mode 1)
	 ))
;;============================================================
;;========== Evaluation of the configuration 
;;============================================================
(if (>= emacs-major-version 22)
	( progn
	  (message "Loading setup for Emacs 22")
	))

;;============================================================
;;========== Evaluation of the configuration 
;;============================================================
(defun my-fun1()
  (message "in-my-fun11"))

(if (>= emacs-major-version 23)
	( progn
	  (message "Loading setup for Emacs 23")
	))



;;============================================================
;;========== Evaluation of the configuration 
;;============================================================

(defun os-path-join (a &rest ps)
  (let ((path a))
    (while ps
      (let ((p (pop ps)))
        (cond ((string-prefix-p "/" p)
               (setq path p))
              ((or (not path) (string-suffix-p "/" p))
               (setq path (concat path p)))
              (t (setq path (concat path "/" p))))))
    path))

(defun window-half-height ()
  (max 1 (/ (1- (window-height (selected-window))) 2)))
(global-unset-key (kbd "M-p"))
(global-unset-key (kbd "M-n"))
(global-set-key (kbd "M-n")     ; page down
  (lambda () (interactive)
    (condition-case nil (scroll-up (window-half-height))
      (end-of-buffer (goto-char (point-max))))))
(global-set-key (kbd "M-p")
  (lambda () (interactive) ; page up
    (condition-case nil (scroll-down (window-half-height))
      (beginning-of-buffer (goto-char (point-min))))))
      
(global-unset-key (kbd "M-m"))
(global-set-key (kbd "M-m") 'set-mark-command)
(global-unset-key [(f9)])
(global-set-key [(f9)] (lambda() (interactive) (switch-to-buffer "*scratch*")))
(global-unset-key [(f10)])
(global-set-key [(f10)] 'eval-last-sexp)
(global-unset-key [(f11)])
(global-set-key [(f11)] (lambda() (interactive) (find-file (os-path-join ii-dir "emacs.el"))))
(global-unset-key [(f12)])
(global-set-key [(f12)] (lambda() (interactive) (save-some-buffers (buffer-file-name)) (eval-buffer)))


(global-set-key "\C-o" 'other-window)
(global-set-key "\C-z" 'undo)
(global-set-key (kbd "C-x 2") 'split-window-horizontally)
(global-set-key (kbd "C-x 3") 'split-window-vertically)
(global-set-key "\M-z" 'repeat-complex-command)

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

;;============================================================
;;========== Loading user defined functions
;;============================================================


;;========== TODO
;;============================================================
;(recentf-mode 1)
;

