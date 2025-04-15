with performance as (
    select * from {{ ref('int_campaign_performance') }}
)

select
    campaign_id,
    campaign_name,
    start_date,
    end_date,
    datediff('day', start_date, end_date) + 1 as duration_days,
    total_spend,
    round(total_spend / nullif(datediff('day', start_date, end_date) + 1, 0), 2) as cost_per_day
from performance
