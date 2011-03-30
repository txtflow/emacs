;;auto-complete
(add-to-list 'load-path "~/emacs/auto-complete-mode/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/emacs/auto-complete-mode/ac-dict")
(ac-config-default)
