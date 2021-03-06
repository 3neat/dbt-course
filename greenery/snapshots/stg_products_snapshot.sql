{% snapshot stg_products_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='product_id',
        strategy='check',
        check_cols=['price','quantity']
    )
}}
    
select * from {{ source('tutorial','products') }}

{% endsnapshot %}