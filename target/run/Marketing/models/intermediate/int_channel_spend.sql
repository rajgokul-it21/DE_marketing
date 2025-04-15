
  
    

        create or replace transient table MARKETING.marketing.int_channel_spend
         as
        (with spend_with_channel as (
    select
        s.spend_id,
        c.channel_id,
        s.spend_amount
    from MARKETING.marketing.stg_spend s
    left join MARKETING.marketing.stg_campaigns c
        on s.campaign_id = c.campaign_id
)

select
    channel_id,
    sum(spend_amount) as total_channel_spend
from spend_with_channel
group by channel_id
        );
      
  