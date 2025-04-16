with leads_extended as (
    
    select
        l.lead_id,
        l.campaign_id,
        l.is_converted,
        l.converted_date,
        c.start_date,
       
        case 
            when l.is_converted = true and l.converted_date is not null and l.converted_date >= c.start_date
            then datediff('day', c.start_date, l.converted_date)
            else null 
        end as time_to_convert
    from {{ ref('stg_leads') }} l
    left join {{ ref('stg_campaigns') }} c
        on l.campaign_id = c.campaign_id
)


select
    campaign_id,
    avg(time_to_convert) as avg_time_to_convert
from leads_extended
where time_to_convert is not null  
group by campaign_id
order by avg_time_to_convert
