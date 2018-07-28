
;;; Code:
(progn(package-initialize))
(org-mode)

(defvar website-html-head
  "<link href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.1/css/bootstrap.min.css' rel='stylesheet'/>
<script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.2/jquery.min.js'></script>
<script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.1/js/bootstrap.min.js'></script>"
  )

(defvar website-html-preamble
  "<div class='nav'>
<ul>
<li><a href='/index.html'>Home</a></li>
</ul>
</div>")

;;; http://endlessparentheses.com/better-time-stamps-in-org-export.html
(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats
      '("<%d %b %Y>" . "<%d/%m/%y %a %H:%M>"))

(defun endless/filter-timestamp (trans back _comm)
  "Remove <> around time-stamps."
  (pcase back
    ((or `jekyll `html `twbs)
     (replace-regexp-in-string "&[lg]t;" "" trans))
    (`latex
     (replace-regexp-in-string "[<>]" "" trans))))
(setq org-export-filter-timestamp-functions (list))
(add-to-list 'org-export-filter-timestamp-functions
             #'endless/filter-timestamp)

(setq org-publish-project-alist
      `(("org"
         :base-directory "./src"
         :base-extension "org"
         :publishing-directory "./export"
         :recursive t
         :publishing-function org-twbs-publish-to-html
         :html-head ,website-html-head
         :html-preamble ,website-html-preamble
         )
        ("static"
         :base-directory "./src"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf"
         :publishing-directory "./export"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("website" :components ("org" "static"))
        )
      )
(org-publish-project "website")

;;;
