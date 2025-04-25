--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Name: entity_alerts_search

create view entity_alerts_search as  SELECT e.id,
    e.national_identification_number AS nin,
    e.name,
    e.type,
    e.subtype,
    max(a.detected_at) AS last_alert_date_time,
    COALESCE(count(a.id) FILTER (WHERE ((a.state)::text = 'opened'::text)), (0)::bigint) AS count_opened_alerts,
    COALESCE(min((((a.score)::jsonb ->> 'Value'::text))::numeric), (0)::numeric) AS min_score_alert,
    COALESCE(max((((a.score)::jsonb ->> 'Value'::text))::numeric), (0)::numeric) AS max_score_alert,
    COALESCE(avg((((a.score)::jsonb ->> 'Value'::text))::numeric), (0)::numeric) AS avg_score_alert,
    COALESCE(sum((((a.amount)::jsonb ->> 'Value'::text))::numeric), (0)::numeric) AS total_amount_alert,
    COALESCE(max((((a.amount)::jsonb ->> 'Value'::text))::numeric), (0)::numeric) AS max_amount_alert,
    e.pep,
    e.risk_score
   FROM (entities e
     LEFT JOIN alerts a ON (((e.id)::text = (a.entity_id)::text)))
  GROUP BY e.id;
