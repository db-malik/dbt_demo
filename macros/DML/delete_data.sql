-- macros/delete_data.sql

{% macro delete_data(table_name, where_condition) %}
  {% set query %}
    DELETE FROM {{ table_name }}
    WHERE {{ where_condition }};
  {% endset %}
  
  {% do run_query(query) %}
{% endmacro %}
