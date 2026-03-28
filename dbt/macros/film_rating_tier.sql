{% macro film_rating_tier(rating_column) %}
case
    when {{ rating_column }} >= 4.5 then 'excellent'
    when {{ rating_column }} >= 4.0 then 'good'
    else 'average'
end
{% endmacro %}
