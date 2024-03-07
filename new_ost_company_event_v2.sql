/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_company_event;
create table temp_PATTERN_company_event as
select distinct on (company_id,event_id,company_role_owner_id,initial_entry_date) *
from PATTERN_company_event
order by company_id,event_id,company_role_owner_id,initial_entry_date,date_extraction desc, 
case marqueur_mgg
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;
-- 466146
-- 48033


/*Etape 2*/

-- marqueur mgg
--select count(*) from  temp_PATTERN_company_event where marqueur_mgg='D';
delete from temp_PATTERN_company_event where marqueur_mgg='D';
-- 1191


-- message_type_code
--select count(*) from  temp_PATTERN_company_event where message_type_code=3;
delete from temp_PATTERN_company_event where message_type_code=3;
-- 110

-- marqueur_zae
--select count(*) from  temp_PATTERN_company_event where marqueur_zae='D';
update temp_PATTERN_company_event set 
corporate_action_type_code=NULL,
meeting_date=NULL,
effective_date=NULL,
substitute_effective_date_flag=NULL,
corporate_action_status_code=NULL,
announcement_date=NULL
where marqueur_zae='D';
-- 0

-- marqueur_txy
update temp_PATTERN_company_event set event_name=NULL where marqueur_txy='D';
--14

-- marqueur_txm
update temp_PATTERN_company_event set event_description=NULL where marqueur_txm='D';
--8

-- marqueur_zab
--select count(*) from  temp_PATTERN_company_event where marqueur_zab='D';
update temp_PATTERN_company_event set 
subevent_id=NULL,
subevent_sequence_number=NULL,
subevent_type_code=NULL,
subevent_status_code=NULL,
subevent_input_grade_code=NULL
where marqueur_zab='D';
--234

--marqueur_zao
--select count(*) from  temp_PATTERN_company_event where marqueur_zao='D';
update temp_PATTERN_company_event set 
offer_status_code=NULL,
offer_limit_flag=NULL,
public_authorities_approval_code=NULL,
cartel_authorities_approval_code=NULL,
withdrawal_by_offering_flag=NULL,
withdrawal_by_investor_flag=NULL,
extension_notice_period_flag=NULL,
additional_payment_guarantee_flag=NULL
where marqueur_zao='D';
--34

--marqueur_zar
--select count(*) from  temp_PATTERN_company_event where marqueur_zar='D';

update temp_PATTERN_company_event set 
event_role_type_code=NULL,
event_role_valid_date=NULL
where marqueur_zar='D';
--23

--marqueur_ztm
--select count(*) from  temp_PATTERN_company_event where marqueur_ztm='D';
update temp_PATTERN_company_event set
event_role_number=NULL,
new_company_registration_date=NULL
where marqueur_ztm='D';
--29

--marqueur_gei
--select count(*) from  temp_PATTERN_company_event where marqueur_gei='D';
update temp_PATTERN_company_event set
company_role_owner_id=NULL,
company_role_owner_name=NULL
where marqueur_gei='D';
-- 126

--marqueur_zas
--select count(*) from  temp_PATTERN_company_event where marqueur_zas='D';
update temp_PATTERN_company_event set 
company_role_owner_domicile_code=NULL,
event_role_owner_name=NULL,
event_role_owner_contact=NULL,
event_role_owner_street=NULL,
event_role_owner_postal_code=NULL,
event_role_owner_city=NULL
where marqueur_zas='D';
--31

--marqueur_zah
--select count(*) from  temp_PATTERN_company_event where marqueur_zah='D';
update temp_PATTERN_company_event set 
deletion_from_register_flag=NULL,
deletion_from_register_date=NULL
where marqueur_zah='D';
--1

--marqueur_zay
--select count(*) from  temp_PATTERN_company_event where marqueur_zay='D';
update temp_PATTERN_company_event set 
ref_event_id=NULL,
ref_company_id=NULL
where marqueur_zay='D';
--0

--marqueur_txn
--select count(*) from  temp_PATTERN_company_event where marqueur_txn='D';
update temp_PATTERN_company_event set additional_remarks=NULL where marqueur_txn='D';
--61

-- nettoyage des lignes sans informations
select count(*) from temp_PATTERN_company_event
where marqueur_zae=NULL AND marqueur_zab=NULL AND marqueur_zao=NULL;

delete from temp_PATTERN_company_event where 
marqueur_zae=NULL AND 
marqueur_zab=NULL AND 
marqueur_zao=NULL
;


-- supprimer les variables inutiles
alter table temp_PATTERN_company_event 
drop column sequential_number,
drop column message_type_code, drop column message_status_code,drop column date_extraction, drop column source_date,
drop column  marqueur_mgg,drop column  marqueur_mga,drop column  marqueur_gek,drop column  marqueur_zae,
drop column  marqueur_txy,drop column  marqueur_txm,drop column  marqueur_zab,drop column  marqueur_zao,
drop column  marqueur_txn,drop column  marqueur_zah,drop column  marqueur_zay,drop column  marqueur_tqu,
drop column  marqueur_zar,drop column  marqueur_ztm,drop column  marqueur_gei,drop column  marqueur_zas;


GRANT SELECT ON temp_PATTERN_company_event TO GROUP group_edifact;

ALTER TABLE temp_PATTERN_company_event ADD PRIMARY KEY (company_id,event_id,id);

