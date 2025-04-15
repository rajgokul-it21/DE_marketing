
    
    

with all_values as (

    select
        status as value_field,
        count(*) as n_records

    from MARKETING.marketing.stg_campaigns
    group by status

)

select *
from all_values
where value_field not in (
    'planned','active','completed'
)


