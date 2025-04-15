
  
    

        create or replace transient table MARKETING.marketing.fct_inactive_campaigns
         as
        (with leads as (
    select
        campaign_id,
        count(*) as total_leads,
        sum(case when is_converted then 1 else 0 end) as total_conversions
    from MARKETING.marketing.stg_leads
    group by campaign_id
),

all_campaigns as (
    select
        campaign_id,
        campaign_name,
        status,
        start_date,
        end_date
    from MARKETING.marketing.stg_campaigns
),

joined as (
    select 
        c.campaign_id,
        c.campaign_name,
        c.status,
        c.start_date,
        c.end_date,
        coalesce(l.total_leads, 0) as total_leads,
        coalesce(l.total_conversions, 0) as total_conversions
    from all_campaigns c
    left join leads l on c.campaign_id = l.campaign_id
)

select *,
    case 
        when total_leads = 0 then 'No Leads'
        when total_conversions = 0 then 'Zero Conversions'
    end as issue
from joined
where total_leads = 0 or total_conversions = 0
        );
      
  