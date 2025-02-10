--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.0.3-SNAPSHOT
--
-- Name: SYS_CODE

create view SYS_CODE (CODE, CODE_DESC, DOMAIN_CODE, CODE_DELE, CODE_AUX) as SELECT code, code_desc, domain_code, code_aux, code_dele
     FROM sys_code_reg_fala
    WHERE domain_tipo_valor = 'SYS'
    and domain_origen_valor='DBST'
