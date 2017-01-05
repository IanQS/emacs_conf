;;; package --- Summary
;;; Commentary:
;;; Code:

;; TODO: work on projectile, autovenv, create snippet for python
;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 1) User Config ;;
;;;;;;;;;;;;;;;;;;;;;;;
(setq user-full-name "Ian Quah")
(setq user-mail-address "ianquah@hotmail.com")
;; Please don't email me if you have any problems. This is my personal config.

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bm-buffer-persistence t)
 '(bm-repository-file "/home/ian/.emacs.d/.bm-repository")
 '(bm-repository-size 500)
 '(custom-safe-themes
   (quote
    ("e16a771a13a202ee6e276d06098bc77f008b73bbac4d526f160faa2d76c1dd0e" "70403e220d6d7100bae7775b3334eddeb340ba9c37f4b39c189c2c29d458543b" "cdbd0a803de328a4986659d799659939d13ec01da1f482d838b68038c1bb35e8" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(doc-view-continuous t)
 '(elpy-rpc-timeout 5)
 '(f3-default-directory (quote \'choose))
 '(font-use-system-font t)
 '(global-button-lock-mode t)
 '(irony-additional-clang-options
   (quote
    ("-Wall -Wextra -pedantic -Werror -Wuninitialized -std=c++11")))
 '(neo-theme (quote nerd))
 '(neo-window-fixed-size nil)
 '(neo-window-position (quote left))
 '(neo-window-width 20)
 '(package-selected-packages
   (quote
    (cmake-ide company-irony-c-headers flycheck-irony rtags company-irony helm-gtags bug-hunter yasnippet-bundle persp-projectile esup helm-projectile projectile whitespace-cleanup-mode virtualenvwrapper magit git-gutter-fringe+ git-gutter+ avy sphinx-doc zenburn-theme zenburn volume vimish-fold tramp-term swiper solarized-theme smex smart-mode-line rainbow-delimiters python-environment neotree moe-theme latex-pretty-symbols jabber hydra hlinum helm git-commit flycheck-pos-tip flycheck-cython fixmee epc elpy ein darkokai-theme bm avy-menu autopair auto-complete-octave auto-complete auctex ample-theme aggressive-indent)))
 '(projectile-keymap-prefix "")
 '(safe-local-variable-values
   (quote
    ((eval venv-workon "explainable-ai")
     (eval venv-workon "Peloton"))))
 '(shift-select-mode nil)
 '(sml/extra-filler 1)
 '(sml/name-width 35)
 '(sml/pos-minor-modes-separator "-")
 '(sml/pre-minor-modes-separator ":")
 '(sml/theme (quote dark))
 '(vimish-fold-global-mode t)
 '(windmove-wrap-around t)
 '(yas-snippet-dirs
   (quote
    ("/home/ian/.emacs.d/yasnippet-snippets" "/home/ian/.emacs.d/elpa/elpy-20161229.1103/snippets/"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-indentation-current-column-face ((t nil)))
 '(highlight-indentation-face ((t (:background "gray12"))))
 '(vimish-fold-overlay ((t (:inherit highlight :foreground "spring green")))))
(put 'dired-find-alternate-file 'disabled nil)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 2) Define package sources ------------------------------------------------ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load "package")
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
         ("marmalade" . "http://marmalade-repo.org/packages/")
         ("melpa" . "http://melpa.org/packages/")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 3) Enable & Require Packages------------------------------------------------ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'package) (package-initialize t)

(add-to-list 'load-path
     "~/.emacs.d/elpa")

