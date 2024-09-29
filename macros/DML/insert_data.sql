-- macros/insert_data.sql

{% macro insert_data(table_name, columns, values_list) %}
  {% set column_list = columns | join(', ') %}
  
  {% set value_statements = [] %}
  {% for values in values_list %}
    {% set value_list = values | map('string') | join(', ') %}
    {% do value_statements.append('(' ~ value_list ~ ')') %}
  {% endfor %}
  
  {% set query %}
    INSERT INTO {{ table_name }} ({{ column_list }})
    VALUES {{ value_statements | join(', ') }};
  {% endset %}
  
  {% do run_query(query) %}
{% endmacro %}




-- {{ insert_data('customers', ['name', 'email', 'country'], [
--     ['Alice', 'alice@example.com', 'USA'],
--     ['Bob', 'bob@example.com', 'UK'],
--     ['Charlie', 'charlie@example.com', 'France']
-- ]) }}

-- INSERT INTO customers (name, email, country)
-- VALUES ('Alice', 'alice@example.com', 'USA'),
--        ('Bob', 'bob@example.com', 'UK'),
--        ('Charlie', 'charlie@example.com', 'France');

