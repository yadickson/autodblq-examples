--
-- Maven Auto Database to Liquibase Generator Plugin
-- 2.0.3-SNAPSHOT
--
-- Name: SYS_CODE_FALA

create view SYS_CODE_FALA (CODE, CODE_DELE, CODE_ADIC2, CODE_ADIC1, CODE_AUX, CODE_DESC, DOMAIN_CODE) as SELECT code, code_desc, domain_code, code_aux, code_dele, code_adic1, code_adic2
     FROM sys_code_reg_fala
    WHERE domain_tipo_valor = 'SYS'
    and domain_origen_valor='FALA'
