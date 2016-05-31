(require-package 'feature-mode)
(require-package 'cucumber-goto-step)

(add-hook 'feature-mode-hook
          (lambda () (local-set-key (kbd "M-.") 'jump-to-cucumber-step)))

(provide 'init-feature-mode)
