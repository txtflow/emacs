(load "~/emacs/haskell-mode/haskell-site-file.el")

(custom-set-variables
 '(haskell-program-name "ghci -fglasgow-exts")
 '(inferior-haskell-wait-and-jump t)
;; '(hs-lint-replace-with-suggestions t)
)

;; (add-hook 'haskell-mode-hook 'turn-on-haskell-ghci)
;; (setq haskell-ghci-program-args
;;       (append
;;        '("-fglasgow-exts")
;;        '("-fallow-overlapping-instances")
;;        '("-Wall")
;;        '("-package data")
;;        '("-i.:..")
;;        ))

(defun artem/haskell-mode-hook ()
  (turn-on-haskell-doc-mode)
  (turn-on-haskell-indent)
  (turn-on-haskell-ghci)
  (turn-on-eldoc-mode)
  (turn-on-haskell-indentation)
  (local-set-key [return] 'newline-and-indent)
  (local-set-key "\C-cl" 'hs-lint)
  (local-set-key "\C-ch" 'haskell-hoogle)
  (local-set-key "\C-cc" 'uncomment-region)
;;  (local-set-key "\C-c\C-h" 'haskell-hayoo)
  (setq tab-width 4)
;;  (turn-on-haskell-simple-indent)
  (setq haskell-font-lock-symbols t)  
)
;;(add-hook 'haskell-mode-hook 'artem/common-hook)
;;(add-hook 'haskell-mode-hook 'artem/common-prog-hook)
(add-hook 'haskell-mode-hook 'artem/haskell-mode-hook)

;;haskell-auto-complete.el
(load "~/emacs/haskell-mode/haskell-auto-complete")

(add-to-list 'exec-path "~/cabal/bin")
(load "~/emacs/rc/haskell-flymake-rc.el")
;;(require 'hs-lint)

;;load modes
(add-hook 'haskell-mode-hook 'auto-complete-mode)
(add-hook 'haskell-mode-hook 'linum-mode)
(add-hook 'haskell-mode-hook 'flymake-mode)

;;(add-hook 'haskell-mode-hook 'artem/common-hook)
;;(add-hook 'haskell-mode-hook 'artem/common-prog-hook)




