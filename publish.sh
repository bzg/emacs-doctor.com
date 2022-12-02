#!/usr/bin/env sh

":"; exec emacs --quick --script "$0" -- "$@" # -*- mode: emacs-lisp; lexical-binding: t; -*-

(find-file "meetups.org")
(org-icalendar-export-to-ics)

(dolist (org-file (directory-files-recursively default-directory "\\.org$"))
  (let ((html-file (concat (file-name-directory org-file)
			   (file-name-base org-file) ".html")))
    (if (and (file-exists-p html-file)
             (file-newer-than-file-p html-file org-file))
	(message " [skipping] unchanged %s" org-file)
      (message "[exporting] %s" (file-relative-name org-file default-directory))
      (with-current-buffer (find-file org-file)
	(condition-case err
            (org-html-export-to-html)
          (error (message (error-message-string err))))))))
