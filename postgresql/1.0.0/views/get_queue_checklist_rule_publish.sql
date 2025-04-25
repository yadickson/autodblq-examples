--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.1.3
--
-- Name: get_queue_checklist_rule_publish

create view get_queue_checklist_rule_publish as  WITH latest_checklist_versions AS (
         SELECT DISTINCT ON (cv_1.checklist_id) cv_1.id,
            cv_1.checklist_id,
            cv_1.checklist_spec_id,
            cv_1.version,
            cv_1.status,
            cv_1.created_by,
            cv_1.created_at,
            cv_1.updated_at,
            cv_1.updated_by
           FROM checklist_versions cv_1
          ORDER BY cv_1.checklist_id, cv_1.version DESC
        )
 SELECT DISTINCT ON (qc.id) qc.id,
    qc.queue_id,
    qc.checklist_id,
    qr.rule_id,
    q.deadline,
    c.title,
    c.description,
    cv.id AS checklist_version_id,
    cs.id AS checklist_spec_id,
    cs.content
   FROM ((((((queue_checklist qc
     LEFT JOIN queue_rule qr ON ((qc.queue_id = qr.queue_id)))
     LEFT JOIN queue q ON ((q.id = qc.queue_id)))
     LEFT JOIN rule_versions rv ON ((qr.rule_id = rv.rule_id)))
     LEFT JOIN checklist c ON ((qc.checklist_id = c.id)))
     LEFT JOIN latest_checklist_versions cv ON ((qc.checklist_id = cv.checklist_id)))
     LEFT JOIN checklist_specs cs ON ((cv.checklist_spec_id = cs.id)))
  WHERE (rv.status = 'published'::t_rule_version_status);
