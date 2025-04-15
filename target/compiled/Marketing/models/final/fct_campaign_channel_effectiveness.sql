with leads as (
    select campaign_id, count(*) as total_leads
    from MARKETING.marketing.stg_leads
    group by campaign_id
),

conversions as (
    select campaign_id, count(*) as converted_leads
    from MARKETING.marketing.stg_leads
    where is_converted = true
    group by campaign_id
)

select
    c.campaign_id,
    c.campaign_name,
    c.channel_id,
    l.total_leads,
    cv.converted_leads,
    round(cv.converted_leads * 1.0 / nullif(l.total_leads, 0), 2) as conversion_rate
from MARKETING.marketing.stg_campaigns c
left join leads l on c.campaign_id = l.campaign_id
left join conversions cv on c.campaign_id = cv.campaign_id