<div id="error">
{% if error.verror is defined %}
  <ul>
{% for key, ve in error.verror %}
{% for message in ve %}
    <li data-key="{{key}}">{{message}}</li>
{% endfor %}
{% endfor %}
  </ul>
{% endif %}
{% if error.message is not empty %}
  <p>{{error.message}}</p>
{% endif %}
{% if error.last_query is not empty %}
  <pre>{{error.last_query}}</pre>
{% endif %}
{% if error.stack_trace is not empty %}
  <p>{{error.stack_trace|nl2br}}</p>
{% endif %}
</div>

 