with source as (
    select * from {{ source('marketing', 'raw_channels') }}
),



cleaned as (
    select
        {{ normalize_text('channel_id', 'upper') }} as channel_id,
        {{ normalize_text('channel_name', 'lower') }} as channel_name,
        {{ normalize_text('channel_type', 'lower') }} as channel_type,
        {{ normalize_text('region', 'title') }} as region,
        {{ null_if_invalid('description') }} as description
    from source
)

select * from cleaned
