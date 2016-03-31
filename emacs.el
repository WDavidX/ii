;; Emacs general settings, applicable to all versions
;; ==========    ==========

;;============================================================
;;========== General modes and varibles
;;============================================================
;; ==========  Modes  ==========
(display-time)
(global-font-lock-mode t)
(show-paren-mode t)
(menu-bar-mode nil)
(tool-bar-mode nil)

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
;;========== TODO
;;============================================================
;(recentf-mode 1)
