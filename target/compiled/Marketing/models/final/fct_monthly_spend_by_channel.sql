with spend as (
    select
        c.channel_id,
        to_char(s.spend_date, 'YYYY-MM') as month,
        sum(s.spend_amount) as total_spend
    from MARKETING.marketing.stg_spend s
    left join MARKETING.marketing.stg_campaigns c
        on s.campaign_id = c.campaign_id
    group by c.channel_id, to_char(s.spend_date, 'YYYY-MM')
)

select * from spend