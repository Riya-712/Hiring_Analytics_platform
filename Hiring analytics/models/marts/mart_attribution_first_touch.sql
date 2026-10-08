with ranked as (
    select
        candidate_id,
        source,
        touch_order,
        row_number() over (
            partition by candidate_id
            order by touch_order asc, touch_date asc
        ) as rn
    from {{ ref('int_hired_journeys') }}
)

select
    candidate_id,
    source,
    1.0 as credit
from ranked
where rn = 1