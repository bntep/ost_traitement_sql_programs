/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_dividende ;
create table temp_PATTERN_dividende  as
select distinct on (instrument_id,cashflow_id,effective_payment_type_code, effective_payment_currency_code,initial_entry_date) *
from PATTERN_dividende
order by instrument_id,cashflow_id,effective_payment_type_code, effective_payment_currency_code,initial_entry_date,date_extraction desc, 
case marqueur_mgg
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;

-- 125848



/*Etape 2*/

-- marqueur_mgg
--select * from  temp_PATTERN_dividende  where marqueur_zaa='D';
delete from temp_PATTERN_dividende  where marqueur_mgg='D';
-- 1815

-- message_type_code
--select * from  temp_PATTERN_dividende  where message_type_code=3;
delete from temp_PATTERN_dividende  where message_type_code=3;
-- 2

-- marqueur_mgb
--select * from  temp_PATTERN_dividende  where marqueur_mgb='D';
update temp_PATTERN_dividende  set 
information_status_type_code=NULL,
information_status_code=NULL
where marqueur_mgb='D';
-- 11134

-- marqueur_xac
--select count(*) from  temp_PATTERN_dividende where marqueur_xac='D';
update temp_PATTERN_dividende  set 
ref_cashflow_id=NULL
where marqueur_xac='D';
--511

--marqueur_zaa
--select count(*) from  temp_PATTERN_dividende where marqueur_zaa='D';
update temp_PATTERN_dividende  set 
event_id=NULL,
subevent_id=NULL
where marqueur_zaa='D';
--0

--marqueur_gej
--select count(*) from  temp_PATTERN_dividende where marqueur_gej='D';
update temp_PATTERN_dividende  set 
company_id=NULL
where marqueur_gej='D';
--0

--marqueur_xcz
--select count(*) from  temp_PATTERN_dividende where marqueur_xcz='D';
update temp_PATTERN_dividende  set 
instr_allotment_type_code=NULL,
instr_distribution_way_code=NULL,
marqueur_gei=NULL,
stock_exchange_id=NULL,
stock_exchange_name=NULL
 where marqueur_xcz='D';
--0

--marqueur_gei
--select count(*) from  temp_PATTERN_dividende where marqueur_gei='D';
update temp_PATTERN_dividende  set 
stock_exchange_id=NULL,
stock_exchange_name=NULL
where marqueur_gei='D';
--569

--marqueur_xve
--select count(*) from  temp_PATTERN_dividende where marqueur_xve='D';
update temp_PATTERN_dividende  set 
execution_date=NULL,
execution_date_status=NULL,
adjustment_factor=NULL
 where marqueur_xve='D';
--506

--marqueur_txn
update temp_PATTERN_dividende  set additional_remarks=NULL where marqueur_txn='D';
--383

--marqueur_xaa
--select count(*) from  temp_PATTERN_dividende where marqueur_xaa='D';
update temp_PATTERN_dividende  set 
validation_type_code=NULL,
submission_date=NULL,
record_date=NULL,
payment_date=NULL,
settlement_type_code=NULL,
announcement_date=NULL
 where marqueur_xaa='D';
--104

--marqueur_xcp
--select count(*) from  temp_PATTERN_dividende where marqueur_xcp='D';
update temp_PATTERN_dividende  set 
fraction_settlement_type_code=NULL
 where marqueur_xcp='D';
--132

--marqueur_xca
--select count(*) from  temp_PATTERN_dividende where marqueur_xca='D';
update temp_PATTERN_dividende  set 
earning_period_start_date=NULL,
earning_period_end_date=NULL,
irregular_periods_code=NULL,
pro_rata_interest_rate=NULL
 where marqueur_xca='D';
--20

--marqueur_xcc
--select count(*) from  temp_PATTERN_dividende where marqueur_xcc='D';
update temp_PATTERN_dividende  set 
dividend_type_code=NULL,
dividend_policy_code=NULL,
overdue_dividend_amount=NULL,
latent_payment_status_code=NULL,
reinvestment_discount=NULL,
reinvestment_currency_code=NULL,
reinvestment_subscription_price=NULL,
reinvestment_subscription_price_quotation_type_code=NULL,
meeting_date=NULL,
allotment_letter_date=NULL,
gross_net_flag=NULL,
subscription_payment_date=NULL,
type_of_partial_dividend_code=NULL,
dividend_supplement_info_code=NULL,
free_of_charge_allocation_flag=NULL
where marqueur_xcc='D';
--19

