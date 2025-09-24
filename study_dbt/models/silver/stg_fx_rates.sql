-- Normalização de taxas de câmbio
select
  rate_date::date as rate_date,
  upper(currency) as currency,
  (rate_to_brl)::numeric as rate_to_brl
from {{ ref('raw_fx_rates') }}