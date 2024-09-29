-- macros/ensure_not_null.sql
{% macro ensure_not_null(column_name) %}
    {{ column_name }} IS NOT NULL
{% endmacro %}