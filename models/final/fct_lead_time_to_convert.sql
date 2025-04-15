with leads_extended as (
    -- Step 1: Calculate time to convert per lead
    select
        l.lead_id,
        l.campaign_id,
        l.is_converted,
        l.converted_date,
        c.start_date,
        -- Calculate time to convert only if the lead is converted, and the converted date is after or equal to start date
        case 
            when l.is_converted = true and l.converted_date is not null and l.converted_date >= c.start_date
            then datediff('day', c.start_date, l.converted_date)
            else null -- Set to null if not converted, or converted date is before start date, or converted date is null
        end as time_to_convert
    from {{ ref('stg_leads') }} l
    left join {{ ref('stg_campaigns') }} c
        on l.campaign_id = c.campaign_id
)

-- Step 2: Aggregate to get average time to convert per campaign
select
    campaign_id,
    avg(time_to_convert) as avg_time_to_convert
from leads_extended
where time_to_convert is not null  -- Only consider converted leads
group by campaign_id
order by avg_time_to_convert
