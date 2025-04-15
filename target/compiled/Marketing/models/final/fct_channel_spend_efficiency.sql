with leads as (
    select campaign_id, count(*) as leads
    from MARKETING.marketing.stg_leads
    group by campaign_id
),

spend as (
    select campaign_id, sum(spend_amount) as spend
    from MARKETING.marketing.stg_spend
    group by campaign_id
),

combined as (
    select
        c.channel_id,
        s.spend,
        l.leads
    from MARKETING.marketing.stg_campaigns c
    left join spend s on c.campaign_id = s.campaign_id
    left join leads l on c.campaign_id = l.campaign_id
)

select
    channel_id,
    sum(spend) as total_spend,
    sum(leads) as total_leads,
    round(sum(spend) / nullif(sum(leads), 0), 2) as spend_per_lead
from combined
group by channel_id