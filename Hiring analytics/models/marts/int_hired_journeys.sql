with hired_candidates as (
    select distinct candidate_id
    from {{ ref('stg_events') }}
    where stage = 'Hired'
)

select
    t.candidate_id,
    t.touch_order,
    t.source,
    t.touch_date
from {{ ref('stg_touchpoints') }} t
join hired_candidates h
    on t.candidate_id = h.candidate_id