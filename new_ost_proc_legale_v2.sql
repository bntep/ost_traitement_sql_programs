/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_proc_legale;
create table temp_PATTERN_proc_legale as
select distinct on (company_id,event_id,subevent_id,creditor_meeting_type_code,initial_entry_date) *
from PATTERN_proc_legale
order by company_id,event_id,subevent_id,creditor_meeting_type_code,initial_entry_date,date_extraction desc, 
case marqueur_zaa
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;
-- 
-- 1771



/*Etape 2*/

-- marqueur zaa
--select count(*) from  temp_PATTERN_proc_legale where marqueur_zaa='D';
delete from temp_PATTERN_proc_legale where marqueur_zaa='D';
-- 33

-- message_type_code
--select count(*) from  temp_PATTERN_proc_legale where message_type_code=3;
delete from temp_PATTERN_proc_legale where message_type_code=3;
-- 3

-- marqueur_zve
update temp_PATTERN_proc_legale set 
category_proceedings_code=NULL,
submission_date=NULL,
commencement_date=NULL,
seizure_of_assets_flag=NULL,
proceeding_case_number=NULL
where marqueur_zve='D';
--0

-- marqueur_zvn
update temp_PATTERN_proc_legale set 
legal_basis_for_us_chapters_code=NULL,
debt_restraining_up_date=NULL,
debt_deadline_extended_until_date=NULL,
debt_deadline_extended_date=NULL,
compo_agreement_accepted_flag=NULL,
compo_quota=NULL
where marqueur_zvn='D';
--0

-- marqueur_zvf
update temp_PATTERN_proc_legale set 
filing_of_claims_date=NULL,
filing_of_claims_number_of_days=NULL,
filing_of_claims_number_of_days_unit_code=NULL,
filing_of_claims_extended_start_date=NULL,
filing_of_claims_time_unit_end_date=NULL
where marqueur_zvf='D';
--0

-- marqueur_zvv
update temp_PATTERN_proc_legale set 
procedure_type_code=NULL
where marqueur_zvv='D';
--1

-- marqueur_zvu
update temp_PATTERN_proc_legale set 
proceedings_currency_code=NULL,
cash_advance=NULL,
cash_advance_start_period_date=NULL,
cash_advance_end_period_date=NULL
where marqueur_zvu='D';
--0

-- marqueur_zvk
update temp_PATTERN_proc_legale set 
priority_debt_presentment_type_code=NULL,
priority_debt_presentment_start_date=NULL,
priority_debt_presentment_end_date=NULL,
priority_debt_presentment_number_of_days=NULL,
priority_debt_presentment_number_of_days_unit_code=NULL
where marqueur_zvk='D';
--0

-- marqueur_zvs
update temp_PATTERN_proc_legale set 
final_account_presentment_type_code=NULL,
final_account_presentment_start_date=NULL,
final_account_presentment_end_date=NULL,
final_account_presentment_number_of_days=NULL,
final_account_presentment_number_of_days_unit_code=NULL
where marqueur_zvs='D';
--0

-- marqueur_zvz
update temp_PATTERN_proc_legale set 
verdict_date=NULL,
discontinuance_reason_code=NULL,
discontinuance_proceedings_description=NULL
where marqueur_zvz='D';
--2

-- marqueur_zvg
update  temp_PATTERN_proc_legale set 
creditor_meeting_date=NULL,
creditor_meeting_type_code=NULL,
last_hearing_flag=NULL,
creditor_meeting_address=NULL,
creditor_meeting_street=NULL,
creditor_meeting_city=NULL
where marqueur_zvg='D';
--2

--marqueur_txn
--select count(*) from  temp_PATTERN_proc_legale where marqueur_txn='D';
update temp_PATTERN_proc_legale set additional_remarks=NULL where marqueur_txn='D';
--0

-- nettoyage des lignes sans informations
delete from temp_PATTERN_proc_legale where 
marqueur_zve=NULL 
;
--0

-- supprimer les variables inutiles
alter table temp_PATTERN_proc_legale 
drop column sequential_number,
drop column message_type_code, drop column message_status_code, drop column source_date,
drop column  marqueur_mgg,drop column  marqueur_mga,drop column  marqueur_gek,drop column  marqueur_zaa,
drop column  marqueur_zve,drop column  marqueur_zvn,drop column  marqueur_zvf,drop column  marqueur_zvv,
drop column  marqueur_zvu,drop column  marqueur_zvk,drop column  marqueur_zvs,drop column  marqueur_zvz,
drop column date_extraction,drop column  marqueur_zvg,drop column  marqueur_txz,
drop column  marqueur_txn,drop column  marqueur_tqu;


GRANT SELECT ON temp_PATTERN_proc_legale TO GROUP group_edifact;

ALTER TABLE temp_PATTERN_proc_legale ADD PRIMARY KEY (company_id,event_id,subevent_id,id);
