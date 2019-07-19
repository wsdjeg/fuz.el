;;; fuz.el --- Fast and precise fuzzy scoring/matching utils  -*- lexical-binding: t -*-

;; Copyright (C) 2019 Zhu Zihao

;; Author: Zhu Zihao <all_but_last@163.com>
;; URL:
;; Version: 0.0.1
;; Package-Requires: ((emacs "25.1"))
;; Keywords: lisp

;; This file is NOT part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'fuz-core)

(eval-when-compile
  (require 'subr-x)

  ;; Backward compatibility for Emacs 25
  (unless (>= emacs-major-version 26)
    (unless (fboundp 'if-let*) (defalias 'if-let* #'if-let))
    (unless (fboundp 'when-let*) (defalias 'when-let* #'when-let))))

(defsubst fuz-fuzzy-match-skim (pattern str)
  "

Sign: (-> Str Str (Option (Listof Long)))"
  (if-let* ((total-score (fuz-core-calc-score-skim pattern str)))
      (cons total-score (fuz-core-find-indices-skim pattern str))
    nil))

(defsubst fuz-fuzzy-match-clangd (pattern str)
  "

Sign: (-> Str Str (Option (Listof Long)))"
  (if-let* ((total-score (fuz-core-calc-score-clangd pattern str)))
      (cons total-score (fuz-core-find-indices-clangd pattern str))
    nil))

;;; Export function aliases

(defalias 'fuz-calc-score-clangd 'fuz-core-calc-score-clangd)
(defalias 'fuz-calc-score-skim 'fuz-core-calc-score-skim)
(defalias 'fuz-find-indices-clangd 'fuz-core-find-indices-clangd)
(defalias 'fuz-find-indices-skim 'fuz-core-find-indices-skim)

(provide 'fuz)

;; Local Variables:
;; coding: utf-8
;; End:

;;; fuz.el ends here