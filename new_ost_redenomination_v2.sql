/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_redenomination;
create table temp_PATTERN_redenomination as
select distinct on (instrument_id,initial_entry_date,redenomination_method_code,new_instrument_id,new_nominal_currency_code,
new_capital_currency_code) *
from PATTERN_redenomination
order by instrument_id,initial_entry_date,redenomination_method_code,new_instrument_id,new_nominal_currency_code,
new_capital_currency_code,date_extraction desc, 
case marqueur_mgg
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;

-- 95347
-- 97789




/*Etape 2*/

-- marqueur mgg
--select count(*) from  temp_PATTERN_redenomination where marqueur_mgg='D';
delete from temp_PATTERN_redenomination where marqueur_mgg='D';
-- 281

-- message_type_code
--select count(*) from  temp_PATTERN_redenomination where message_type_code=3;
delete from temp_PATTERN_redenomination where message_type_code=3;
-- 58

-- marqueur_zea
--select count(*) from  temp_PATTERN_redenomination where marqueur_zea='D';
update temp_PATTERN_redenomination set 
redenomination_method_code=NULL,
change_of_ch_flag=NULL,
meeting_date=NULL,
effective_date=NULL,
validation_type_code=NULL,
nominal_value_adj_with_compensation_flag=NULL,
fraction_method_code=NULL,
subject_to_withholding_tax_flag=NULL,
fictitious_nominal_currency_code=NULL,
fictitious_nominal_amount=NULL,
fictitious_nominal_amout_quotation_type_code=NULL,
fictitious_nominal_amount_quota=NULL,
fictitious_nominal_number_decimal=NULL,
rounding_flag=NULL,
next_interest_in_old_currency_flag=NULL,
changeover_on_interest_pay_date_flag=NULL,
interest_pay_date_on_changeover_flag=NULL
where marqueur_zea='D';
-- 0

-- marqueur_zen
--select count(*) from  temp_PATTERN_redenomination where marqueur_zen='D';
update temp_PATTERN_redenomination set 
old_nominal_currency_code=NULL,
old_nominal=NULL,
marqueur_zek=NULL,
old_capital_type_code=NULL,
old_capital_currency_code=NULL,
old_capital_amount=NULL,
old_number_of_securities=NULL
where marqueur_zen='D';
-- 0

-- marqueur_zek
--select count(*) from  temp_PATTERN_redenomination where marqueur_zek='D';
update temp_PATTERN_redenomination set 
old_capital_type_code=NULL,
old_capital_currency_code=NULL,
old_capital_amount=NULL,
old_number_of_securities=NULL
where marqueur_zek='D';
-- 0

-- marqueur_new_vai
update temp_PATTERN_redenomination set new_instrument_id=NULL
where marqueur_new_vai='D';
--3

-- marqueur_vak2
update temp_PATTERN_redenomination set new_instrument_short_name=NULL
where marqueur_vak2='D';
--3

-- marqueur_zev
--select count(*) from  temp_PATTERN_redenomination where marqueur_zev='D';
update temp_PATTERN_redenomination set 
ratio_number_of_old_securities=NULL,
ratio_number_of_new_securities=NULL
where marqueur_zev='D';

-- marqueur_zen2
--select count(*) from  temp_PATTERN_redenomination where marqueur_zen2='D';
update temp_PATTERN_redenomination set 
new_nominal_amount=NULL,
new_nominal_currency_code=NULL
where marqueur_zen2='D';


-- marqueur_zek2
--select count(*) from  temp_PATTERN_redenomination where marqueur_zek2='D';
update temp_PATTERN_redenomination set 
new_capital_type_code=NULL,
new_capital_amount=NULL,
new_capital_currency_code=NULL,
new_number_of_securities=NULL
where marqueur_zek2='D';


--marqueur_txn
--select count(*) from  temp_PATTERN_redenomination where marqueur_txn='D';
update temp_PATTERN_redenomination set additional_remarks=NULL where marqueur_txn='D';
--197


-- supprimer les variables inutiles
alter table temp_PATTERN_redenomination 
drop column sequential_number,
drop column message_type_code, drop column message_status_code,drop column date_extraction, drop column source_date,
drop column marqueur_mgg,drop column marqueur_mga,drop column marqueur_vak,drop column marqueur_zea,drop column marqueur_zen,
drop column marqueur_zek,drop column marqueur_new_vai,drop column marqueur_vak2,drop column marqueur_zev,drop column marqueur_zen2,
drop column marqueur_zek2,drop column marqueur_txn,drop column marqueur_tqu;



GRANT SELECT ON temp_PATTERN_redenomination TO GROUP group_edifact;

--ALTER TABLE temp_PATTERN_redenomination RENAME TO temp_202001_ost_capital_change;

ALTER TABLE temp_PATTERN_redenomination ADD PRIMARY KEY (instrument_id,initial_entry_date,id);
