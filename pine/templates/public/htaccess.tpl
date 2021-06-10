<IfModule mod_deflate.c>
  SetOutputFilter DEFLATE
 
  #古いブラウザ対策
  BrowserMatch ^Mozilla/4\.0[678] no-gzip
  BrowserMatch ^Mozilla/4 gzip-only-text/html
  BrowserMatch \bMSIE\s(7|8) !no-gzip !gzip-only-text/html
 
  #画像は圧縮しない GIF、JPEG、PNG、ICO
  SetEnvIfNoCase Request_URI \.(?:gif|jpe?g|png|ico)$ no-gzip dont-vary

  #圧縮するファイル
  AddOutputFilterByType DEFLATE text/plain
  AddOutputFilterByType DEFLATE text/html
  AddOutputFilterByType DEFLATE text/xml
  AddOutputFilterByType DEFLATE text/css
  AddOutputFilterByType DEFLATE text/js
  AddOutputFilterByType DEFLATE application/xml
  AddOutputFilterByType DEFLATE application/xhtml+xml
  AddOutputFilterByType DEFLATE application/rss+xml
  AddOutputFilterByType DEFLATE application/atom_xml
  AddOutputFilterByType DEFLATE application/javascript
  AddOutputFilterByType DEFLATE application/x-javascript
  AddOutputFilterByType DEFLATE application/x-httpd-php
  AddOutputFilterByType DEFLATE application/x-font-ttf
  AddOutputFilterByType DEFLATE application/x-font-woff
  AddOutputFilterByType DEFLATE application/x-font-opentype
</IfModule>

<IfModule mod_rewrite.c>
  <IfModule mod_negotiation.c>
      Options -MultiViews -Indexes
  </IfModule>

  RewriteEngine On
  RewriteBase /

  # ファイルはは除外 NC: 大文字と小文字の違いを無視
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_URI} !\.(jpg|jpeg|gif|png|pdf|js|css|ico)$ [NC]

  # /index.php にリダイレクト QSA: 書き換え後のURLにQueryStringが存在する場合、後ろに結合される
  RewriteRule ^(.*)$ /index.php [QSA,L]

</IfModule>
