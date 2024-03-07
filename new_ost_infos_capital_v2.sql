/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_infos_capital ;
create table temp_PATTERN_infos_capital  as
select distinct on (instrument_id,currency_nominal_code,nominal,capital_type_code,number_of_instruments,capital_amount,date_of_last_mutation) *, date_extraction as initial_entry_date
from PATTERN_infos_capital
order by instrument_id,currency_nominal_code,nominal,capital_type_code,number_of_instruments,capital_amount,date_of_last_mutation,date_extraction desc, 
case marqueur_mga
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;

-- 296588

/*Etape 2*/

-- marqueur_mga
--select * from  temp_PATTERN_infos_capital  where marqueur_zaa='D';
delete from temp_PATTERN_infos_capital  where marqueur_mga='D';
-- 1

-- message_type_code
--select * from  temp_PATTERN_infos_capital  where message_type_code=3;
delete from temp_PATTERN_infos_capital  where message_type_code=3;
-- 71

-- marqueur_fmn
--select * from  temp_PATTERN_infos_capital  where marqueur_fmn='D';
update  temp_PATTERN_infos_capital  set
currency_nominal_code=NULL,
nominal=NULL,
nominal_unit_code=NULL
where marqueur_fmn='D' ;
-- 0

-- marqueur_kap
--select * from  temp_PATTERN_infos_capital  where marqueur_kap='D';
update  temp_PATTERN_infos_capital  set
capital_type_code=NULL,
number_of_instruments=NULL,
capital_amount=NULL,
effective_date=NULL,
capital_data_input_grade_code=NULL
where marqueur_kap='D' ;
-- 64

-- marqueur_zaz
--select count(*) from  temp_PATTERN_infos_capital where marqueur_zaz='D';
update temp_PATTERN_infos_capital  set 
ref_single_message_id=NULL,
ref_date_of_last_mutation=NULL
where marqueur_zaz='D';
--0

--marqueur_txn
update temp_PATTERN_infos_capital  set additional_remarks=NULL where marqueur_txn='D';
--7

-- nettoyage des lignes sans informations

-- supprimer les variables inutiles
alter table temp_PATTERN_infos_capital  
drop column message_type_code, drop column message_status_code,
drop column marqueur_mga,drop column marqueur_vak,drop column marqueur_fmn,drop column marqueur_kap,
drop column marqueur_txn,drop column marqueur_zaz,drop column marqueur_tqu,
drop column date_extraction, drop column source_date;


GRANT SELECT ON temp_PATTERN_infos_capital  TO GROUP group_edifact;

ALTER TABLE temp_PATTERN_infos_capital  ADD PRIMARY KEY (initial_entry_date, instrument_id,currency_nominal_code,date_of_last_mutation,id);
