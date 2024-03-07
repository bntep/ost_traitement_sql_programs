/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_new_listing ;
create table temp_PATTERN_new_listing  as
select distinct on (instrument_id,stock_exchange_id,trading_currency_code,trading_unit_type_code,additionnal_date_type_code,first_trading_date) *, date_extraction as initial_entry_date 
from PATTERN_new_listing
order by instrument_id,stock_exchange_id,trading_currency_code,trading_unit_type_code,additionnal_date_type_code,first_trading_date,date_extraction desc, 
case marqueur_mga
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;

-- 296588

/*Etape 2*/

-- marqueur_mga
--select * from  temp_PATTERN_new_listing  where marqueur_zaa='D';
delete from temp_PATTERN_new_listing  where marqueur_mga='D';
-- 1

-- message_type_code
--select * from  temp_PATTERN_new_listing  where message_type_code=3;
delete from temp_PATTERN_new_listing  where message_type_code=3;
-- 71

-- marqueur_ofi
--select * from  temp_PATTERN_new_listing  where marqueur_ofi='D';
update  temp_PATTERN_new_listing  set
etd_underlying_instrument_id=NULL,
option_right_type_code=NULL,
etd_strike_price=NULL,
etd_expiry_date=NULL,
etd_underlying_identification=NULL,
etd_cashflow_identification=NULL,
etd_type_code=NULL,
etd_option_style_code=NULL,
etd_contract_size=NULL,
etd_multiplier_point_value=NULL,
etd_type_quantity_code=NULL,
ultimate_underlying_instrument_id=NULL,
expiry_date_allocation_type_code=NULL,
contract_year=NULL,
contract_month=NULL,
contract_day=NULL,
currency_strike_price_code=NULL,
exchange_version_number=NULL,
exchange_generation_number=NULL,
version_number_valid_date=NULL,
expiry_time=NULL,
contract_symbol_identification=NULL,
contract_frequency_code=NULL,
settlement_type_code=NULL,
settlement_date=NULL,
reference_stock_exchange_code=NULL,
contract_instrument_id=NULL,
original_strike_price=NULL,
contract_size_type_code=NULL,
contract_size_deliverable=NULL,
contract_type_code=NULL
where marqueur_ofi='D' ;
-- 0


--marqueur_vak
update temp_PATTERN_new_listing  set instrument_short_name=NULL
where marqueur_vak='D';
--7

--marqueur_gek
update temp_PATTERN_new_listing  set stock_exchange_short_name=NULL
where marqueur_gek='D';
--7

--marqueur_wai
update temp_PATTERN_new_listing  set trading_currency_code=NULL
where marqueur_wai='D';
--7

-- marqueur_hlo
--select * from  temp_PATTERN_new_listing  where marqueur_hlo='D';
update  temp_PATTERN_new_listing  set
old_instrument_id=NULL,
old_stock_exchange_id=NULL,
old_trading_currency_code=NULL,
old_reason_for_deletion_code=NULL
where marqueur_hlo='D' ;
-- 64

-- marqueur_hln
--select * from  temp_PATTERN_new_listing  where marqueur_hln='D';
update  temp_PATTERN_new_listing  set
new_instrument_id=NULL,
new_stock_exchange_id=NULL,
new_trading_currency_code=NULL,
new_reason_for_deletion_code=NULL
where marqueur_hln='D' ;
-- 64


-- marqueur_hxa
--select count(*) from  temp_PATTERN_new_listing where marqueur_hxa='D';
update temp_PATTERN_new_listing  set 
first_trading_date=NULL,
last_trading_date=NULL,
most_liquid_trading_place_flag=NULL,
listing_status_code=NULL,
settlement_currency_code=NULL,
trade_status_code=NULL,
last_trading_time=NULL,
listing_classification_code=NULL,
mor_euronext_flag=NULL,
primary_nav_source_flag=NULL,
delisting_date=NULL
where marqueur_hxa='D';
--0

-- marqueur_hxb
--select count(*) from  temp_PATTERN_new_listing where marqueur_hxb='D';
update temp_PATTERN_new_listing  set 
additionnal_date_type_code=NULL,
add_date_type_from=NULL,
add_date_type_time_from=NULL,
add_date_type_trans_datetime=NULL
where marqueur_hxb='D';
--0

-- marqueur_hlr
--select count(*) from  temp_PATTERN_new_listing where marqueur_hlr='D';
update temp_PATTERN_new_listing  set 
report_price_currency_code=NULL,
report_price_amount=NULL,
report_price_amount_unit_code=NULL,
report_price_amount_quotation_type_code=NULL,
volume_amount=NULL,
volume_amount_unit_code=NULL,
accrued_interest_calculation_type_code=NULL,
currency_trading_unit_code=NULL,
currency_trading_unit_measure_code=NULL
where marqueur_hlr='D';
--0

-- marqueur_hle
--select count(*) from  temp_PATTERN_new_listing where marqueur_hle='D';
update temp_PATTERN_new_listing  set 
trading_unit_type_code=NULL,
amount_of_trading_unit=NULL,
tick_size_display_factor=NULL,
tick_size_correction_factor=NULL
where marqueur_hle='D';
--0

--marqueur_txz
update temp_PATTERN_new_listing  set listing_description=NULL
where marqueur_txz='D';
--7

-- nettoyage des lignes sans informations

-- supprimer les variables inutiles
alter table temp_PATTERN_new_listing  
drop column message_type_code, drop column message_status_code,
drop column marqueur_gei,drop column marqueur_mga,drop column marqueur_ofi,drop column marqueur_vak,
drop column marqueur_gek,drop column marqueur_wai,drop column marqueur_hlo,drop column marqueur_hln,
drop column marqueur_hxa,drop column marqueur_hxb,drop column marqueur_hlr,drop column marqueur_hle,
drop column marqueur_txz,drop column marqueur_tqu,drop column date_extraction, drop column source_date;


GRANT SELECT ON temp_PATTERN_new_listing  TO GROUP group_edifact;

ALTER TABLE temp_PATTERN_new_listing  ADD PRIMARY KEY (initial_entry_date,instrument_id,stock_exchange_id,date_of_last_mutation,id);
