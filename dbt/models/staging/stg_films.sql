select *
from {{ source("elt_raw", "films") }}
