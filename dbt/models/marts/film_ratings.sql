select
    film_id,
    title,
    user_rating,
    {{ film_rating_tier("user_rating") }} as rating_tier
from {{ ref("stg_films") }}
