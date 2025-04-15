
  
    

        create or replace transient table MARKETING.marketing.fct_total_revenue_by_campaign
         as
        (select
    campaign_id,
    sum(revenue_amount) as total_revenue
from MARKETING.marketing.stg_revenue
group by campaign_id
        );
      
  