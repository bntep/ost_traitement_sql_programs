/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_tax;
create table temp_PATTERN_tax as
select distinct on (instrument_id,initial_entry_date,tax_raising_country_code,tax_date,tax_date_type_code,tax_resident_code,tax_amount_type_code,tax_category_code,tax_currency_code) *
from PATTERN_tax
order by instrument_id,initial_entry_date,tax_raising_country_code,tax_date,tax_date_type_code,tax_resident_code,tax_amount_type_code,tax_category_code,tax_currency_code,date_extraction desc, 
case marqueur_mgg
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;
-- 
-- 87719



/*Etape 2*/

-- marqueur mgg
--select count(*) from  temp_PATTERN_tax where marqueur_mgg='D';
delete from temp_PATTERN_tax where marqueur_mgg='D';
-- 1984

-- message_type_code
--select count(*) from  temp_PATTERN_tax where message_type_code=3;
delete from temp_PATTERN_tax where message_type_code=3;
-- 21

-- marqueur_lri
update temp_PATTERN_tax SET
tax_raising_country_code=NULL
where marqueur_lri='D';
--659

-- marqueur_xsa
update temp_PATTERN_tax SET
tax_date_type_code=NULL,
tax_date=NULL,
tax_start_date=NULL,
tax_end_date=NULL
where marqueur_xsa='D';
--5238

-- marqueur_xsb
update temp_PATTERN_tax SET
tax_category_code=NULL
where marqueur_xsb='D';
--18

-- marqueur_xsc
update temp_PATTERN_tax SET
tax_resident_code=NULL
where marqueur_xsc='D';
--18

-- marqueur_xse
update temp_PATTERN_tax SET
tax_amount_type_code=NULL,
tax_currency_code=NULL,
tax_amount=NULL,
tax_amount_quotation_type_code=NULL
where marqueur_xse='D';
--18

-- marqueur_ref
update temp_PATTERN_tax set 
ref_scheme_id=NULL,
ref_instrument_id=NULL,
ref_message_item_code=NULL,
ref_initial_entry_date=NULL,
ref_sequential_number=NULL
where marqueur_ref='D';
--36

-- marqueur_xsr
update temp_PATTERN_tax set 
ref_cash_scheme_id=NULL,
ref_cash_flow_id=NULL,
ref_cash_flow_instrument_id=NULL,
ref_cash_flow_message_item_code=NULL,
ref_cash_flow_initial_entry_date=NULL,
ref_cash_flow_sequential_number=NULL
where marqueur_xsr='D';
--0

--marqueur_txn
--select count(*) from  temp_PATTERN_tax where marqueur_txn='D';
update temp_PATTERN_tax set additional_remarks=NULL where marqueur_txn='D';
--3

-- supprimer les variables inutiles
alter table temp_PATTERN_tax 
drop column sequential_number,
drop column message_type_code, drop column message_status_code,drop column date_extraction, drop column source_date,
drop column marqueur_mgg,drop column marqueur_mga,drop column marqueur_vak,
drop column marqueur_xsb,drop column marqueur_xsc,drop column   marqueur_xse,
drop column marqueur_lri,drop column marqueur_xsa,
drop column marqueur_txn,drop column marqueur_ref,drop column marqueur_xsr,drop column marqueur_tqu;


GRANT SELECT ON temp_PATTERN_tax TO GROUP group_edifact;

ALTER TABLE temp_PATTERN_tax ADD PRIMARY KEY (instrument_id,initial_entry_date,id);

