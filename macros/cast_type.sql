-- macros/cast_type.sql
{% macro cast_type(column_name, data_type) %}
    CAST({{ column_name }} AS {{ data_type }})
{% endmacro %}