/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_transformation ;
create table temp_PATTERN_transformation  as
select distinct on (instrument_id,event_id,subevent_id,before_transform_instrument_id,initial_entry_date) *
from PATTERN_transformation
order by instrument_id,event_id,subevent_id,before_transform_instrument_id,initial_entry_date,date_extraction desc, 
case marqueur_zaa
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END,
	case marqueur_vai2
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 
	when 'I' then 5 END;

-- 29591



/*Etape 2*/

-- marqueur_mgg
--select * from  temp_PATTERN_transformation  where marqueur_zaa='D';
delete from temp_PATTERN_transformation  where marqueur_zaa='D';
-- 1185

-- message_type_code
--select * from  temp_PATTERN_transformation  where message_type_code=3;
delete from temp_PATTERN_transformation  where message_type_code=3;
-- 0

--marqueur_gej
--select count(*) from  temp_PATTERN_transformation where marqueur_gej='D';
update temp_PATTERN_transformation  set 
company_id=NULL
where marqueur_gej='D';
--0

-- marqueur_zte
--select * from  temp_PATTERN_transformation  where marqueur_zte='D';
update temp_PATTERN_transformation  set 
transformation_type_code=NULL,
record_date=NULL,
effective_date=NULL,
substitute_effective_date_flag=NULL,
settlement_type_code=NULL,
conversion_exercice_instr_flag=NULL,
charges_flag=NULL,
validation_type_code=NULL
where marqueur_zte='D';
-- 0

-- marqueur_ztf
--select count(*) from  temp_PATTERN_transformation where marqueur_ztf='D';
update temp_PATTERN_transformation  set 
submission_start_date=NULL,
submission_end_date=NULL,
submission_time=NULL,
submission_place=NULL,
submission_deadline_date=NULL
where marqueur_ztf='D';
--13

--marqueur_xvt
--select count(*) from  temp_PATTERN_transformation where marqueur_xvt='D';
update temp_PATTERN_transformation  set 
date_settlement_type_code=NULL,
marqueur_xvu=NULL,
settlement_start_date=NULL,
settlement_end_date=NULL,
settlement_place=NULL
where marqueur_xvt='D';
--205

--marqueur_gef
--select count(*) from  temp_PATTERN_transformation where marqueur_gef='D';
update temp_PATTERN_transformation  set 
stock_exchange_id=NULL,
marqueur_gek=NULL,
stock_exchange_name=NULL
 where marqueur_gef='D';
--0

--marqueur_lri
--select count(*) from  temp_PATTERN_transformation where marqueur_lri='D';
update temp_PATTERN_transformation  set 
domicile_code=NULL
where marqueur_lri='D';
--0

--marqueur_xvv
--select count(*) from  temp_PATTERN_transformation where marqueur_xvv='D';
update temp_PATTERN_transformation  set 
additional_date_description=NULL
where marqueur_xvv='D';
--2

--marqueur_zta
--select count(*) from  temp_PATTERN_transformation where marqueur_zta='D';
update temp_PATTERN_transformation  set 
subsequent_settlement_type_code=NULL,
subsequent_settlement_end_date=NULL,
subsequent_settlement_currency_code=NULL,
subsequent_settlement_amount=NULL,
subsequent_setttlement_payment_date=NULL
 where marqueur_zta='D';
--0

--marqueur_zto
--select count(*) from  temp_PATTERN_transformation where marqueur_zto='D';
update temp_PATTERN_transformation  set 
legally_invalid_date=NULL,
compensation_cashable_end_date=NULL,
compensation_currency_code=NULL,
compensation_amount=NULL,
compensation_payment_date=NULL,
compensation_coupon_number=NULL,
compensation_free_of_charge_end_date=NULL
 where marqueur_zto='D';
--0

--marqueur_vao
--select count(*) from  temp_PATTERN_transformation where marqueur_vao='D';
update temp_PATTERN_transformation  set 
old_instrument_short_name=NULL
where marqueur_vao='D';
--17

