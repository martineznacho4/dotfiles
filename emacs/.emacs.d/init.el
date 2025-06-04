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
  (setq lsp-clients-clangd-executable "/usr/bin/clangd" ;;
        lsp-prefer-flymake nil)) ;; 

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

(use-package rainbow-mode)


(use-package autothemer
	     :ensure t)

(load-theme 'ayu-dark t)



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

(with-eval-after-load 'org-faces
  (set-face-attribute 'org-meta-line nil :height 0.8 :slant 'normal))




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
 '(custom-safe-themes
   '("fbccbc8501522b173fb60af10591ecb6f6621a9f58698a2d76de1a7da6a7ae99" "017de05ea06e23146ed363102418a6a16a86e27ab2f3031728e4a723da0dcb93" "81da213b285ab48716751c0dc7201807d6dbc2f9404f721cacdd9c04413aef81" "7223708c5a2aa098b16f9492d79a5cd9e14ac029699d66fc28abb89004b5dc6f" "8fc6203cdb133f0f80afa003c87412dd1c7e3b44154a113166b29633d47174c5" "30b0983159fb5aed7adab0970847546e2b83ec3b180f6f732a5cafd2962c9937" "e0bfcd8bd8453a911938822be048eb6e3c57ee7fa2bc89f05e81434746a557bf" "44c831dbf371e71ab4b59612e8f7a14d9aef318ebe77892c76968eb12b50aff9" "8d5df94416dca7ced289206bd790c089637403aaeccf95937071d47e4fe03e87" "0e0c6e4c08e6e6a83d50e7596846e55c45cddddb249f44679de6e35893d2b303" "a682b510db6bcd120a560633541121cfa66a2f934dff6c436ae2a34f4988a50e" "0a07f0789a057b5c611ed1c0edebc558aee83092add4e7f521f03e32e74aae23" "461a510a10c05920bda09213b5aa17dafb7d4824c06650fa0e72fc32d6c91060" "fc63c2a014215005eb2dd5d27f69fe2371ae89686bbe3a372c7c3535f687cca0" "650f63b73bc3033606b2bcecc5b8a0e71fa9b02263ea03251889cafec4b317be" "d77a4ca9dc8f92c14e65868943310a6b44a2b868815d36ac130d09901ec7095f" "aa0d3916155c3dd3c8aed605aaf0d6169de9c46f12721a9e6a95309ae9da790f" "2e415fd7674439593c14c9940ae68e8873260c5930a700bae046840ff8cf378e" "5952e9292c784d4e85b878346dae7b0270e8281c1eaf8c0ad18137afa4b698a1" "6cc5e7b263567e9f37eaf2d1afbfc3c6405ed8b4284fcb2e80a5f4710f7f1c44" "65b7f9501dda5bca73c22da929e8abdba398197080c59032927ea5daab4c1067" "0abb6df2e8831483e4485afb985b24ef1285b70ee79a5111bc06cfba33907290" "17f8208db9d9c6bea573d39a1204fa98aa23c7bae262ae53db5e231486c5fe87" "fb132a4eafc92a55d8c55be0dbeaa445f4b8ebcb376de26b86fef80cc2b28261" "631de5976b5fe9a761313d56a3c9d53da43e61642f177e4610c6b23942c5d272" "69279914005e92800500cd4ef37f5ba166c69588d591936290b3e267e1964d3a" "a6ecff58472f1ddccc0c9b1efff1cecc1db9476e504bb351c0630941eb28f7ca" "fdf75fb73cde4739fd234ddb548eed7074e09e45b9e1e8c71986c38b8abfa016" "6761f4369c7ff54cc452f858bc16bf0c15781d148e34954d87898f9ba46aca44" "64e8516d7976ef7e5e7060ac065da9a1d7fedac03283da64c9411ca4081df8b8" "dd7bd602973ffe01999294db1800ac987005ebe6b56ecb8431d12b1c8046a382" "16d66a0856e67435481dc50c41176a8a5b0422174438b1d149f8be00319148bf" "e7326fdbb15cff7900a677757178d2ff6461a5feb101eed7b086e6d08f5ef193" "ad9fa1a7c014f6ff6383943a5331a1bd6c11a58be4ccc81e52f0a00c9cd9a942" "9ccb593a02f13809888a6417d278b509628214d29262d19a4eeff93a59676d72" "a7762ff6452d9ea7c298862c27f88bd02a4422bdab66261fa1842196b0d43f20" "573b90b797c46239c32a319d33325839588117c0d10d36de3fa5238d1bd5c848" "673e602e4f50e82e385119e365445b0facd2de1eca3c6cf5cb19e438d5556a66" "4ec569dea1081baa9aa62961da7c25efd487e946fc2f096ac99353fd2e59f433" "2a792991326c9278e3f8e8e6482beb10f6f12c76436893e2364535272f4f67cb" "88a870af78859391f0ae9e12c47572386fe311194119621c39501e317596be68" "7b29dffe751a68fd3384ad90c4bceee1fd16c3e3f1eb508f4022712f13e135ab" default))
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
