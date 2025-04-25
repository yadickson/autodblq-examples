--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Name: alerts_search

create view alerts_search as  SELECT a.id AS alert_id,
    a.registered_at,
    a.created_by,
    a.rule_id,
    a.spec_id,
    a.execution_id,
    a.detected_at,
    a.exploded_transaction_id,
    a.related_transactions,
    a.related_actions,
    a.related_alerts,
    a.related_entities,
    a.related_instruments,
    a.tags,
    a.scores,
    a.fraud,
    a.assigned_to,
    a.state,
    a.title,
    a.custom_data,
    a.deadline,
    a.deadline_date,
    a.type,
    r.title AS rule_name,
    rv.status AS rule_status,
    (((a.disposition)::jsonb ->> 'When'::text))::timestamp without time zone AS disposition_when,
    ((a.disposition)::jsonb ->> 'Note'::text) AS disposition_notes,
    (((a.disposition)::jsonb ->> 'Type'::text))::numeric AS disposition_type,
    (((a.score)::jsonb ->> 'Level'::text))::integer AS score_level,
    (((a.score)::jsonb ->> 'Value'::text))::numeric AS score_value,
    ((a.score)::jsonb ->> 'Code'::text) AS score_code,
    (((a.amount)::jsonb ->> 'Value'::text))::numeric AS amount_value,
    ((a.amount)::jsonb ->> 'Currency'::text) AS amount_currency,
    r.model_code AS rule_scenario,
    et.s_amount AS transaction_amount,
    se.name AS entity_name,
    se.national_identification_number AS entity_nin,
    se.type AS entity_type,
    se.subtype AS entity_subtype,
    se.pep AS entity_pep,
    se.risk_score AS entity_risk_score
   FROM (((((alerts a
     LEFT JOIN rules r ON ((a.rule_id = r.id)))
     LEFT JOIN exploded_transactions et ON (((a.exploded_transaction_id)::text = (et.id)::text)))
     LEFT JOIN entities se ON (((a.entity_id)::text = (se.id)::text)))
     LEFT JOIN ( SELECT DISTINCT ON (rule_specs.rule_id) rule_specs.id,
            rule_specs.rule_id,
            rule_specs.content,
            rule_specs.created_by,
            rule_specs.created_at,
            rule_specs.updated_by,
            rule_specs.updated_at
           FROM rule_specs) rs ON ((rs.id = a.spec_id)))
     LEFT JOIN rule_versions rv ON ((r.id = rv.rule_id)));
