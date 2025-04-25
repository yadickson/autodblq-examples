--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Name: entity_transactions_search

create view entity_transactions_search as  WITH last_transaction AS (
         SELECT DISTINCT ON (t.s_entity_id) t.s_entity_id,
            t.executed_at,
            t.s_amount,
            t.s_currency,
            t.s_context,
            t.r_context
           FROM exploded_transactions_historic t
          ORDER BY t.s_entity_id, t.executed_at DESC
        )
 SELECT e.id,
    e.national_identification_number AS nin,
    e.name,
    e.type AS entity_type,
    e.subtype AS entity_subtype,
    lt.executed_at AS last_transaction_date_time,
    COALESCE(lt.s_amount, (0)::numeric) AS max_amount_transaction,
    lt.s_currency AS currency,
    lt.s_context,
    lt.r_context,
    e.pep,
    e.risk_score
   FROM (entities e
     LEFT JOIN last_transaction lt ON (((e.id)::text = (lt.s_entity_id)::text)));
