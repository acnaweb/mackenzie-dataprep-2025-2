-- Normalização de eventos web
select
  event_id,
  customer_id,
  lower(event_type) as event_type,
  event_ts,
  session_id
from {{ ref('raw_events_web') }}