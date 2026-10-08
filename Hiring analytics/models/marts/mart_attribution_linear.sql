with journey_counts as (
    select
        candidate_id,
        count(*) as touch_count
    from {{ ref('int_hired_journeys') }}
    group by candidate_id
)

select
    j.candidate_id,
    j.source,
    1.0 / jc.touch_count as credit
from {{ ref('int_hired_journeys') }} j
join journey_counts jc
    on j.candidate_id = jc.candidate_id