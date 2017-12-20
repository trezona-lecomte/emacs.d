(require-package 'rspec-mode)

(require 'rspec-mode)
(require 'init-flux-markets)


(define-key rspec-mode-keymap (kbd "C-)") 'paredit-forward-slurp-sexp)
(define-key rspec-mode-keymap (kbd "C-(") 'paredit-backward-slurp-sexp)

;; Override the default rspec-spec-command and turn off built-in bundler & spring detection
(setq rspec-spec-command " bundle exec spring rspec")
(setq rspec-use-bundler-when-possible nil)
(setq rspec-use-spring-when-possible nil)
(setq rspec-primary-source-dirs '("app" "lib" "core" "psnz" "psau" "psuk"))
(setq rspec-command-options "--color")


;; Override the default keybindings for rspec-mode so that they call the flux-specific versions instead
(define-key rspec-verifiable-mode-keymap (kbd "v") 'flux/rspec-verify)
(define-key rspec-verifiable-mode-keymap (kbd "r") 'flux/rspec-rerun)
(define-key rspec-verifiable-mode-keymap (kbd "f") 'flux/rspec-run-last-failed)
(define-key rspec-verifiable-mode-keymap (kbd "s") 'flux/rspec-verify-method)
(define-key rspec-mode-keymap (kbd "s") 'flux/rspec-verify-single)

;; (define-key rspec-verifiable-mode-keymap (kbd "v") 'rspec-verify)
;; (define-key rspec-verifiable-mode-keymap (kbd "r") 'rspec-rerun)
;; (define-key rspec-verifiable-mode-keymap (kbd "f") 'rspec-run-last-failed)
;; (define-key rspec-verifiable-mode-keymap (kbd "s") 'rspec-verify-method)
;; (define-key rspec-mode-keymap (kbd "s") 'rspec-verify-single)


(defun flux/run-specs (rspec-command market)
  (if (equal "all" market)
      (progn
        (mapc 'flux/start-spring-for-market (remove "all" flux-markets))
        (flux/run-specs-in-market rspec-command "au")
        (flux/run-specs-in-market rspec-command "nz")
        (flux/run-specs-in-market rspec-command "uk"))
    (progn
      (flux/start-spring-for-market market)
      (flux/run-specs-in-market rspec-command market))))

(defun flux/run-specs-in-market (rspec-function market)
  (let ((rspec-spec-command
         (format "PS_MARKET=%s bundle exec spring rspec" market)))
    (cond ((equal "au" market) (setq compilation-buffer-name-function 'flux/au-spec-buffer))
          ((equal "nz" market) (setq compilation-buffer-name-function 'flux/nz-spec-buffer))
          ((equal "uk" market) (setq compilation-buffer-name-function 'flux/uk-spec-buffer)))
    (funcall rspec-function)))


(defun flux/au-spec-buffer (mode-name)
  "*au specs*")

(defun flux/nz-spec-buffer (mode-name)
  "*nz specs*")

(defun flux/uk-spec-buffer (mode-name)
  "*uk specs*")

(defun flux/rspec-verify (market)
  "Run spec for the current buffer in the specified market."
  (interactive
   (list (flux/read-market)))
  (flux/run-specs 'rspec-verify market))

(defun flux/rspec-verify-single (market)
  "Run spec for the current example in the specified market."
  (interactive
   (list (flux/read-market)))
  (flux/run-specs'rspec-verify-single market))

(defun flux/rspec-verify-method (market)
  "Run spec for the current example in the specified market."
  (interactive
   (list (flux/read-market)))
  (flux/run-specs 'rspec-verify-method market))

(defun flux/rspec-rerun (market)
  "Re-run the last RSpec invocation in the specified market."
  (interactive
   (list (flux/read-market)))
  (flux/run-specs 'rspec-rerun market))

(defun flux/rspec-run-last-failed (market)
  "Run just the specs that failed during the last invocation in the specified market."
  (interactive
   (list (flux/read-market)))
  (flux/run-specs 'rspec-run-last-failed market))

(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(provide 'init-rspec-mode)