(require 'aggressive-indent)
(global-aggressive-indent-mode 1)
(add-to-list 'aggressive-indent-excluded-modes 'emacs-lisp-mode)

(require 'autopair)
(autopair-global-mode)

(require 'avy)

(require 'bm)
(setq bm-restore-repository-on-load t)
(add-hook 'after-init-hook 'bm-repository-load)
;; Restoring bookmarks when on file find.
(add-hook 'find-file-hooks 'bm-buffer-restore)
;; Saving bookmark data on killing a buffer
(add-hook 'kill-buffer-hook 'bm-buffer-save)
;; Saving the repository to file when on exit.
;; kill-buffer-hook is not called when emacs is killed, so we
;; must save all bookmarks first.
(add-hook 'kill-emacs-hook '(lambda nil
          (bm-buffer-save-all)
          (bm-repository-save)))
;; Update bookmark repository when saving the file.
(add-hook 'after-save-hook 'bm-buffer-save)
;; Restore bookmarks when buffer is reverted.
(add-hook 'after-revert-hook 'bm-buffer-restore)

(require 'cc-mode)
(require 'company)
(global-company-mode)

(require 'elpy)
(elpy-enable)
(elpy-use-ipython)

(require 'git-gutter+)
(require 'git-gutter-fringe+)
(global-git-gutter+-mode 1)

(require 'flycheck)
(add-hook 'after-programming-hook 'global-flycheck-mode)

(require 'helm)  ;; M-x b stuff
(global-set-key (kbd "M-x") 'helm-M-x)

(require 'helm-projectile)
(helm-projectile-on)

(require 'helm-gtags)

(require 'hlinum)
(hlinum-activate)
(global-hl-line-mode 1)
(set-face-background 'hl-line "#3e4446")

(require 'hydra)

(require 'ido) ;; Interactive typing stuff
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

(require 'latex-pretty-symbols)

(require 'magit)

(require 'neotree)

(require 'org)

(require 'perspective)
(persp-mode)

(require 'projectile)
(projectile-mode)
(define-key projectile-mode-map projectile-keymap-prefix nil)
(define-key projectile-mode-map (kbd "C-c C-p") #'projectile-command-map)
(setq projectile-switch-project-action 'venv-projectile-auto-workon)
(setq projectile-completion-system 'helm)

(require 'persp-projectile)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 10)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(require 'saveplace)
(setq-default save-place t)

(require 'smex)

(sml/setup)  ;; Smart-mode-line

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(require 'vimish-fold)
(vimish-fold-global-mode 1)

(require 'virtualenvwrapper)
(add-hook 'venv-postmkvirtualenv-hook
      (lambda () (shell-command "pip install nose flake8 jedi rope h5py ipython numpy sklearn autopep8")))

(require 'windmove)

(require 'whitespace-cleanup-mode)
(add-hook 'after-save-hook 'whitespace-cleanup)

(require 'yasnippet)
(yas-global-mode 1)
(define-key yas-minor-mode-map [(tab)] nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)

(defvar company-mode/enable-yas t
  "Enable yasnippet for all backends.")

(defun company-mode/backend-with-yas (backend)
  (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
      backend
    (append (if (consp backend) backend (list backend))
    '(:with company-yasnippet))))

(setq company-backends (mapcar #'company-mode/backend-with-yas company-backends))

(defun indent-or-complete ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete-common)
    (indent-according-to-mode)))

(define-key company-mode-map [tab] 'indent-or-complete)
(define-key company-mode-map(kbd "TAB") 'indent-or-complete)


(setq-default mode-line-format (cons '(:exec venv-current-name) mode-line-format))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 4) Package Keybindings------------------------------------------------------ ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defhydra hydra-fold ()
  "textfold"
  ("f" vimish-fold "Set folding")
  ("t" vimish-fold-toggle "Fold/ unfold region")
  ("d" vimish-fold-delete "Delete fold")
  ("m" set-mark-command "Start the marker")
  ("n" next-line  "Next line- use after setting mark")
  ("p" previous-line "Previous line- use after setting mark")
  )

(global-set-key (kbd "C-c f") 'hydra-fold/body)

(defhydra hydra-comment ()
  "Easy region commenting"
  ("t" comment-or-uncomment-region "Toggle comment")
  ("b" comment-box "Comment box")
  ("m" set-mark-command "Start the marker")
  ("n" next-line  "Next line- use after setting mark")
  ("p" previous-line "Previous line- use after setting mark")
  )

(global-set-key (kbd "C-c c") 'hydra-comment/body)

(defhydra hydra-bm ()
  "Within file bookmarks"
  ("t" bm-toggle "Toggle bm")
  ("n" bm-next "Next bm")
  ("p" bm-previous "previous bm"))

(global-set-key (kbd "C-c b") 'hydra-bm/body)

(defhydra hydra-venv ()
  "Virtual environment interface"
  ("a" venv-workon "Activate venv")
  ("w" venv-workon "Activate venv")
  ("l" venv-lsvirtualenv "List virtual environments")
  ("M-m" venv-mkvirtualenv "Make a virtualenv")
  )(global-set-key (kbd "C-c v") 'hydra-venv/body)

(defhydra hydra-avy ()
  "Move and manipulate pairs"
  ("c" avy-goto-char "Go to a char")
  ("l" avy-goto-line "Go to a line")
  ("w" avy-goto-word-1 "Go to a word")
  ) (global-set-key (kbd "C-c a") 'hydra-avy/body)

(defhydra hydra-persp ()
  "Perspectives"
  ("k" persp-remove-buffer "Kill just the buffer")
  ("K" persp-kill "Kill the perspective")
  ("c" persp-switch "Create/ switch to frame")
  ("p" projectile-mode "Flip mode")
  ("s" projectile-persp-switch-project "Projectile-persp switch project")
  ) (global-set-key (kbd "C-c p") 'hydra-persp/body)

(defhydra hydra-magit ()
  "Run magit"
  ("s" magit-status "Open Magit status")
  ("c" magit-dispatch-popup "Close magit statusbar")
  ) (global-set-key (kbd "C-c m") 'hydra-magit/body)

(defhydra hydra-wm ()
  "Wind-move"
  ("l" windmove-left "Move to left frame")
  ("h" windmove-right "Move to right frame")
  ) (global-set-key (kbd "C-c w") 'hydra-wm/body)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 5) Changing Emacs Default Keybindings--------------------------------------- ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; C-definitions
(setq
 helm-gtags-ignore-case t
 helm-gtags-auto-update t
 helm-gtags-use-input-at-cursor t
 helm-gtags-pulse-at-cursor t
 helm-gtags-prefix-key "\C-cg"
 helm-gtags-suggested-key-mapping t
 )

(require 'helm-gtags)
;; Enable helm-gtags-mode
(add-hook 'dired-mode-hook 'helm-gtags-mode)
(add-hook 'eshell-mode-hook 'helm-gtags-mode)
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(define-key helm-gtags-mode-map (kbd "C-c g a") 'helm-gtags-tags-in-this-function)
(define-key helm-gtags-mode-map (kbd "C-j") 'helm-gtags-select)
(define-key helm-gtags-mode-map (kbd "M-.") 'helm-gtags-dwim)
(define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack)
(define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
(define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)


(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-z") nil)
(global-set-key (kbd "<f1>") 'eshell)
(global-set-key (kbd "<f2>") 'tramp)
(global-set-key (kbd "<f3>") 'neotree-toggle)

(setq company-backends (delete 'company-semantic company-backends))
(add-to-list 'company-backends 'company-c-headers)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))

(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)
(setq company-backends (delete 'company-semantic company-backends))
(require 'company-irony-c-headers)
(eval-after-load 'company
  '(add-to-list
    'company-backends '(company-irony-c-headers company-irony)))

(defun indent-or-complete-C ()
  (interactive)
  (if (looking-at "\\_>")
      (company-complete)
    (indent-according-to-mode)))

(setq company-idle-delay 0)
(define-key c-mode-map [(tab)] 'indent-or-complete-C)
(define-key c++-mode-map [(tab)] 'indent-or-complete-C)

(add-hook 'c++-mode-hook 'flycheck-mode)
(add-hook 'c-mode-hook 'flycheck-mode)

(require 'flycheck-rtags)

(defun my-flycheck-rtags-setup ()
  (flycheck-select-checker 'rtags)
  (setq-local flycheck-highlighting-mode nil) ;; RTags creates more accurate overlays.
  (setq-local flycheck-check-syntax-automatically nil))
;; c-mode-common-hook is also called by c++-mode
(add-hook 'c-mode-common-hook #'my-flycheck-rtags-setup)

(eval-after-load 'flycheck
  '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;; 6) Changing Emacs Defaults--------------------------------------------------- ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(load-theme 'monokai t)

(setq auto-save-default nil)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(global-linum-mode 1)
(menu-bar-mode -1)
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(global-visual-line-mode t)

(set-face-attribute 'default nil :height 80)

(setq inhibit-startup-message t)
(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

;; shows the empty lines at the bottom

(defalias 'yes-or-no-p 'y-or-n-p) ;; hate typing yes and no

;; Prevent emacs from beeping at you
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)
(show-paren-mode t)
(setq column-number-mode t)

;; indentation using spaces, 4
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

(provide 'init)
;;; init ends here
