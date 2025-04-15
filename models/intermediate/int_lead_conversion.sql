

with leads_with_channel as (
    select
        l.lead_id,
        l.is_converted,
        c.channel_id
    from {{ ref('stg_leads') }} l
    left join {{ ref('stg_campaigns') }} c
        on l.campaign_id = c.campaign_id
)

select
    channel_id,
    count(*) as total_leads,
    count_if(is_converted) as converted_leads
from leads_with_channel
group by channel_id
