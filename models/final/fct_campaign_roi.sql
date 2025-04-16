with revenue as (
    select
        campaign_id,
        sum(revenue_amount) as total_revenue
    from {{ ref('stg_revenue') }}
    group by campaign_id
),

performance as (
    select *
    from {{ ref('int_campaign_performance') }}
)

select
    p.campaign_id,
    p.campaign_name,
    p.total_spend,
    r.total_revenue,
    (r.total_revenue - p.total_spend) / nullif(p.total_spend, 0) as roi
from performance p
left join revenue r on p.campaign_id = r.campaign_id
