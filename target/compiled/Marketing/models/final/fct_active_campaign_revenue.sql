select
    c.campaign_id,
    c.campaign_name,
    sum(r.revenue_amount) as total_revenue
from MARKETING.marketing.stg_campaigns c
left join MARKETING.marketing.stg_revenue r on c.campaign_id = r.campaign_id
where c.status = 'Active'
group by 1, 2