(setq mew-mailbox-type 'mbox)
(setq mew-mbox-command "incm")
(setq mew-mbox-command-arg "-u -d ~/etc/mbox")


(setq mew-auto-get nil)
(setq mew-decode-quoted t)
(setq mew-use-fancy-thread t)
(setq mew-thread-column 40)

; Security
(setq mew-use-cached-passwd t)
(setq mew-use-master-passwd t)

; POP
(setq mew-pop-delete nil)

; Accounts
(setq mew-config-alist
      '(
        (gmail
         (mew-proto         "%")
         (mail-domain       "gmail.com")
         (imap-server       "imap.gmail.com")
         (imap-ssl          t)
         (imap-ssl-port     993)
         (imap-user         "mitsuhiro.tanda@gmail.com")
         (imap-auth         t)
         (imap-delete       nil)
         (imap-trash-folder "%trash"))
        ))
