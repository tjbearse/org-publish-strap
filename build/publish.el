
;;; Code:
(progn(package-initialize))


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
(org-mode)
(org-publish-project "website")
;;;
