(require 'ess-site)
(setq ess-ask-for-ess-directory nil)
(setq ess-pre-run-hook
	'((lambda ()
	(setq default-process-coding-system '(sjis . sjis))
	)))

(set-language-environment "Japanese")
(setq default-input-method "MW32-IME")
(mw32-ime-initialize)

(defun ess:format-window-1 ()
	(split-window-horizontally)
	(other-window 1)
	(split-window)
	(other-window 1))
(add-hook 'ess-pre-run-hook 'ess:format-window-1)

(setq default-frame-alist
      (append (list '(foreground-color . "azure3")
	'(background-color . "black")
	'(border-color . "black")
	'(mouse-color . "white")
	'(cursor-color . "white")
	)
	default-frame-alist))
