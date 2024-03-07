/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_class_action;
create table temp_PATTERN_class_action as
select distinct on (instrument_id,event_id,subevent_id,class_action_members_number, class_action_date_type_code,initial_entry_date) *
from PATTERN_class_action
order by instrument_id,event_id,subevent_id,class_action_members_number, class_action_date_type_code,initial_entry_date,date_extraction desc, 
case marqueur_zaa
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;
-- 
-- 864

/*Etape 2*/

-- marqueur zaa
--select count(*) from  temp_PATTERN_class_action where marqueur_zaa='D';
delete from temp_PATTERN_class_action where marqueur_zaa='D';
-- 3

-- message_type_code
--select count(*) from  temp_PATTERN_class_action where message_type_code=3;
delete from temp_PATTERN_class_action where message_type_code=3;
-- 0

-- marqueur_gej
--select count(*) from  temp_PATTERN_class_action where marqueur_gej='D';
update temp_PATTERN_class_action set 
company_id=NULL
where marqueur_gej='D';
-- 0

-- marqueur_zce
update temp_PATTERN_class_action set 
category_of_proceedings_code=NULL,
class_action_case_number=NULL,
class_action_status_code=NULL,
settlement_amout_currency_code=NULL,
settlement_amount=NULL,
settlement_amount_unit_code=NULL,
settlement_amount_quotation_type_code=NULL
where marqueur_zce='D';
--0

-- marqueur_zcg
UPDATE temp_PATTERN_class_action set
class_action_members_number=NULL
where marqueur_zcg='D';
--3

-- marqueur_zcp
update temp_PATTERN_class_action set 
relevant_period_start_date=NULL,
relevant_periode_end_date=NULL,
relevant_period_date=NULL
where marqueur_zcp='D';
--0

-- marqueur_zcs
--select count(*) from  temp_PATTERN_class_action_agenda where marqueur_igt='D';
update  temp_PATTERN_class_action SET
class_action_date_type_code=NULL,
class_action_start_date=NULL,
class_action_end_date=NULL
where marqueur_zcs='D';
--1

-- marqueur_zcv
update temp_PATTERN_class_action set 
proof_of_claim_deadline=NULL,
exclusion_start_date=NULL,
exclusion_end_date=NULL,
request_exclusion_deadline=NULL
where marqueur_zcv='D';
--1

--marqueur_txn
--select count(*) from  temp_PATTERN_class_action where marqueur_txn='D';
update temp_PATTERN_class_action set additional_remarks=NULL where marqueur_txn='D';
--2

-- marqueur_zch
update temp_PATTERN_class_action set 
hearing_date=NULL,
last_hearing_flag=NULL,
hearing_building_infos=NULL,
hearing_address=NULL,
hearing_city=NULL
where marqueur_zch='D';
--0

--marqueur_txz
--select count(*) from  temp_PATTERN_class_action where marqueur_txz='D';
update temp_PATTERN_class_action set
hearing_description=NULL
where marqueur_txz='D';
--0

-- supprimer les variables inutiles
alter table temp_PATTERN_class_action 
drop column sequential_number,
drop column message_type_code, drop column message_status_code,drop column date_extraction, drop column source_date,
drop column  marqueur_mgg,drop column  marqueur_mga,drop column  marqueur_vak,drop column  marqueur_zaa,
drop column  marqueur_zcg, drop column  marqueur_txm,drop column  marqueur_zcs,
drop column  marqueur_gej,drop column  marqueur_zce,drop column  marqueur_zcp,drop column  marqueur_zcv,drop column  marqueur_txn,
drop column  marqueur_zch,drop column  marqueur_txz,drop column  marqueur_tqu;


GRANT SELECT ON temp_PATTERN_class_action TO GROUP group_edifact;

ALTER TABLE temp_PATTERN_class_action ADD PRIMARY KEY (instrument_id,event_id,subevent_id,id);
