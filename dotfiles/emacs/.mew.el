(setq mew-mailbox-type 'mbox)
(setq mew-mbox-command "incm")
(setq mew-mbox-command-arg "-u -d ~/etc/mbox")


(setq mew-auto-get nil)
(setq mew-decode-quoted t)
(setq mew-use-fancy-thread t)
(setq mew-thread-column 40)
(setq mew-use-biff t)
(setq mew-biff-interval 30)
(setq mew-prog-ssl (my-which "stunnel"))
;(setq mew-ssl-verify-level 2)
(setq mew-ssl-verify-level 0)

; Security
(setq mew-use-cached-passwd t)
(setq mew-passwd-timer-unit 60)
(setq mew-use-master-passwd t)

; POP
(setq mew-pop-size 0)
(setq mew-pop-delete nil)

; Accounts
(setq mew-name "Mitsuhiro Tanda")
(setq mew-config-alist
      '(
        (gmail
         (mew-proto         "%")
         (user              "mitsuhiro.tanda")
         (mail-domain       "gmail.com")
;         (mailbox-type      'mbox)
;         (imap-server       "imap.gmail.com")
;         (imap-ssl          t)
;         (imap-ssl-port     993)
;         (imap-user         "mitsuhiro.tanda@gmail.com")
;         (imap-auth         t)
;         (imap-delete       nil)
;         (imap-trash-folder "%trash")
         (mailbox-type      'pop)
         (pop-server        "pop.gmail.com")
         (pop-ssl           t)
         (pop-ssl-port      995)
         (pop-user          "mitsuhiro.tanda")
         (pop-auth          pass)
         (smtp-server       "smtp.gmail.com")
         (smtp-ssl          t)
         (smtp-ssl-port     465)
         (smtp-user         "mitsuhiro.tanda")
         )))
(setq mew-case "gmail")
