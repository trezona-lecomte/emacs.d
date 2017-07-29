(require-package 'osx-browse)

(setq browse-url-dwim-always-confirm-extraction nil)

(osx-browse-mode 1)

(define-key global-map (kbd "C-c C-o") 'osx-browse-url-chrome)

(provide 'init-browse-url)
