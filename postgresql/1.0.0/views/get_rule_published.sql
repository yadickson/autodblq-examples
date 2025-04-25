--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Name: get_rule_published

create view get_rule_published as  WITH default_queue AS (
         SELECT queue.id
           FROM queue
          WHERE (queue.default_queue = true)
         LIMIT 1
        )
 SELECT DISTINCT ON (r.id) r.id,
    rv.spec_id,
    r.model_code,
    rs.content,
    r.title,
    COALESCE(qr.queue_id, dq.id) AS queue_id
   FROM ((((rules r
     LEFT JOIN rule_versions rv ON ((r.id = rv.rule_id)))
     LEFT JOIN rule_specs rs ON ((rv.spec_id = rs.id)))
     LEFT JOIN queue_rule qr ON ((qr.rule_id = r.id)))
     LEFT JOIN default_queue dq ON (true))
  WHERE (rv.status = 'published'::t_rule_version_status);
