--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Name: rule_search

create view rule_search as  SELECT DISTINCT ON (r.id) r.id,
    r.title,
    r.description,
    r.created_by,
    r.created_at,
    r.model_code,
    r.updated_at,
    r.updated_by,
    r.enabled,
    rv.spec_id,
    rv.status,
    rv.stage,
    rv.version,
    rv.created_by AS version_created_by,
    rv.created_at AS version_created_at,
    rv.updated_at AS version_updated_at,
    rv.updated_by AS version_updated_by
   FROM (rules r
     LEFT JOIN rule_versions rv ON ((r.id = rv.rule_id)))
  ORDER BY r.id, rv.version DESC;
