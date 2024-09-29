-- macros/delete_data_bulk.sql

{% macro delete_data_bulk(table_name, id_column, ids_array_query) %}
    -- Construct and execute the DELETE query
    {% set query %}
        DELETE FROM {{ table_name }}
        WHERE {{ id_column }} IN UNNEST((
            {{ ids_array_query }}
        ));
    {% endset %}
    
    -- Executes the dynamically generated query
    {% do run_query(query) %}
{% endmacro %}
