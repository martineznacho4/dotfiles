;;; ayu-dark --- ayu-dark port for emacs
;;; Commentary:

(require 'autothemer)

;; Define custom faces
(defface ayu-namespace-face
  nil
  "Face for namespaces."
  :group 'ayu-dark)

(defface ayu-operator-face
  nil
  "Face for operators."
  :group 'ayu-dark)

(defface ayu-number-face
  nil
  "Face for literal numbers."
  :group 'ayu-dark)

(defface ayu-function-call-face
  nil
  "Face for function calls foo()."
  :group 'ayu-dark)


;; Theme definition
(autothemer-deftheme
 ayu-dark "Ayu Dark port for Emacs"
 ((((class color) (min-colors #xFFFFFF)))

  ;; Palette
  (ayu-background                "#10141c")
  (ayu-comment                   "#acb6bf")
  (ayu-string                    "#aad94c")
  (ayu-number                    "#d2a6ff")
  (ayu-variable                  "#d2a6ff")
  (ayu-keyword                   "#f29668")
  (ayu-operator                  "#f29668")
  (ayu-class-type                "#ff8f40")
  (ayu-preprocessor              "#ff8f40")
  (ayu-foreground                "#bfbdb6")
  (ayu-function-name             "#ffb454")
  (ayu-function-call             "#ffb454")
  (ayu-constant                  "#39bae6")
  (ayu-namespace                 "#39bae6")



  (ayu-punctuation               "#bfbdb6")
  (ayu-separator                 "#bfbdb6")

;; to remove
  (ayu-tag                       "#39bae6")
  (ayu-member-variable           "#f07178")
  (ayu-entity-name               "#59c2ff")
  (ayu-library-function          "#f07178")
  (ayu-accessor                  "#f29668")
  (ayu-library-constant          "#f29668")
  (ayu-imports-and-packages      "#aad94c")
  (ayu-language-variable         "#39bae6")
  (ayu-library-class-type        "#39bae6")
  (ayu-invalid                   "#d95757")
  (ayu-diff-header               "#c594c5")



  ;; rainbow delimiters
  
  (ayu-rainbow-1                 "#FFD706")
  (ayu-rainbow-2                 "#DA70D6")
  (ayu-rainbow-3                 "#179FFF")
  (ayu-rainbow-4                 "#7FDBCA")
  (ayu-rainbow-5                 "#FFB454")
  (ayu-rainbow-6                 "#87FFBA")
  (ayu-rainbow-7                 "#B48EAD")
  (ayu-rainbow-8                 "#5FD7FF")
  (ayu-rainbow-9                 "#A1EFE4")
  

  )

 ;; Faces
 ((default (:foreground ayu-foreground :background ayu-background))
  (font-lock-comment-face            (:foreground ayu-comment))
  (font-lock-string-face             (:foreground ayu-string))
  (font-lock-doc-face                (:foreground ayu-comment))
  (font-lock-keyword-face            (:foreground ayu-keyword))
  (font-lock-function-name-face      (:foreground ayu-function-name))
  (font-lock-variable-name-face      (:foreground ayu-variable))
  (font-lock-type-face               (:foreground ayu-class-type))
  (font-lock-constant-face           (:foreground ayu-constant))
  (font-lock-warning-face            (:foreground ayu-invalid))
  (font-lock-preprocessor-face       (:foreground ayu-preprocessor))
  (ayu-operator-face                 (:foreground ayu-operator))
  (ayu-namespace-face                (:foreground ayu-namespace))
  (ayu-number-face                   (:foreground ayu-number))
  (ayu-function-call-face            (:foreground ayu-function-call))

  (rainbow-delimiters-depth-1-face   (:foreground ayu-rainbow-1))
  (rainbow-delimiters-depth-2-face   (:foreground ayu-rainbow-2))
  (rainbow-delimiters-depth-3-face   (:foreground ayu-rainbow-3))
  (rainbow-delimiters-depth-4-face   (:foreground ayu-rainbow-4))
  (rainbow-delimiters-depth-5-face   (:foreground ayu-rainbow-5))
  (rainbow-delimiters-depth-6-face   (:foreground ayu-rainbow-6))
  (rainbow-delimiters-depth-7-face   (:foreground ayu-rainbow-7))
  (rainbow-delimiters-depth-8-face   (:foreground ayu-rainbow-8))
  (rainbow-delimiters-depth-9-face   (:foreground ayu-rainbow-9))
  
  ))


;; seleccion transparente
;; reb-match-0


(provide-theme 'ayu-dark)

(defun ayu-highlight-function-call ()
  "Highlight function call like foo in foo(bar)."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("\\b\\([a-zA-Z_][a-zA-Z0-9_]*\\)\\s-*(" 1 'ayu-function-call-face)))
  (font-lock-flush)
  (font-lock-ensure))


(defun ayu-highlight-number ()
  "Highlight numbers.  Targets integer, floats, trailing f floats and cientific notation (1.2e3 | 2.5E+8f | 4e-2f)."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("\\b\\([0-9]+\\(?:\\.[0-9]*\\)?\\(?:[eE][+-]?[0-9]+\\)?f?\\)\\b" 1 'ayu-number-face)))
  (font-lock-flush)
  (font-lock-ensure))


(defun ayu-highlight-namespace ()
  "Highlight namespaces like std::."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("\\([A-Za-z_][A-Za-z0-9_]*\\)::" 1 'ayu-namespace-face)))
  (font-lock-flush)
  (font-lock-ensure))

(defun ayu-highlight-operators ()
  "Highlight C-style operators like +, -, *, =, <, >, etc."
  (interactive)
  (font-lock-add-keywords
   nil
   '(("\\(->\\|==\\|!=\\|<=\\|>=\\|--\\|\\+=\\|-=\\|&&\\|||\\|[-=+*/<>!&|%^~]\\)" 1 'ayu-operator-face prepend)))
  (font-lock-flush)
  (font-lock-ensure))



(add-hook 'prog-mode-hook #'ayu-highlight-function-call)
(add-hook 'prog-mode-hook #'ayu-highlight-number)
(add-hook 'prog-mode-hook #'ayu-highlight-namespace)
(add-hook 'prog-mode-hook #'ayu-highlight-operators)
