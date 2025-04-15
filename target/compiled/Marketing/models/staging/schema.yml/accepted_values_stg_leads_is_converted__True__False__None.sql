
    
    

with all_values as (

    select
        is_converted as value_field,
        count(*) as n_records

    from MARKETING.marketing.stg_leads
    group by is_converted

)

select *
from all_values
where value_field not in (
    'True','False','None'
)


