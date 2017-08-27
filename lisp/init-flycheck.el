(when (maybe-require-package 'flycheck)
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (setq flycheck-display-errors-function #'flycheck-display-error-messages-unless-error-list)

  ;; Tell flycheck when to check syntax automatically:
  (setq flycheck-check-syntax-automatically '(save mode-enabled))

  (define-key global-map (kbd "C-c b") 'flycheck-buffer)

  (when (maybe-require-package 'flycheck-color-mode-line)
    (add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))


(provide 'init-flycheck)
