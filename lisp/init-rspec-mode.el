;;; Basic rspec setup
(require-package 'rspec-mode)

(setq rspec-spec-command "bundle exec spring rspec")
(setq rspec-use-bundler-when-possible nil)
(setq rspec-use-spring-when-possible nil)
(setq rspec-primary-source-dirs '("app" "lib" "core"))
(setq rspec-command-options "--color")

;;; Enable binding.pry & byebug in spec compilation:
(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(provide 'init-rspec-mode)
