;;; package --- initialisation
;;; Commentary:
;;; init routine for Emacs

;;; Code:
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fill-column 80)
 '(initial-buffer-choice "C:\\code")
 '(scroll-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Set initial frame position and size
;(setq initial-frame-alist
      ;'((top . 0) (left . 0) (width . 180) (height . 60)))

;; Start emacs maximized on Windows. If using X Windows, try starting emacs
;;  with 'emacs -mm'
(when (eq system-type 'windows-nt)
    (w32-send-sys-command 61488))


;; Enable line numbers
(add-hook 'find-file-hook (lambda () (linum-mode 1)))


;; Tail (refresh) log files automatically
(add-to-list 'auto-mode-alist '("\\.log\\'" . auto-revert-mode))


(defun save-macro (name)
  "Save a macro.
Take a NAME as argument and save the last defined macro under
name at the end of your .emacs"
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
    (while (search-forward "(\n)" nil t)
      (replace-match " ")
      (clipboard-kill-ring-save (point-min) (point-max))
    )))


;; pretty print xml region
(defun pretty-print-xml-region (begin end)
  "Pretty format XML markup in region between BEGIN and END.
The function inserts linebreaks
to separate tags that have nothing but whitespace between them.
It then indents the markup by using nxml's indentation rules."
  (interactive "r")
  (require 'cl)
  (save-excursion
    (nxml-mode)
    (goto-char begin)
    ;; split <foo><foo> or </foo><foo>, but not <foo></foo>
    (while (search-forward-regexp ">[ \t]*<[^/]" end t)
      (backward-char 2) (insert "\n") (incf end))
    ;; split <foo/></foo> and </foo></foo>
    (goto-char begin)
    (while (search-forward-regexp "<.*?/.*?>[ \t]*<" end t)
      (backward-char) (insert "\n") (incf end))
    (indent-region begin end nil)
    (normal-mode))
  (message "XML indented"))


;; Set IPython interpreter
(defvar python-shell-interpreter "ipython")
(defvar python-shell-interpreter-args "-i")
(add-hook 'inferior-python-mode-hook (lambda ()
                                       (progn
                                         (python-shell-send-string-no-output "%load_ext autoreload")
                                         (python-shell-send-string-no-output "%autoreload 2"))))

(defun python-send-buffer-args (args)
  "Run Python script with ARGS as arguments."
  (interactive "sPython arguments: ")
  (let ((source-buffer (current-buffer)))
    (with-temp-buffer
      (insert "import sys; sys.argv = '''" args "'''.split()\n")
      (insert-buffer-substring source-buffer)
      (python-send-buffer))))


(defun python-shell-repeat ()
  "Repeat the last command in the Python shell."
  (switch-to-buffer-other-window "*Python*")
  (goto-char (point-max))
  (comint-previous-input)
  (insert "\n"))


(provide 'custom)
;;; custom.el ends here
