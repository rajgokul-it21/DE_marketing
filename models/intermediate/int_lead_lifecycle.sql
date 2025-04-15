

with leads_extended as (
    select
        l.lead_id,
        l.name,
        l.email,
        l.is_converted,
        l.converted_date,
        c.channel_id
    from {{ ref('stg_leads') }} l
    left join {{ ref('stg_campaigns') }} c
        on l.campaign_id = c.campaign_id
)

select *
from leads_extended
