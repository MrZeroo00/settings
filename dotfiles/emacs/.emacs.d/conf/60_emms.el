(my-require-and-when 'emms-setup
  (my-require-and-when 'emms-i18n)
  (emms-standard)
  (emms-default-players)
  (setq emms-repeat-playlist t)
  (setq emms-player-list '(emms-player-mplayer))
  (setq emms-source-file-default-directory "~/Music/"))