--marqueur_xcn
--select count(*) from  temp_PATTERN_dividende where marqueur_xcn='D';
update temp_PATTERN_dividende  set 
distrib_in_kind_currency_code=NULL,
distrib_in_kind_amount=NULL,
distrib_in_kind_amount_quotation_type_code=NULL,
distrib_in_kind_validity_start_date=NULL,
distrib_in_kind_validity_end_date=NULL
where marqueur_xcn='D';
--0

--marqueur_txz
--select count(*) from  temp_PATTERN_dividende where marqueur_txz='D';
update temp_PATTERN_dividende  set 
distribution_in_kind_name=NULL
where marqueur_txz='D';
--0

--marqueur_tyz
--select count(*) from  temp_PATTERN_dividende where marqueur_tyz='D';
update temp_PATTERN_dividende  set 
distribution_in_kind_agent_name=NULL
where marqueur_tyz='D';
--0

--marqueur_xab
--select count(*) from  temp_PATTERN_dividende where marqueur_xab='D';
update temp_PATTERN_dividende  set 
cahflow_type_code=NULL,
cashflow_function_code=NULL,
payment_function_type_code=NULL,
cashflow_payment_type_code=NULL,
planned_payment_start_date=NULL,
planned_payment_end_date=NULL,
payment_status_code=NULL,
instrument_scheme=NULL,
instrumentid_or_currencycode=NULL,
planned_gross_payment_amount=NULL,
payment_quotation_type_code=NULL,
number_of_distributed_instruments=NULL,
number_of_initial_instruments=NULL,
payment_direction_code=NULL,
payment_due_date=NULL,
payment_floor_income=NULL,
payment_cap_income=NULL,
payment_floor_cap_quotation_type_code=NULL,
payment_validity_range_code=NULL,
distributed_payment_unit_code=NULL,
initial_payment_unit_code=NULL,
optional_dividend_flag=NULL,
depend_underlying_role_code=NULL
where marqueur_xab='D';
--0

--marqueur_vak1
--select count(*) from  temp_PATTERN_dividende where marqueur_vak1='D';
update temp_PATTERN_dividende  set 
underlying_instrument_name=NULL
where marqueur_vak1='D';

--marqueur_xch
--select count(*) from  temp_PATTERN_dividende where marqueur_xch='D';
update temp_PATTERN_dividende  set 
origin_payment_code=NULL,
origin_payment_currency_code=NULL,
origin_payment_amount=NULL,
origin_payment_amount_quotation_type_code=NULL
where marqueur_xch='D';
--17

--marqueur_xvb
--select count(*) from  temp_PATTERN_dividende_payment where marqueur_xvb='D';
update  temp_PATTERN_dividende SET
payment_amount_id=NULL,
effective_payment_type_code=NULL,
effective_payment_currency_code=NULL,
effective_payment_amount=NULL,
effective_payment_amount_quotation_type=NULL,
effective_payment_direction_code=NULL,
denomination_id=NULL,
denomination=NULL,
number_of_attached_coupon=NULL
where marqueur_xvb='D';
--1291

--marqueur_cou
--select count(*) from  temp_PATTERN_dividende where marqueur_cou='D';
update temp_PATTERN_dividende  set 
coupon_id=NULL,
coupon_type_code=NULL,
coupon_status_code=NULL,
coupon_printing_date=NULL,
coupon_validity_start_date=NULL,
coupon_validity_end_date=NULL,
coupon_number=NULL
where marqueur_cou='D';
--46

--marqueur_toy
--select count(*) from  temp_PATTERN_dividende where marqueur_toy='D';
update temp_PATTERN_dividende  set 
restrictions_description=NULL
where marqueur_toy='D';
--0

-- supprimer les variables inutiles
alter table temp_PATTERN_dividende  
drop column sequential_number,
drop column message_type_code, drop column message_status_code,
drop column  marqueur_mgg,drop column  marqueur_mga,drop column  marqueur_mgb,drop column  marqueur_xac,
drop column  marqueur_vak,drop column  marqueur_zaa,drop column  marqueur_gej,drop column  marqueur_xcz,
drop column  marqueur_gei,drop column  marqueur_xve,drop column  marqueur_txn,drop column  marqueur_xaa,
drop column  marqueur_xcp,drop column  marqueur_xca,drop column  marqueur_xcc,drop column  marqueur_xcn,
drop column  marqueur_txz,drop column  marqueur_tyz,drop column  marqueur_xab,drop column  marqueur_vak1,
drop column  marqueur_xch,drop column  marqueur_cou,drop column  marqueur_toy,drop column  marqueur_xvb, 
drop column  marqueur_tqu,drop column date_extraction, drop column source_date;


GRANT SELECT ON temp_PATTERN_dividende  TO GROUP group_edifact;

ALTER TABLE temp_PATTERN_dividende  ADD PRIMARY KEY (instrument_id,cashflow_id,initial_entry_date,id);
