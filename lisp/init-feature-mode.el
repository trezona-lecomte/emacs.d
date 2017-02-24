(require-package 'feature-mode)
(require-package 'cucumber-goto-step)
(require 'feature-mode)

(add-hook 'feature-mode-hook
          (lambda () (local-set-key (kbd "M-.") 'jump-to-cucumber-step)))

(define-key feature-mode-map  (kbd "C-c ,v") 'powershop-feature-verify-all-scenarios-in-buffer)
(define-key feature-mode-map  (kbd "C-c ,s") 'powershop-feature-verify-scenario-at-pos)

(customize-set-value 'feature-cucumber-command "PS_MARKET={market} bundle exec spring cucumber {feature}{options}")
(customize-set-value 'feature-root-marker-file-name ".git")

(defun project-file-exists (filename)
  "Determines if the project has a file"
  (file-exists-p (concat (feature-project-root) filename)))

(defun construct-cucumber-command (command-template opts-str feature-arg market-arg)
  "Creates a complete command to launch cucumber"
  (concat (replace-regexp-in-string "{market}" market-arg
                                    (replace-regexp-in-string "{options}" opts-str
                                                              (replace-regexp-in-string "{feature}" feature-arg command-template) t t))))
(defun* feature-run-cucumber (cuke-opts market-arg &key feature-file)
  "Runs cucumber with the specified options"
  (feature-register-verify-redo (list 'feature-run-cucumber
                                      cuke-opts
                                      market-arg
                                      :feature-file feature-file))
  ;; redoer is registered
  (let ((opts-str (concat (if cuke-opts
                              (concat ":" cuke-opts)
                            "") " --format pretty"))
        (feature-arg (if feature-file
                         feature-file
                       feature-default-directory)))
    (ansi-color-for-comint-mode-on)
    (let ((default-directory (feature-project-root))
          (compilation-scroll-output t))
      (if feature-use-rvm
          (rvm-activate-corresponding-ruby))
      (compile (construct-cucumber-command feature-cucumber-command opts-str feature-arg market-arg) t))))

(defun powershop-feature-verify-all-scenarios-in-buffer (market)
  "Run all the scenarios defined in current buffer."
  (interactive
   (list (powershop-read-market)))
  (feature-run-cucumber '() market :feature-file (buffer-file-name)))

(defun powershop-feature-verify-scenario-at-pos (market &optional pos)
  "Run the scenario defined at pos.  If post is not specified the current buffer location will be used."
  (interactive
   (list (powershop-read-market)))
  (feature-run-cucumber
   (number-to-string (line-number-at-pos))
   market
   :feature-file (buffer-file-name)))

(provide 'init-feature-mode)
