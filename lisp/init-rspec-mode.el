;;; Basic rspec setup
(require-package 'rspec-mode)

(require 'rspec-mode)
(require 'init-flux-markets)

(setq rspec-spec-command " bundle exec spring rspec")
(setq rspec-use-bundler-when-possible nil)
(setq rspec-use-spring-when-possible nil)
(setq rspec-primary-source-dirs '("app" "lib" "core" "psnz" "psau" "psuk"))
(setq rspec-command-options "--color")

(define-key rspec-verifiable-mode-keymap (kbd "v") 'flux-rspec-verify)
(define-key rspec-verifiable-mode-keymap (kbd "r") 'flux-rspec-rerun)
(define-key rspec-verifiable-mode-keymap (kbd "f") 'flux-rspec-run-last-failed)
(define-key rspec-verifiable-mode-keymap (kbd "s") 'flux-rspec-verify-method)
(define-key rspec-mode-keymap (kbd "s") 'flux-rspec-verify-single)


(defun flux-rspec-verify (market)
  "Run spec for the current buffer in the specified market."
  (interactive
   (list (flux-read-market)))
  (flux-start-spring-if-not-running)
  (flux-override-rspec-function 'rspec-verify))

(defun flux-rspec-verify-single (market)
  "Run spec for the current example in the specified market."
  (interactive
   (list (flux-read-market)))
  (flux-start-spring-if-not-running)
  (flux-override-rspec-function 'rspec-verify-single))

(defun flux-rspec-verify-method (market)
  "Run spec for the current example in the specified market."
  (interactive
   (list (flux-read-market)))
  (flux-start-spring-if-not-running)
  (flux-override-rspec-function 'rspec-verify-method))

(defun flux-rspec-rerun (market)
  "Re-run the last RSpec invocation in the specified market."
  (interactive
   (list (flux-read-market)))
  (flux-start-spring-if-not-running)
  (flux-override-rspec-function 'rspec-rerun))

(defun flux-rspec-run-last-failed (market)
  "Run just the specs that failed during the last invocation in the specified market."
  (interactive
   (list (flux-read-market)))
  (flux-start-spring-if-not-running)
  (flux-override-rspec-function 'rspec-run-last-failed))

(defun flux-override-rspec-function (rspec-function)
  (let ((rspec-spec-command
         (format "PS_MARKET=%s bundle exec spring rspec" market)))
    (funcall rspec-function)))

(defun flux-start-spring-if-not-running ()
  (if (string-match-p "Spring is not running"
                      (shell-command-to-string (format "cd %s && DEPRECATION=%s PS_MARKET=%s bundle exec spring status" (shell-quote-argument (rspec-project-root)) "stderr" (shell-quote-argument market))))
      (progn
        (message (format "Powershop RSpec: Starting spring in %s" market))
        (async-shell-command (format "cd %s && DEPRECATION=%s PS_MARKET=%s bundle exec spring server" (shell-quote-argument (rspec-project-root)) "stderr" (shell-quote-argument market)) (format "*%s spring server*" market)))
    (message (format "Powershop RSpec: Spring already running in %s, using existing server." market))))

(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(provide 'init-rspec-mode)
