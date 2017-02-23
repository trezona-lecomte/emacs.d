;;; Basic rspec setup
(require-package 'rspec-mode)
(require 'rspec-mode)

(setq rspec-spec-command " bundle exec spring rspec")
(setq rspec-use-bundler-when-possible nil)
(setq rspec-use-spring-when-possible nil)
(setq rspec-primary-source-dirs '("app" "lib" "core" "psnz" "psau" "psuk"))
(setq rspec-command-options "--color")

(define-key rspec-verifiable-mode-keymap (kbd "v") 'powershop-rspec-verify)
(define-key rspec-verifiable-mode-keymap (kbd "s") 'powershop-rspec-verify-single)
(define-key rspec-verifiable-mode-keymap (kbd "r") 'powershop-rspec-rerun)

(defconst powershop-markets '("nz" "au" "uk"))
(defvar powershop-rspec-verify-history nil)

(defun find-file-in-home ()
  (interactive)
  (ido-find-file-in-dir "~/powershop"))

(defun powershop-rspec-verify (market)
  "Run spec for the current buffer in the specified market."
  (interactive
   (list (completing-read "Market: " powershop-markets nil t
                          nil
                          'powershop-rspec-verify-history
                          (or (car powershop-rspec-verify-history) "uk")
                          )))
  (let ((rspec-spec-command
         (format "PS_MARKET=%s bundle exec spring rspec" market)))
    (rspec-verify)))

(defun powershop-rspec-verify-single (market)
  "Run spec for the current example in the specified market."
  (interactive
   (list (completing-read "Market: " powershop-markets nil t
                          nil
                          'powershop-rspec-verify-history
                          (or (car powershop-rspec-verify-history) "uk")
                          )))
  (let ((rspec-spec-command
         (format "PS_MARKET=%s bundle exec spring rspec" market)))
    (rspec-verify-single)))

(defun powershop-rspec-rerun (market)
  "Re-run the last RSpec invocation in the specified market."
  (interactive
   (list (completing-read "Market: " powershop-markets nil t
                          nil
                          'powershop-rspec-verify-history
                          (or (car powershop-rspec-verify-history) "uk")
                          )))
  (let ((rspec-spec-command
         (format "PS_MARKET=%s bundle exec spring rspec" market)))
    (rspec-rerun)))


(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(provide 'init-rspec-mode)
