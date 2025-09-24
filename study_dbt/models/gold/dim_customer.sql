-- Dimensão de clientes
select *
from {{ ref('stg_customers') }}