
  
    

        create or replace transient table MARKETING.marketing.stg_leads
         as
        (with source as (
    select  * from MARKETING.raw.raw_leads
),

cleaned as (
    select
        lead_id,
        campaign_id,
        lower(trim(nullif(lead_source, ''))) as lead_source,
        
    case 
        when lower(converted) in ('1', 'true', 'yes') then true
        when lower(converted) in ('0', 'false', 'no') then false
        else null
    end
 as is_converted,
        initcap(trim(nullif(name, ''))) as name,
        lower(trim(nullif(email, ''))) as email,
        converted_date,
    from source
)

select * from cleaned
        );
      
  