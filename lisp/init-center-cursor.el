(require-package 'centered-cursor-mode)

;; Enable centered-cursor-mode, but disable in terminal modes. From
;; http://stackoverflow.com/a/6849467/519736.

;; Also disable in Info mode, because it breaks going back with the
;; backspace key.

(define-global-minor-mode global-centered-cursor-mode centered-cursor-mode
  (lambda ()
    (when (not (memq major-mode
                     (list 'Info-mode 'term-mode 'eshell-mode 'shell-mode 'erc-mode)))
      (centered-cursor-mode))))

(global-centered-cursor-mode 1)

(provide 'init-center-cursor)
