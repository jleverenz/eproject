;;; eproject-find-cmd.el --- use find (via find-cmd) to define project files
;;
;; Copyright (C) 2013 Jeff Leverenz <jeff.leverenz@gmail.com>
;;
;; Author: Jeff Leverenz <jeff.leverenz@gmail.com>
;; Keywords: programming, projects
;;
;; This file is not a part of GNU Emacs.
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 2 of
;; the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public
;; License along with this program; if not, write to the Free
;; Software Foundation, Inc., 59 Temple Place - Suite 330, Boston,
;; MA 02111-1307, USA.

;;; Commentary:

;; Provides an alternative SELECTOR (to look-for) for determining a file's
;; eproject type.  Project is selected if buffer's file path matches any of the
;; regexp provided.  e.g.
;;
;;     (define-project-type eproject (generic)
;;       (eproject-select-by-path-match "/eproject/"))
;;

;;; Code:

(defmacro eproject-select-by-path-match (&rest valid-matches)
  "Select an eproject type if buffer's file path matches any of
the regexp provided.  VALID-MATCHES is a list of regexp strings
to try."
  `(progn
     (let ((result (find-if (lambda (m) (setq index (string-match m file)))
                            ',valid-matches)))
       (if result (substring file 0 (+ index (length (match-string 0 file))))
         nil))))

(provide 'eproject-selectors)
;;; eproject-selectors.el ends here
