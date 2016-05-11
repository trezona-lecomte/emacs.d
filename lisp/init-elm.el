(when (maybe-require-package 'elm-mode)
  (after-load 'elm-mode
    (diminish 'elm-indent-mode)
    (when (executable-find "elm-oracle")
      (add-hook 'elm-mode-hook 'elm-oracle-setup-completion))
    (setq-default elm-format-on-save t)
    (setq-default elm-compile-arguments '("--yes" "--warn" "--output=index.html")))
  (when (maybe-require-package 'flycheck-elm)
    (after-load 'elm-mode
      (flycheck-elm-setup))))

(provide 'init-elm)
