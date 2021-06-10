<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible"                  content="IE=edge" />
<meta name="apple-mobile-web-app-capable"           content="yes">
<meta name="apple-mobile-web-app-status-bar-style"  content="black-translucent">
<meta name="apple-mobile-web-app-title"             content="{{ APPLE_TITLE }}">
<meta name="viewport"                               content="width=device-width,initial-scale=1.0,minimum-scale=1.0">
{% if description != "" %}
<meta name="description"                            content="{{ description }}" />
{% endif %}
{% if keywords != "" %}
<meta name="keywords"                               content="{{ keywords }}" />
{% endif %}
<meta name="robots"                                 content="noindex,nofollow" />
<title>{{ TITLE }}</title>
<link rel="shortcut icon"                           href="/__com/favicons/favicon.ico">
<link rel="apple-touch-icon"                        href="/__com/favicons/apple-touch-icon-precomposed.png"     type="image/png">
<link rel="icon"        sizes="96x96"               href="/__com/favicons/icon-96x96.png"                       type="image/png">
<link rel="icon"        sizes="192x192"             href="/__com/favicons/android-chrome-192x192.png"           type="image/png">
<meta name="application-name"                       content="{{ SITE_TITLE }}">
<meta name="msapplication-square70x70logo"          content="/__com/favicons/site-tile-70x70.png">
<meta name="msapplication-square150x150logo"        content="/__com/favicons/site-tile-150x150.png">
<meta name="msapplication-wide310x150logo"          content="/__com/favicons/site-tile-310x150.png">	
<meta name="msapplication-square310x310logo"        content="/__com/favicons/site-tile-310x310.png">
<meta name="msapplication-TileColor"                content="#373E50">
<meta name="theme-color"                            content="#373E50">

<link rel="stylesheet"                              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.min.css" integrity="sha256-UzFD2WYH2U1dQpKDjjZK72VtPeWP50NoJjd26rnAdUI=" crossorigin="anonymous" />
{% for v in css %}
<link rel="stylesheet"                              {{ site_css_hashed(v)|raw }} type="text/css">
{% endfor %}

{% for v in script %}
<script                                             src="{{ site_hash(v) }}"></script>
{% endfor %}

{% for v in head %}
{% include v %}
{% endfor %}
