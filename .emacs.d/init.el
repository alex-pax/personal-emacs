;; customizing emacs backup file behavior
;;
;; store backup files in a subdirectory of the file's main directory
(setq backup-directory-alist `(("." . "~/.saves")))
;;
;; keep up to 10 versions of files on save
;; delete versions older than the 10th
;; copy the files instead of renaming them (preserves symlinks)
 (setq version-control t ;; Use version numbers for backups.
        kept-new-versions 10 ;; Number of newest versions to keep.
        kept-old-versions 0 ;; Number of oldest versions to keep.
        delete-old-versions t ;; Don't ask to delete excess backup versions.
        backup-by-copying t) ;; Copy all files, don't rename them.




;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;(package-initialize)

;; org-mode settings
;;Global:
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(setq org-log-done t)
(setq org-agenda-files '("c:/Users/apax/org"))
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todo.org" "Tasks")
	 "* TODO %?\n %i\n %a")
	("d" "Deadline" entry (file+olp+datetree "~/org/deadlines.org")
	 "* DEADLINE PENDING %?\nDue by: %^{deadline}t\n%^{Assignee:|self|wmann|ngufarov}p\n Created: %U\n %i\n %a")))

;; Local:
;; Creates "Simple agenda view" to show all TODO items across org files
;; Places it in the agenda menu bound to "c"
(setq org-agenda-custom-commands
      '(("c" "Simple agenda view"
	 ((agenda "")
	  (alltodo "")))))

;;
;; Create a second cycle of status's for "CANCELLED" items.
;; To bounce between subsequences use C-S-RIGHT and C-S-LEFT
;;  then use the normal C-c C-t to cycle through the status of
;;  that subsequence
(setq org-todo-keywords
      '((sequence "TODO" "|" "DONE")
	(sequence "RESCHEDULED" "|" "CANCELLED")
	(sequence "DEADLINE PENDING" "|" "DEADLINE MET" "|" "DEALINE MISSED")))

;; Org mode code blocks:
;;

;; Specificy where babel finds R:

(setq org-babel-R-command "c:/Progra~1/R/R-4.3.0/bin/x64/R.exe --slave --no-save")
;; add R to languages available to babel:
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)))
;; Syntax highlight in #+BEGIN_SRC blocks
(setq org-src-fontify-natively t)

;; Don't prompt before running code in org
(setq org-confirm-babel-evaluate nil)

;;Setting up ESS
;; launch ess/r at startup:
(require 'ess-r-mode)
(setq ess-directory-containing-R "c:/Program Files/R/R-4.3.0/bin/")
;; Add to list of prefixes recognized by ESS. 
;; Matching versions will appear after doing M-x R <TAB> <TAB> 
(setq ess-r-versions '("R-1" "R-2" "R-3" "R-4" "R-current" "R-devel" "R-patched"))
(load "C:/Users/apax/.emacs.d/elpa/ess-20230419.1527/ess-site.el")

;; Set default R version, (i.e. the one launched by typing M-x R <RET>)
(setq inferior-R-program-name "C:/Program Files/R/R-4.3.0/bin/x64/Rterm.exe")


;; An example of window configuration:
(setq display-buffer-alist
      '(("*R Dired"
     (display-buffer-reuse-window display-buffer-at-bottom)
     (window-width . 0.5)
     (window-height . 0.25)
     (reusable-frames . nil))
    ("*R"
     (display-buffer-reuse-window display-buffer-in-side-window)
     (side . right)
     (slot . -1)
     (window-width . 0.5)
     (reusable-frames . nil))
    ("*Help"
     (display-buffer-reuse-window display-buffer-in-side-window)
     (side . right)
     (slot . 1)
     (window-width . 0.5)
     (reusable-frames . nil))))

;; set ess-keybinding for the pipe operator:
;(defun pipe()
;  "R - |> operator or 'then' pipe operator"
;  (interactive)
;  (just-one-space 1)
;  (insert "|>")
;  (reindent-then-newline-and-indent))
;(define-key ess-mode-map (kbd "C-m") 'pipe)
;(define-key inferior-ess-mode-map (kbd "C-m") 'pipe)


;; configure asynchronous code execution,
;;  which allows you to continue editing document
;;  while code runs in the background:
(require 'ob-async)




;; Text mode global setting: turn on auto fill
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Don't want to see the splash screen (emacs logo)
;;  everytime I launch the program
(setq inhibit-splash-screen t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(custom-enabled-themes '(misterioso))
 '(org-startup-folded t)
 '(package-selected-packages
   '(poly-R polymode ample-theme ## speed-type auto-complete ob-async ess)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'leuven t)

;; then in your init you can load all of the themes
;; without enabling theme (or just load one)
;(load-theme 'ample t t)
;(load-theme 'ample-flat t t)
; (load-theme 'ample-light t t)
;; choose one to enable
;(enable-theme 'ample)
;(enable-theme 'ample-flat)
;; (enable-theme 'ample-light)

;;
;; Settings to set the default frame size.
(if (display-graphic-p)
    (progn
      (setq initial-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 106) ; chars
              (height . 45) ; lines
              (left . 50)
              (top . 50)))
      (setq default-frame-alist
            '(
              (tool-bar-lines . 0)
              (width . 106)
              (height . 45)
              (left . 50)
              (top . 50))))
  (progn
    (setq initial-frame-alist '( (tool-bar-lines . 0)))
    (setq default-frame-alist '( (tool-bar-lines . 0)))))

;; package settings

(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
