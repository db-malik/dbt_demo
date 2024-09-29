-- macros/format_date.sql
{% macro format_date(column_name, format_string) %}
    TO_DATE({{ column_name }}, {{ format_string }})
{% endmacro %}
