
  
    

        create or replace transient table MARKETING.marketing.stg_spend
         as
        (with source as (
    select  * from MARKETING.raw.raw_spend
),

cleaned as (
    select
        spend_id,
        campaign_id,
        
    try_to_date(spend_date, 'DD/MM/YYYY')
 as spend_date,
        try_to_number(replace(spend_amount, '$', '')) as spend_amount,
        lower(currency) as currency,
        
    nullif(
        case 
            when lower(notes) in ('', 'n/a', 'none', 'null', '-') then null 
            else notes
        end,
        ''
    )
 as notes,
    from source
)

select * from cleaned
        );
      
  