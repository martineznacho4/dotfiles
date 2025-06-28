;; Interfaz
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(global-display-line-numbers-mode +1)
(column-number-mode)
(set-frame-font "CaskaydiaCove Nerd Font Mono" nil t)

(setq custom-theme-directory "~/.emacs.d/themes")
(setq backup-directory-alist `(("." . "~/.emacs.d/bak")))
(setq auto-save-file-name-transforms
     `((".*" "~/.emacs.d/bak/autosaves" t)))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)
(setq create-lockfiles nil)

;; =========================================================================
;; ====================== Emacs C++ Development Setup ======================
;; =========================================================================

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; use-package + straight.el
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; --------------------------------------------------------------------------
;; ---------------------------- C++ Mode Config -----------------------------
;; --------------------------------------------------------------------------
(add-hook 'c++-mode-hook #'(lambda ()
                             (setq c-basic-offset 4
                                   tab-width 4
                                   indent-tabs-mode nil)))

;; --------------------------------------------------------------------------
;; -------------------------------- LSP Mode --------------------------------
;; --------------------------------------------------------------------------
(use-package lsp-mode
  :hook ((c++-mode . lsp)
         (c-mode . lsp))
  :commands lsp
  :config
  (setq lsp-clients-clangd-executable "/usr/bin/clangd" ;;
        lsp-prefer-flymake nil)) ;; 

(use-package lsp-ui
  :commands lsp-ui-mode)

;; -------------------------------------------------------------------------
;; -------------------------------- Company --------------------------------
;; -------------------------------------------------------------------------
(use-package company
  :hook (after-init . global-company-mode))

;; -------------------------------------------------------------------------
;; ------------------------------- Flycheck --------------------------------
;; -------------------------------------------------------------------------
(use-package flycheck
  :init (global-flycheck-mode))


;; -------------------------------------------------------------------------
;; ----------------------------- Clang Format ------------------------------
;; -------------------------------------------------------------------------
(use-package clang-format
  :hook (c++-mode . (lambda ()
                      (local-set-key (kbd "C-c C-f") #'clang-format-region))))

(setq lsp-enable-on-type-formatting t)

;; -------------------------------------------------------------------------
;; ---------------------------- Visual Helpers -----------------------------
;; -------------------------------------------------------------------------
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :config (which-key-mode))

(use-package rainbow-mode
  :init (rainbow-mode +1))

(use-package autothemer
	     :ensure t)

;; -------------------------------------------------------------------------
;; --------------------------------- Theme ---------------------------------
;; -------------------------------------------------------------------------
(load-theme 'ayu-dark t)

;; -------------------------------------------------------------------------
;; -------------------------------- Others ---------------------------------
;; -------------------------------------------------------------------------
(use-package move-text
  :ensure t
  :config
  (move-text-default-bindings))

(use-package undo-fu
  :ensure t
  :config
  ;; Set bindings (personalizable, claro)
  (global-set-key (kbd "C-z") 'undo-fu-only-undo)
  (global-set-key (kbd "C-S-z") 'undo-fu-only-redo))

(use-package multiple-cursors
  :straight t
  :config
  (global-set-key (kbd"C-.") 'mc/mark-next-like-this)
  (global-set-key (kbd"C-,") 'mc/mark-previous-like-this)
  (global-set-key (kbd"C-M-,") 'mc/mark-next-like-this))


(setq compilation-window-height 10)

(defun my-compilation-hook ()
  (when (not (get-buffer-window "*compilation*"))
    (save-selected-window
      (save-excursion
        (let* ((w (split-window-vertically))
               (h (window-height w)))
          (select-window w)
          (switch-to-buffer "*compilation*")
          (shrink-window (- h compilation-window-height)))))))
(add-hook 'compilation-mode-hook 'my-compilation-hook)

(defun my-cpp-compile ()
  "Compila el archivo actual usando g++."
  (interactive)
  (let* ((file (file-name-nondirectory buffer-file-name))
         (output (file-name-sans-extension file)))
    (compile (format "g++ -std=c++17 -Wall %s -o %s" file output))))

(defun my-cpp-run ()
  "Ejecuta el binario del archivo actual."
  (interactive)
  (let ((output (file-name-sans-extension (file-name-nondirectory buffer-file-name))))
    (compile (format "./%s" output))))

(defun my-cpp-setup ()
  "Configuración personalizada para C++."
  (local-set-key (kbd "<f5>") #'my-cpp-compile)
  (local-set-key (kbd "<f6>") #'my-cpp-run))

(add-hook 'c++-mode-hook #'my-cpp-setup)

;; =========================================================================
;; ============================= ORG Configs ===============================
;; =========================================================================
(with-eval-after-load 'org-faces
  (set-face-attribute 'org-meta-line nil :height 0.8 :slant 'normal))

(use-package ligature
  :ensure t
  :config
  (ligature-set-ligatures 'prog-mode
                          '("|||>" "<|||" "<==>" "<!--" "####" "~~>" "***" "||=" "||>"
                                       ":::" "::=" "=:=" "===" "==>" "=!=" "=>>" "=<<" "=/=" "!=="
                                       "!!." ">=>" ">>=" ">>>" ">>-" ">->" "->>" "-->" "---" "-<<"
                                       "<~~" "<~>" "<*>" "<||" "<|>" "<$>" "<==" "<=>" "<=<" "<->"
                                       "<--" "<-<" "<<=" "<<-" "<<<" "<+>" "</>" "###" "#_(" "..<"
                                       "..." "+++" "/==" "///" "_|_" "www" "&&" "^=" "~~" "~@" "~="
                                       "~>" "~-" "**" "*>" "*/" "||" "|}" "|]" "|=" "|>" "|-" "{|"
                                       "[|" "]#" "::" ":=" ":>" ":<" "$>" "==" "=>" "!=" "!!" ">:"
                                       ">=" ">>" ">-" "-~" "-|" "->" "--" "-<" "<~" "<*" "<|" "<:"
                                       "<$" "<=" "<>" "<-" "<<" "<+" "</" "#{" "#[" "#:" "#=" "#!"
                                       "##" "#(" "#?" "#_" "%%" ".=" ".-" ".." ".?" "+>" "++" "?:"
                                       "?=" "?." "??" ";;" "/*" "/=" "/>" "//" "__" "~~" "(*" "*)"
                                       "\\\\" "://"))
  (global-ligature-mode t)
  )

;; =========
;; Web Deve
;; =========

(use-package js2-mode
:hook (js-mode-hook . js2-minor-mode))

(use-package prettier)
(add-hook 'after-init-hook #'global-prettier-mode)




