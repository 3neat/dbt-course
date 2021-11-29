{% snapshot stg_promos_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='promo_id',
        strategy='check',
        check_cols=['status']
    )
}}
    
select * from {{ source('tutorial','promos') }}

{% endsnapshot %}