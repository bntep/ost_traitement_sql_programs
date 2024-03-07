/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_capital_change;
create table temp_PATTERN_capital_change as
select distinct on (instrument_id,event_id,subevent_id,initial_entry_date) * from PATTERN_capital_change
order by instrument_id,event_id,subevent_id,initial_entry_date,date_extraction desc, 
case marqueur_zaa
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;
-- 101829
-- 17329

/*Etape 2*/

-- marqueur zaa
--select * from  temp_PATTERN_capital_change where marqueur_zaa='D';
delete from temp_PATTERN_capital_change where marqueur_zaa='D';
-- 669

-- capital_data_input_grade_code
--select effective_date, capital_amount_after_change,number_securities_after_change
--from  temp_PATTERN_capital_change where capital_data_input_grade_code=3;
delete from temp_PATTERN_capital_change where capital_data_input_grade_code=3;
-- 8208

-- message_type_code
--select effective_date, capital_amount_after_change,number_securities_after_change
--from  temp_PATTERN_capital_change where message_type_code=3;
delete from temp_PATTERN_capital_change where message_type_code=3;
--0

-- marqueur_gej
--select * from  temp_PATTERN_capital_change where marqueur_gej='D';
update temp_PATTERN_capital_change set company_id = NULL where marqueur_gej='D';
-- 0

-- marqueur_zke
--select distinct instrument_id from  temp_PATTERN_capital_change where marqueur_zke='D';
--select date_extraction,instrument_id, marqueur_zaa,event_id, subevent_id, marqueur_zke,effective_date 
--from PATTERN_capital_change where instrument_id='93449';
update temp_PATTERN_capital_change set effective_date=NULL where marqueur_zke='D';
--40

--marqueur_zka
--select distinct instrument_id from  temp_PATTERN_capital_change where marqueur_zka='D';
update temp_PATTERN_capital_change set capital_type_code=NULL where marqueur_zka='D';
--0

--marqueur_zkk
/*select distinct instrument_id from  temp_PATTERN_capital_change where marqueur_zkk='D';
select date_extraction,instrument_id, marqueur_zaa,event_id, subevent_id,capital_data_input_grade_code, 
marqueur_zkk,effective_date,capital_after_change_currency_code,capital_amount_after_change,
marqueur_zkt, number_securities_after_change
from PATTERN_capital_change where instrument_id='418230';*/
update temp_PATTERN_capital_change set capital_amount_after_change=NULL,capital_after_change_currency_code=NULL
where marqueur_zkk='D';
--4

--marqueur_zkt
--select distinct instrument_id from  temp_PATTERN_capital_change where marqueur_zkt='D';
update temp_PATTERN_capital_change set  number_securities_after_change=NULL where marqueur_zkt='D';
--6

--marqueur_zkr
--select distinct instrument_id from  temp_PATTERN_capital_change where marqueur_zkr='D';
update temp_PATTERN_capital_change set  
repurchase_start_date=NULL,
repurchase_end_date=NULL,
repurchase_currency_code=NULL,
repurchase_max_amount=NULL,
repurchase_max_amount_pct=NULL,
repurchase_max_number_securities=NULL
where marqueur_zkt='D';
-- 6

--marqueur_txn
update temp_PATTERN_capital_change set additional_remarks=NULL where marqueur_txn='D';
--9

-- nettoyage des lignes sans informations
select count(*) from temp_PATTERN_capital_change
where marqueur_zaa=NULL AND marqueur_zke=NULL AND marqueur_zkk=NULL AND marqueur_zka=NULL
AND marqueur_zkt=NULL AND marqueur_zkr=NULL;

delete from temp_PATTERN_capital_change where 
marqueur_zaa=NULL AND 
marqueur_zke=NULL AND 
marqueur_zkk=NULL AND 
marqueur_zka=NULL AND 
marqueur_zkt=NULL AND 
marqueur_zkr=NULL 
;


-- supprimer les variables inutiles
alter table temp_PATTERN_capital_change 
drop column sequential_number,
drop column single_message_id, drop column message_type_code, drop column message_status_code,
drop column marqueur_zaa, drop column marqueur_gej, drop column marqueur_mgg,drop column marqueur_mga,
drop column marqueur_vak,drop column marqueur_zke, drop column marqueur_zka,drop column marqueur_zkk,
drop column marqueur_zkt,drop column marqueur_zkr,drop column marqueur_txn,drop column marqueur_tqu,
drop column date_extraction, drop column source_date;


GRANT SELECT ON temp_PATTERN_capital_change TO GROUP group_edifact;
--ALTER TABLE temp_PATTERN_capital_change RENAME TO temp_202001_ost_capital_change;

--delete from temp_202001_ost_capital_change where code_ch=1183542 and code_ost=403 and date_ost='2014-04-21' and date_effective is null;


ALTER TABLE temp_PATTERN_capital_change ADD PRIMARY KEY (instrument_id,event_id,subevent_id,initial_entry_date);
