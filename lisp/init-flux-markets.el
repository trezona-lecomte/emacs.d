;;; Setup flux markets

(defconst flux-markets '("nz" "au" "uk" "all"))

(defvar flux-market-history nil)

(defun flux/read-market ()
  (completing-read "Market: " flux-markets nil t
                   nil
                   'flux-market-history
                   (or (car flux-market-history) "all")
                   ))

(provide 'init-flux-markets)
