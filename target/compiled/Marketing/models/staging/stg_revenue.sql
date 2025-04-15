with source as (
    select  * from MARKETING.raw.raw_revenue
),

cleaned as (
    select
        lead_id,
        campaign_id,
        lower(trim(nullif(lead_source, ''))) as lead_source,
        
    case 
        when lower(converted) in ('1', 'true', 'yes') then true
        when lower(converted) in ('0', 'false', 'no') then false
        else null
    end
 as is_converted,
        revenue as revenue_amount, 
        cast(revenue_date as date) as revenue_date,
    from source
)

select * from cleaned