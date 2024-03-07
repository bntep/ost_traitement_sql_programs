/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_data_change ;
create table temp_PATTERN_data_change  as
select distinct on (company_id,event_id,subevent_id,initial_entry_date) * from PATTERN_data_change
order by company_id,event_id,subevent_id,initial_entry_date,date_extraction desc, 
case marqueur_zaa
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;
-- 56074
-- 9836

/*Etape 2*/

-- marqueur zaa
--select * from  temp_PATTERN_data_change  where marqueur_zaa='D';
delete from temp_PATTERN_data_change  where marqueur_zaa='D';
-- 219

-- message_type_code
--select * from  temp_PATTERN_data_change  where message_type_code=3;
delete from temp_PATTERN_data_change  where message_type_code=3;
-- 16

-- marqueur_zse
--select * from  temp_PATTERN_data_change  where marqueur_zse='D';
update temp_PATTERN_data_change  set 
company_data_change_type_code=NULL,
effective_date=NULL,
substitute_effective_date_flag=NULL
where marqueur_zse='D';
-- 0

-- marqueur_zso
--select count(*) from  temp_PATTERN_data_change where marqueur_zso='D';
update temp_PATTERN_data_change  set 
old_company_short_name=NULL,
old_company_name=NULL,
old_company_location=NULL
where marqueur_zso='D';
--29

--marqueur_zsn
--select count(*) from  temp_PATTERN_data_change where marqueur_zsn='D';
update temp_PATTERN_data_change  set 
new_company_short_name=NULL,
new_company_name=NULL,
new_company_location=NULL
where marqueur_zsn='D';
--3

--marqueur_zss
--select count(*) from  temp_PATTERN_data_change where marqueur_zss='D';
update temp_PATTERN_data_change  set 
old_company_six_sector_code=NULL,
old_company_legal_form_code=NULL
where marqueur_zss='D';
--1

--marqueur_zst
--select count(*) from  temp_PATTERN_data_change where marqueur_zst='D';
update temp_PATTERN_data_change  set 
new_company_six_sector_code=NULL,
new_company_legal_form_code=NULL
 where marqueur_zst='D';
--0

--marqueur_txn
update temp_PATTERN_data_change  set additional_remarks=NULL where marqueur_txn='D';
--2

-- nettoyage des lignes sans informations
select count(*) from temp_PATTERN_data_change 
where marqueur_zaa=NULL AND marqueur_zse=NULL AND marqueur_zso=NULL AND marqueur_zsn=NULL
AND marqueur_zss=NULL AND marqueur_zst=NULL;

delete from temp_PATTERN_data_change  where 
marqueur_zaa=NULL AND 
marqueur_zse=NULL AND 
marqueur_zso=NULL AND 
marqueur_zsn=NULL AND 
marqueur_zss=NULL AND 
marqueur_zst=NULL 
;


-- supprimer les variables inutiles
alter table temp_PATTERN_data_change  
drop column sequential_number,
drop column single_message_id, drop column message_type_code, drop column message_status_code,
drop column  marqueur_mgg,drop column  marqueur_mga,drop column  marqueur_zaa,drop column  marqueur_zse,
drop column  marqueur_zso,drop column  marqueur_zsn,drop column  marqueur_zss,drop column  marqueur_zst,
drop column  marqueur_txn,drop column  marqueur_tqu,
drop column date_extraction, drop column source_date;


GRANT SELECT ON temp_PATTERN_data_change  TO GROUP group_edifact;
--ALTER TABLE temp_PATTERN_data_change  RENAME TO temp_202001_ost_capital_change;

--delete from temp_202001_ost_capital_change where code_ch=1183542 and code_ost=403 and date_ost='2014-04-21' and date_effective is null;


ALTER TABLE temp_PATTERN_data_change  ADD PRIMARY KEY (company_id,event_id,subevent_id,initial_entry_date);
