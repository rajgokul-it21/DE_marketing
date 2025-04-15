with campaigns as (
    select * from MARKETING.marketing.stg_campaigns
),
spend as (
    select * from MARKETING.marketing.stg_spend
),
revenue as (
    select * from MARKETING.marketing.stg_revenue
)

select 
    c.campaign_id,
    c.campaign_name,
    c.start_date,
    c.end_date,
    s.total_spend,
    r.total_revenue,
    (r.total_revenue - s.total_spend) / nullif(s.total_spend, 0) as roi
from campaigns c
left join spend s using (campaign_id)
left join revenue r using (campaign_id)