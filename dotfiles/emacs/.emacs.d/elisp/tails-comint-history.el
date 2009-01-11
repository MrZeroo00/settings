;;����ϡ�shell-mode �ʤ� M-p��M-n �ǥ��ޥ�ɥ饤��ҥ��ȥ���̤ä��ꤷ�������������ʤ�ΤǤ��� 
;;�㤨�С�M-x shell �Ȥ��� 
;;      % ls -l
;;      total 12
;;      % date
;;      1997ǯ09��29��(��) 16��17ʬ02�� JST
;;      % l
;;�����Ϥ����Ȥ��ޤ������λ����� M-p �����Ϥ���ȡ�ɸ��Ǥ� 
;;      % date
;;�Ȥʤ�ޤ�����tails-comint-histrory.el ��ȤäƤ���� 
;;      % ls -l
;;�ȤʤäƤ���ޤ����Ĥޤ�ǽ�ΰ�ʸ���� l �Ǥ���褦�ʥҥ��ȥ�򸡺�����ɽ�����Ƥ����櫓�Ǥ��� 
;;�Ĥ����ˤϡ�~/.emacs �� (load-library "tails-comint-histrory") �Ƚ񤤤Ƥ����ޤ��� 

(require 'shell)
(define-key comint-mode-map [?\M-p] 'tails-comint-previous-input)
(define-key comint-mode-map [?\M-n] 'tails-comint-next-input)
(define-key shell-mode-map [?\M-p] 'tails-comint-previous-input)
(define-key shell-mode-map [?\M-n] 'tails-comint-next-input)

(make-variable-buffer-local 'tails-comint-history-prefix)
(make-variable-buffer-local 'tails-comint-history-index)

(defun tails-comint-previous-input ()
  (interactive)
  (tails-comint-history 1))

(defun tails-comint-next-input ()
  (interactive)
  (tails-comint-history -1))

(defun tails-comint-history (direction)
  (let ((len (ring-length comint-input-ring))
	(ppos (process-mark (get-buffer-process (current-buffer)))))
    (if (not (eq last-command 'tails-comint-history))
	(progn
	  (setq tails-comint-history-prefix (buffer-substring ppos (point)))
	  (setq tails-comint-history-index nil)))
    (setq tails-comint-history-index (if (numberp tails-comint-history-index)
					 (+ tails-comint-history-index direction)
				       (if (= direction 1) 0 (1- len))))
    (message tails-comint-history-prefix)
    (let ((prefix-len (length tails-comint-history-prefix)))
      (while (not (or (and (not (and (>= tails-comint-history-index 0)
				     (< tails-comint-history-index len)))
			   (progn
			     (setq tails-comint-history-index nil)
			     (ding)
			     ;;(kill-region ppos (point-max))
			     (delete-region ppos (point-max))
			     (goto-char (point-max))
			     (insert tails-comint-history-prefix)
			     t))
		      (let ((element (ring-ref comint-input-ring tails-comint-history-index)))
			(and (<= prefix-len (length element))
			     (string= tails-comint-history-prefix (substring element 0 prefix-len))
			     (progn
			       ;;(kill-region ppos (point-max))
			       (delete-region ppos (point-max))
			       (goto-char (point-max))
			       (insert element)
			       t)))))
	(setq tails-comint-history-index (+ tails-comint-history-index direction)))
  (setq this-command 'tails-comint-history))))
