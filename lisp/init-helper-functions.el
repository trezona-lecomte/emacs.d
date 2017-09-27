;;; Generic helper functions that are useful across different modes

(defun ktlc/copy-current-buffer-path-to-clipboard ()
  "Put the current buffer's path on the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))


(require 'cl-lib)
(defun sum-numbers-in-region (start end)
  "Display the sum of the numbers between START and END."
  (interactive "r")
  (message "%s"
           (cl-reduce #'+
                      (split-string (buffer-substring start
                                                      end))
                      :key #'string-to-number)))

(provide 'init-helper-functions)
