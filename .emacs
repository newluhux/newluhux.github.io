(setq inhibit-startup-screen t)
(setq default-input-method 'rime)
;; my blog
(require 'ox-publish)
(defvar blog-path (concat (getenv "HOME") "/project/blog"))
(defvar blog-base-directory (concat blog-path "/org/"))
(defvar blog-publishing-directory (concat blog-path "/"))

(setq org-html-metadata-timestamp-format "%Y-%m-%d")
(setq org-publish-project-alist
      `(("blog"
         :base-extension "org"
         :base-directory ,blog-base-directory
         :publishing-directory ,blog-publishing-directory
         :publishing-function org-html-publish-to-html
         :recursive t

         ;; Disable some defaults
         :html-link-home ""
         :html-link-up ""
         :html-head-include-default-style nil
         :html-head-include-scripts nil
         :html-preamble nil
         :html-postamble nil

         ;; Custom options
         :headline-levels 4
         :language "en"
         :html-html5-fancy t
         :with-date t
         :with-emphasize t              ; *:t
         :with-smart-quotes t           ; *:t
         :with-sub-superscript nil      ; ^:nil
         :with-toc nil                  ; toc:nil
         :section-numbers nil           ; num:nil
         :html-postamble "<p>Last updated: %C</p>"
         :html-wrap-src-lines t)))
