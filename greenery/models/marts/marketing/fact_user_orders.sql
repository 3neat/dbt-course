{{ 
    config(
        materialized='table'
    )
}}

select
    user_id
from {{ ref('stg_users') }} u