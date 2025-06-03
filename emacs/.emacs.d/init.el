;; Desactivar pantalla de inicio
(setq inhibit-startup-message t)
(setq initial-scratch-message nil)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(set-frame-font "Cascadia Code PL" nil t)

;; Interfaz
(global-display-line-numbers-mode +1)


(setq backup-directory-alist `(("." . "~/.emacs.d/bak")))
(setq auto-save-file-name-transforms
     `((".*" "~/.emacs.d/bak/autosaves" t)))
(setq delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)

(setq create-lockfiles nil)

(setq custom-theme-directory "~/.emacs.d/themes")
(load-theme 'ayu-grey t)


;; ============================
;; Emacs C++ Development Setup
;; ============================



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

;; ---------- C++ Mode Config ----------
(add-hook 'c++-mode-hook #'(lambda ()
                             (setq c-basic-offset 4
                                   tab-width 4
                                   indent-tabs-mode nil)))

;; ---------- LSP Mode ----------
(use-package lsp-mode
  :hook ((c++-mode . lsp)
         (c-mode . lsp))
  :commands lsp
  :config
  (setq lsp-clients-clangd-executable "/snap/bin/clangd" ;; <-- cámbialo si es necesario
        lsp-prefer-flymake nil)) ;; usamos flycheck mejor

(use-package lsp-ui
  :commands lsp-ui-mode)

;; ---------- Company (Autocomplete) ----------
(use-package company
  :hook (after-init . global-company-mode))

;; ---------- Flycheck (Errores) ----------
(use-package flycheck
  :init (global-flycheck-mode))

;; ---------- Clang Format ----------
(use-package clang-format
  :hook (c++-mode . (lambda ()
                      (local-set-key (kbd "C-c C-f") #'clang-format-region))))

(setq lsp-enable-on-type-formatting t)  ;; Habilita el formateo mientras escribes



;; ---------- Visual Helpers ----------
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :config (which-key-mode))


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
  ;; Atajos
  (local-set-key (kbd "<f5>") #'my-cpp-compile)
  (local-set-key (kbd "<f6>") #'my-cpp-run))

(add-hook 'c++-mode-hook #'my-cpp-setup)

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


;;========================
;; ORG Configs
;;
(set-face-attribute 'org-meta-line nil :height 0.8 :slant 'normal)




;; Asignar un atajo para compilar
;;(define-key c++-mode-map (kbd "<f5>") 'my-cpp-compile)

;; Si existe makefile
;; (setq compile-command "make -k")
;; M-x compile



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