--marqueur_van
--select count(*) from  temp_PATTERN_transformation where marqueur_van='D';
update temp_PATTERN_transformation  set 
new_instrument_short_name=NULL
where marqueur_van='D';
--0


--marqueur_gei
--select count(*) from  temp_PATTERN_transformation where marqueur_gei='D';
update temp_PATTERN_transformation  set 
new_company_id=NULL
where marqueur_gei='D';
--0

--marqueur_gek2
--select count(*) from  temp_PATTERN_transformation where marqueur_gek2='D';
update temp_PATTERN_transformation  set 
new_company_short_name=NULL
where marqueur_gek2='D';
--0

--marqueur_ztg
--select count(*) from  temp_PATTERN_transformation where marqueur_ztg='D';
update temp_PATTERN_transformation  set 
withdrawal_end_date=NULL,
withdrawal_end_time=NULL,
withdrawal_end_place=NULL,
withdrawal_deadline_period_date=NULL,
withdrawal_deadline_period_time=NULL
 where marqueur_ztg='D';
--3

--marqueur_vai2
--select count(*) from  temp_PATTERN_transformation where marqueur_vai2='D';
update temp_PATTERN_transformation  set 
before_scheme=NULL,
before_transform_instrument_id=NULL,
before_transform_instrument_short_name=NULL
where marqueur_vai2='D';

--1085

--marqueur_ztl
--select count(*) from  temp_PATTERN_transformation where marqueur_ztl='D';
update temp_PATTERN_transformation  set 
before_transform_amount=NULL,
before_transform_numerator=NULL,
before_transform_denominator=NULL,
before_transform_amount_unit_code=NULL,
before_transform_min_per_holder=NULL,
before_transform_min_per_holder_unit_code=NULL,
before_transform_max_per_holder=NULL,
before_transform_max_per_holder_unit_code=NULL,
nominal_debt_instr_currency_code=NULL
where marqueur_ztl='D';

--0
--marqueur_ztk
--select count(*) from  temp_PATTERN_transformation where marqueur_ztk='D';
update temp_PATTERN_transformation  set 
before_transform_nominal_currency_code=NULL,
before_transform_nominal_amount=NULL,
before_transform_partly_paid_amount=NULL
where marqueur_ztk='D';
--22

--marqueur_zth
--select count(*) from  temp_PATTERN_transformation where marqueur_zth='D';
update temp_PATTERN_transformation  set 
offering_min_limit_number=NULL,
offering_min_limit_unit_code=NULL,
offering_min_limit_quotation_type_code=NULL,
offering_max_limit_number=NULL,
offering_max_limit_unit_code=NULL,
offering_max_limit_quotation_type_code=NULL,
tendered_instruments_number=NULL,
tendered_instruments_unit_code=NULL,
tendered_instruments_quotation_type_code=NULL,
accepted_instruments_number=NULL,
accepted_instruments_unit_code=NULL,
accepted_instruments_quotation_type_code=NULL,
offered_price_currency_code=NULL,
offered_min_price=NULL,
offered_max_price=NULL,
offered_range_price_unit_code=NULL,
offered_range_price_quotation_type_code=NULL
where marqueur_zth='D';
--20

--marqueur_ztp
--select count(*) from  temp_PATTERN_transformation where marqueur_ztp='D';
update temp_PATTERN_transformation  set 
before_fraction_settlement_type_code=NULL
where marqueur_ztp='D';
--0

--marqueur_txz1
update temp_PATTERN_transformation  set before_transform_description=NULL where marqueur_txz1='D';
--188

--marqueur_txn
update temp_PATTERN_transformation  set additional_remarks=NULL where marqueur_txn='D';
--611

--marqueur_ztt
update temp_PATTERN_transformation  set
selection_period_start_date=NULL,
selection_period_end_date=NULL
where marqueur_ztt='D';
--3

--marqueur_ztn
update temp_PATTERN_transformation  set
group_number=NULL,
default_group_flag=NULL
where marqueur_ztn='D';
--698

