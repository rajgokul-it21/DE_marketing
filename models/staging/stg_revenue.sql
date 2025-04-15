with source as (
    select  * from {{ source('marketing', 'raw_revenue') }}
),

cleaned as (
    select
        lead_id,
        campaign_id,
        {{ normalize_text('lead_source', 'lower') }} as lead_source,
        {{ clean_bool('converted') }} as is_converted,
        revenue as revenue_amount, 
        cast(revenue_date as date) as revenue_date,
    from source
)

select * from cleaned 