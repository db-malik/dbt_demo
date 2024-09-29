-- macros/update_data.sql

{% macro update_data(table_name, set_statements, where_condition) %}
  {% set set_clause = set_statements | join(', ') %}
  
  {% set query %}
    UPDATE {{ table_name }}
    SET {{ set_clause }}
    WHERE {{ where_condition }};
  {% endset %}
  
  {% do run_query(query) %}
{% endmacro %}
