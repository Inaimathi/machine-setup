(require 'package)

(add-to-load-path (list-subdirectories "~/.emacs.d/elpa"))

(setq package-archives
      '(("melpa" . "http://melpa.milkbox.net/packages/")
 	("marmalade" . "http://marmalade-repo.org/packages/")
 	("elpa" . "http://elpa.gnu.org/packages/")))

(defvar +package-list+
  '(elfeed
    aes
    magit highlight-parentheses autopair smart-tab
    auto-complete yasnippet paredit
    markdown-mode haskell-mode))

(unless (every #'package-installed-p +package-list+)
  (package-initialize)

  (unless package-archive-contents
    (package-refresh-contents))

  (dolist (p +package-list+)
    (unless (package-installed-p p)
      (package-install p))))

(provide 'packs)
