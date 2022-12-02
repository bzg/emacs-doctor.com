#!/usr/bin/env sh

":"; exec emacs --quick --script "$0" -- "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-

(require 'org)
(require 'ox-html)
(require 'ox-icalendar)

(message "[exporting] meetups.org to meetups.ics")
(with-current-buffer (find-file "meetups.org")
  (condition-case err
      (org-icalendar-export-to-ics)
    (error (message (error-message-string err)))))

(message "[exporting] index.org to index.html")
(with-current-buffer (find-file "index.org")
  (condition-case err
      (org-html-export-to-html)
    (error (message (error-message-string err)))))
