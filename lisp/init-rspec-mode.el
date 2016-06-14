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

(defun powershop-rspec-verify ()
  "Run spec for the current buffer in the specified market."
  (interactive)
  (let ((market (read-string "Market: " (last-specced-market))))
    (setq rspec-spec-command (concat "PS_MARKET=" market
                                     " bundle exec spring rspec")))
  (rspec-verify))

(defun last-specced-market ()
  (car (filter 'is-market-label minibuffer-history)))

(defun is-market-label (str)
  (member str '("nz" "au" "uk")))

(defun filter (condp lst)
  (delq nil
        (mapcar (lambda (x) (and (funcall condp x) x)) lst)))

;; (defun powershop-migrate-all ()
;;   "Migrate all powershop market development databases"
;;   (interactive)
;;   (shell-command "nmigrate && amigrate && umigrate&"))


(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(provide 'init-rspec-mode)
