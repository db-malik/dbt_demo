{% macro convert_type(column_name, from_type, to_type) %}
  {% if from_type == 'string' %}
    {% if to_type == 'integer' %}
      SAFE_CAST({{ column_name }} as INT64) as {{ column_name }}
    {% elif to_type == 'float' %}
      SAFE_CAST({{ column_name }} as FLOAT64) as {{ column_name }}
    {% elif to_type == 'boolean' %}
      SAFE_CAST({{ column_name }} as BOOL) as {{ column_name }}
    {% elif to_type == 'date' %}
      SAFE_CAST({{ column_name }} as DATE) as {{ column_name }}
    {% elif to_type == 'datetime' %}
      SAFE_CAST({{ column_name }} as DATETIME) as {{ column_name }}
    {% elif to_type == 'timestamp' %}
      SAFE_CAST({{ column_name }} as TIMESTAMP) as {{ column_name }}
    {% elif to_type == 'time' %}
      SAFE_CAST({{ column_name }} as TIME) as {{ column_name }}
    {% elif to_type == 'numeric' %}
      SAFE_CAST({{ column_name }} as NUMERIC) as {{ column_name }}
    {% elif to_type == 'bignumeric' %}
      SAFE_CAST({{ column_name }} as BIGNUMERIC) as {{ column_name }}
    {% elif to_type == 'bytes' %}
      SAFE_CAST({{ column_name }} as BYTES) as {{ column_name }}
    {% else %}
      {{ column_name }}
    {% endif %}
  {% else %}
    {{ column_name }}
  {% endif %}
{% endmacro %}
