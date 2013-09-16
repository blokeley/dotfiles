(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(custom-enabled-themes (quote (wombat)))
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "C:\\workspace")
 '(initial-scratch-message nil)
 '(iswitchb-mode t)
 '(package-archives (quote (("melpa" . "http://melpa.milkbox.net/packages/") ("gnu" . "http://elpa.gnu.org/packages/"))))
 '(recentf-mode t)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(use-dialog-box nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Set initial frame position and size
(setq initial-frame-alist
      '((top . 1) (left . 1) (width . 100) (height . 45)))

;; Start emacs maximized on Windows. Is using X Windows, try starting emacs
;;  with 'emacs -mm'
;(w32-send-sys-command 61488)
;; If this doesn't work, try
;(w32-send-sys-command #xf030)


(defun save-macro (name)                  
    "save a macro. Take a name as argument
     and save the last defined macro under 
     this name at the end of your .emacs"
     (interactive "SName of the macro :")  ; ask for the name of the macro    
     (kmacro-name-last-macro name)         ; use this name for the macro    
     (find-file user-init-file)            ; open ~/.emacs or other user init file 
     (goto-char (point-max))               ; go to the end of the .emacs
     (newline)                             ; insert a newline
     (insert-kbd-macro name)               ; copy the macro 
     (newline)                             ; insert a newline
     (switch-to-buffer nil))               ; return to the initial buffer

(defun clean-text()
  "Yank text from the clipboard/killring, replace newlines with spaces,
   and copy to clipboard."
  (interactive)
  (with-temp-buffer
    (yank) ; Yank (paste) contents of clipboard
    (goto-char (point-min))
    (replace-string "\n" " ")
    (clipboard-kill-ring-save (point-min) (point-max))
    ))
