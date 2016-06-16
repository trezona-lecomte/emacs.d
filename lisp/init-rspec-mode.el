;;; Basic rspec setup
(require-package 'rspec-mode)
(require 'rspec-mode)

(setq rspec-spec-command " bundle exec spring rspec")
(setq rspec-use-bundler-when-possible nil)
(setq rspec-use-spring-when-possible nil)
(setq rspec-primary-source-dirs '("app" "lib" "core" "psnz" "psau" "psuk"))
(setq rspec-command-options "--color")


;;; TODO: make the following work for other spec commands:

;;; TODO: only redefine this key if we're in the Powershop repo:
(define-key rspec-verifiable-mode-keymap (kbd "v") 'powershop-rspec-verify)

(defconst powershop-markets '("nz" "au" "uk"))
(defvar powershop-rspec-verify-history nil)

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

;; (defun powershop-migrate-all ()
;;   "Migrate all powershop market development databases"
;;   (interactive)
;;   (shell-command "nmigrate && amigrate && umigrate&"))


(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(provide 'init-rspec-mode)
