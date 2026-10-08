with ranked as (
    select
        candidate_id,
        source,
        touch_order,
        touch_date,
        row_number() over (
            partition by candidate_id
            order by touch_order desc, touch_date desc
        ) as recency_rank
    from {{ ref('int_hired_journeys') }}
),
weighted as (
    select
        candidate_id,
        source,
        recency_rank,
        power(0.5, recency_rank - 1) as raw_weight
    from ranked
),
normalized as (
    select
        candidate_id,
        source,
        raw_weight,
        sum(raw_weight) over (partition by candidate_id) as total_weight
    from weighted
)
select
    candidate_id,
    source,
    raw_weight / total_weight as credit
from normalized