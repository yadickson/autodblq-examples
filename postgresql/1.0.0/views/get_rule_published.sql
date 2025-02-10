--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.0.3-SNAPSHOT
--
-- Name: get_rule_published

create view get_rule_published as  SELECT DISTINCT ON (r.id) r.id,
    rv.spec_id,
    r.model_code,
    rs.content,
    r.title
   FROM ((rules r
     LEFT JOIN rule_versions rv ON ((r.id = rv.rule_id)))
     LEFT JOIN rule_specs rs ON ((rv.spec_id = rs.id)))
  WHERE (rv.status = 'published'::t_rule_version_status);
