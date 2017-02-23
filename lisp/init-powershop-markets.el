;;; Setup powershop markets

(defconst powershop-markets '("nz" "au" "uk"))

(defvar powershop-market-history nil)

(defun powershop-read-market ()
  (completing-read "Market: " powershop-markets nil t
                   nil
                   'powershop-market-history
                   (or (car powershop-market-history) "au")
                   ))

(provide 'init-powershop-markets)
