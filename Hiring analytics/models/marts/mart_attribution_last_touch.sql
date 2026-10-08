with ranked_touches as (
    select
        candidate_id,
        source,
        touch_date,
        row_number() over (
            partition by candidate_id
            order by touch_order desc, touch_date desc, source desc
        ) as source_rank
    from {{ ref('int_hired_journeys') }}
)

select
    candidate_id,
    source,
    touch_date,
    1.0 as credit
from ranked_touches
where source_rank = 1
