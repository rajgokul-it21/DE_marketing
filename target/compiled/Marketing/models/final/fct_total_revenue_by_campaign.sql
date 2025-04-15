select
    campaign_id,
    sum(revenue_amount) as total_revenue
from MARKETING.marketing.stg_revenue
group by campaign_id