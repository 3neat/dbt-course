{% snapshot stg_users_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='id',
        strategy='timestamp',
        updated_at='updated_at'
    )
}}

select * from {{ source('staging','users') }}

{% endsnapshot %}