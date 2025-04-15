with source as (
    select  * from {{ source('marketing', 'raw_leads') }}
),

cleaned as (
    select
        lead_id,
        campaign_id,
        {{ normalize_text('lead_source', 'lower') }} as lead_source,
        {{ clean_bool('converted') }} as is_converted,
        {{ normalize_text('name', 'title') }} as name,
        {{ normalize_text('email', 'lower') }} as email,
        converted_date,
    from source
)

select * from cleaned 