--marqueur_ztr
--select count(*) from  temp_PATTERN_transformation where marqueur_ztr='D';
update temp_PATTERN_transformation  set 
after_transform_amount=NULL,
after_transform_numerator=NULL,
after_transform_denominator=NULL,
after_transform_amount_unit_code=NULL,
after_transform_type_amount_code=NULL,
after_transform_pay_date=NULL,
after_transform_interest_accrued_date=NULL,
after_transform_cash_equivalent=NULL
where marqueur_ztr='D';
--116

--marqueur_zvb
--select count(*) from  temp_PATTERN_transformation where marqueur_zvb='D';
update temp_PATTERN_transformation  set 
early_tender_payment_type_code=NULL,
early_tender_payment_currency_code=NULL,
early_tender_payment_amount=NULL,
early_tender_payment_amount_unit_code=NULL,
early_tender_payment_amount_quotation_type=NULL
where marqueur_zvb='D';
--0

--marqueur_ztk2
--select count(*) from  temp_PATTERN_transformation where marqueur_ztk2='D';
update temp_PATTERN_transformation  set 
after_transform_nominal_currency_code=NULL,
after_transform_nominal_amount=NULL,
after_transform_partly_paid_amount=NULL
where marqueur_ztk2='D';
--25

--marqueur_zts
--select count(*) from  temp_PATTERN_transformation where marqueur_zts='D';
update temp_PATTERN_transformation  set 
charges_currency_code=NULL,
charges_per_instrument_amount=NULL,
free_of_charge_until_date=NULL
where marqueur_zts='D';
--0

--marqueur_ztp2
--select count(*) from  temp_PATTERN_transformation where marqueur_ztp2='D';
update temp_PATTERN_transformation  set 
after_fraction_settlement_type_code=NULL
where marqueur_ztp2='D';
--22

--marqueur_ztq
--select count(*) from  temp_PATTERN_transformation where marqueur_ztq='D';
update temp_PATTERN_transformation  set 
max_select_limit_quantity=NULL,
max_select_limit_unit_code=NULL,
max_select_limit_quotation_type_code=NULL
where marqueur_ztq='D';
--0

--marqueur_txz
--select count(*) from  temp_PATTERN_transformation where marqueur_txz='D';
update temp_PATTERN_transformation  set 
after_transform_description=NULL
where marqueur_txz='D';
--101

-- supprimer les variables inutiles
alter table temp_PATTERN_transformation  
drop column sequential_number,
drop column message_type_code, drop column message_status_code,
drop column marqueur_mgg,drop column marqueur_mga,drop column marqueur_vak,drop column marqueur_zaa,drop column marqueur_gej,
drop column marqueur_zte,drop column marqueur_ztf,drop column marqueur_xvt,drop column marqueur_xvu,drop column marqueur_gef,
drop column marqueur_gek,drop column marqueur_lri,drop column marqueur_xvv,drop column marqueur_zta,drop column marqueur_zto,
drop column marqueur_vao,drop column marqueur_van,drop column marqueur_gei,drop column marqueur_gek2,drop column marqueur_ztg,
drop column marqueur_vai2,drop column marqueur_ztl,drop column marqueur_ztk,
drop column marqueur_zth,drop column marqueur_ztp,drop column marqueur_txz1,
drop column marqueur_ztn,drop column marqueur_vai3,drop column marqueur_ztr,
drop column marqueur_zvb,drop column marqueur_ztk2,drop column marqueur_zts,
drop column marqueur_ztp2,drop column marqueur_ztq,drop column marqueur_txz,
drop column marqueur_ztt,drop column  marqueur_tqu,drop column date_extraction, drop column source_date;

GRANT SELECT ON temp_PATTERN_transformation  TO GROUP group_edifact;

ALTER TABLE temp_PATTERN_transformation  ADD PRIMARY KEY (instrument_id,event_id,subevent_id, initial_entry_date,id);
