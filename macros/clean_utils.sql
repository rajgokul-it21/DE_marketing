{% macro clean_text(column_name) %}
    lower(trim(nullif({{ column_name }}, '')))
{% endmacro %}

{% macro clean_bool(column_name) %}
    case 
        when lower({{ column_name }}) in ('1', 'true', 'yes') then true
        when lower({{ column_name }}) in ('0', 'false', 'no') then false
        else null
    end
{% endmacro %}

{% macro clean_date(column_name, format="'YYYY-MM-DD'") %}
    try_to_date({{ column_name }}, {{ format }})
{% endmacro %}

{% macro normalize_text(column_name, casing='lower') %}
    {% if casing == 'lower' %}
        {{ return("lower(trim(nullif(" ~ column_name ~ ", '')))") }}
    {% elif casing == 'upper' %}
        {{ return("upper(trim(nullif(" ~ column_name ~ ", '')))") }}
    {% elif casing == 'title' %}
        {{ return("initcap(trim(nullif(" ~ column_name ~ ", '')))") }}
    {% else %}
        {{ return(column_name) }}
    {% endif %}
{% endmacro %}


{% macro null_if_invalid(column_name) %}
    nullif(
        case 
            when lower({{ column_name }}) in ('', 'n/a', 'none', 'null', '-') then null 
            else {{ column_name }}
        end,
        ''
    )
{% endmacro %}