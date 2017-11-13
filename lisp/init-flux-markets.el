;;; Setup flux markets

(defconst flux-markets '("nz" "au" "uk" "all"))

(defvar flux-market-history nil)

(defun flux/read-market ()
  (completing-read "Market: " flux-markets nil t
                   nil
                   'flux-market-history
                   (or (car flux-market-history) "all")
                   ))

(defun flux/start-spring-for-market (market)
  (progn
    (setq inhibit-message t)
    (if (string-match-p "Spring is not running"
                        (shell-command-to-string (format "cd %s && PS_MARKET=%s bundle exec spring status" (shell-quote-argument (rspec-project-root)) (shell-quote-argument market))))
        (progn
          (message (format "Powershop RSpec: Starting spring in %s" market))
          (async-shell-command (format "cd %s && PS_MARKET=%s bundle exec spring server" (shell-quote-argument (rspec-project-root)) (shell-quote-argument market)) (format "*%s spring server*" market)))
      (message (format "Powershop RSpec: Spring already running in %s, using existing server." market)))
    (setq inhibit-message nil)))


(provide 'init-flux-markets)
