with source_credits as (
    select
        source,
        sum(credit) as attributed_hires
    from {{ ref('mart_attribution_linear') }}
    group by source
)

select
    sc.source,
    sc.monthly_cost,
    coalesce(c.attributed_hires, 0) as attributed_hires,

    round(
        sc.monthly_cost / nullif(coalesce(c.attributed_hires, 0), 0),2) as cost_per_attributed_hire

from {{ ref('source_costs') }} sc
left join source_credits c
    on sc.source = c.source