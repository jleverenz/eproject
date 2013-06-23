;; eval this buffer to run tests

(require 'eproject-selectors)

(ert-deftest eproject-selectors-test ()
  (flet ((selector (file) (eproject-select-by-path-match "/dotemacs/")))
    (should (equal "~/dotemacs/" (selector "~/dotemacs/init.el")))
    (should (equal "/tmp/dotemacs/" (selector "/tmp/dotemacs/init/more.el")))
    ))

(ert-deftest eproject-selectors-test-multiple-matchers ()
  (flet ((selector (file) (eproject-select-by-path-match "/dotemacs/" "/\.emacs\.d/")))
    (should (equal "~/dotemacs/" (selector "~/dotemacs/init.el")))
    (should (equal "~/.emacs.d/" (selector "~/.emacs.d/init.el")))
    (should (equal "~/.emacs.d/" (selector "~/.emacs.d/init/more.el")))
    (should (equal "/tmp/dotemacs/" (selector "/tmp/dotemacs/init/more.el")))
    (should (equal "/home/jeff/.emacs.d/" (selector "/home/jeff/.emacs.d/init/more.el")))
    ))

(ert-deftest eproject-selectors-test-with-subdirs ()
  (flet ((selector (file) (eproject-select-by-path-match "/projects/dotemacs/")))
    (should (equal nil (selector "~/dotemacs/init.el")))
    (should (equal "~/projects/dotemacs/" (selector "~/projects/dotemacs/init/more.el")))
    ))

(ert "eproject-selectors-test")
