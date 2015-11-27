;;; Basic rspec setup
(require-package 'rspec-mode)


;;; Enable binding.pry & byebug in spec compilation:
(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(provide 'init-rspec-mode)
