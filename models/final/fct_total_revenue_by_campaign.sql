select
    campaign_id,
    sum(revenue_amount) as total_revenue
from {{ ref('stg_revenue') }}
group by campaign_id
