(require 'flymake)

(defvar flymake-ghc-options (list "-Wall" "-fglasgow-exts"))
(defvar flymake-ghc-packages (mapcar (lambda (p)
                                       (concat "-package " p))
                                     '("QuickCheck")))

(defun flymake-Haskell-init ()
  (flymake-simple-make-init-impl
   'flymake-create-temp-with-folder-structure nil nil
   (file-name-nondirectory buffer-file-name)
   'flymake-get-Haskell-cmdline))

(defun flymake-get-Haskell-cmdline (source base-dir)
  (list "ghc"
	(append
	 (list "--make" "-fbyte-code" (concat "-i"base-dir) source)
	 flymake-ghc-options
	 flymake-ghc-packages)))

(defvar multiline-flymake-mode nil)
(defvar flymake-split-output-multiline nil)

;; this needs to be advised as flymake-split-string is used in other places and I don't know of a better way to get at the caller's details
(defadvice flymake-split-output
  (around flymake-split-output-multiline activate protect)
  (if multiline-flymake-mode
      (let ((flymake-split-output-multiline t))
	ad-do-it)
    ad-do-it))

(defadvice flymake-split-string
  (before flymake-split-string-multiline activate)
  (when flymake-split-output-multiline
    (ad-set-arg 1 "^\\s *$")))

;; (defun flymake-Haskell-cleanup ()
;;   (delete-file flymake-temp-source-file-name))

;; (push '(".+\\.hs$" flymake-Haskell-init flymake-Haskell-cleanup)
;;      flymake-allowed-file-name-masks)
;; ;; fix to proper handling of warnings
;; (push '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.\+\\)" 1 2 3 4)
;;      flymake-err-line-patterns)

;; Why did nobody tell me about eval-after-load - very useful
(eval-after-load "flymake"
  '(progn
     (add-to-list 'flymake-allowed-file-name-masks
                  '("\\.l?hs$" flymake-Haskell-init flymake-simple-java-cleanup))
     (add-to-list 'flymake-err-line-patterns
                  '("^\\(.+\\.l?hs\\):\\([0-9]+\\):\\([0-9]+\\):\\(\\(?:.\\|\\W\\)+\\)"
                    1 2 3 4))))
;;     (add-to-list 'flymake-err-line-patterns  '("^\\(\.+\.hs\\|\.lhs\\):\\([0-9]+\\):\\([0-9]+\\):\\(.\+\\)" 1 2 3 4))))

(add-hook
 'haskell-mode-hook
 '(lambda ()
    (set (make-local-variable 'multiline-flymake-mode) t)))

;; (custom-set-faces
;;  '(flymake-errline ((((class color)) (:background "LightYellow" :underline "OrangeRed"))))
;;  '(flymake-warnline ((((class color)) (:background "LightBlue2" :underline "Yellow")))))