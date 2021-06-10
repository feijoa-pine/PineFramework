<!DOCTYPE html>
<html>
  <head>
    <title>{{ title }}</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
    html,body {
        box-sizing:         border-box;
        position:           relative;
        margin:             0;
        padding:            0;
        width:              100%;
        height:             100%;
        background-color:   rgba(189, 209,174, 1);
    }
    div#wrapper {
        box-sizing:         border-box;
        position:           absolute;
        top:                0;
        left:               0;
        bottom:             0;
        right:              0;
        margin:             auto;
        width:              600px;
        height:             550px;
        text-align:         center;
        color:              white;
    }
    img {
        width:              40%;
    }
    p.small {
        font-size:          0.8em;
    }
    p.small b {
        font-family:        "Courier New", Consolas, monospace;
        font-weight:        bold;
        font-size:          1.5em;
    }
    ul {
        padding:            0;
        list-style:         none;
        text-align:         center;
    }
</style>
    </head>
    <body>
        <div id="wrapper">
            <p><img src="./__com/img/pine_error_icon_white.png" src="Error Occurred."></p>
            <h1>Sorry...</h1>
            <p>{{ title }}</p>
            <p><b>{{ message }}</b></p>
{% if verror is defined %}
                <ul>
{% for key, ve in verror %}
                    <li>{{ ve }}</li>
{% endfor %}
                </ul>
{% endif %}
            <p class="small">tracking_number: <b>{{ tracking_number }}<b></p>
        </div>
    </body>
</html>
