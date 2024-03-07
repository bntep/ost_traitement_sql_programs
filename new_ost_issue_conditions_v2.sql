/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_issue_conditions;
create table temp_PATTERN_issue_conditions as
select distinct on (instrument_id,initial_entry_date,restrictions_domicile_code) *
from PATTERN_issue_conditions
order by instrument_id,initial_entry_date,restrictions_domicile_code,date_extraction desc, 
case marqueur_mgg
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;
-- 
-- 27979


/*Etape 2*/

-- marqueur mgg
--select count(*) from  temp_PATTERN_issue_conditions where marqueur_mgg='D';
delete from temp_PATTERN_issue_conditions where marqueur_mgg='D';
-- 14

-- message_type_code
--select count(*) from  temp_PATTERN_issue_conditions where message_type_code=3;
delete from temp_PATTERN_issue_conditions where message_type_code=3;
-- 0

-- marqueur_emt
update temp_PATTERN_issue_conditions set 
issue_type_code=NULL,
marqueur_emo=NULL,
ipo_filing_date=NULL,
ipo_timing_type_code=NULL,
ipo_date=NULL
where marqueur_emt='D';
--0

-- marqueur_ema
update temp_PATTERN_issue_conditions set 
issue_status_code=NULL,
subscription_type_code=NULL,
subscription_start_date=NULL,
subscription_end_date=NULL,
subscription_time=NULL,
subscription_location=NULL,
payment_type_for_issue_code=NULL,
accrued_interest_start_date=NULL,
accrued_interest_currency_code=NULL,
accrued_interest_amount=NULL
where marqueur_ema='D';
--0

-- marqueur_pos
update temp_PATTERN_issue_conditions set 
investor_group_code=NULL,
public_offering_valid_from=NULL,
public_offering_valid_to=NULL,
marqueur_lri=NULL,
public_offering_domicile_code=NULL
where marqueur_pos='D';
--0

-- marqueur_eme
update temp_PATTERN_issue_conditions set 
contact_issuer=NULL,
contact_issuer_phone=NULL,
contact_issuer_fax=NULL,
contact_issuer_email=NULL
where marqueur_pos='D';
--0

-- marqueur_ems
update temp_PATTERN_issue_conditions set 
issuance_original_denomination=NULL
where marqueur_ems='D';
--3

-- marqueur_emp
update temp_PATTERN_issue_conditions set 
issue_price_currency_code=NULL,
issue_price=NULL,
issue_price_unit_code=NULL,
isssue_price_quotation_type_code=NULL,
issue_price_fixing_date=NULL,
issue_price_quantity=NULL,
price_range_currency_code=NULL,
price_range_minimum_amount=NULL,
price_range_maximum_amount=NULL,
price_range_amount_unit_code=NULL,
price_range_amount_quotation_type_code=NULL,
tax_amount=NULL,
tax_type_code=NULL,
tax_amount_currency_code=NULL,
tax_amount_unit_code=NULL,
tax_amount_quotation_type_code=NULL
where marqueur_emp='D';
--6

-- marqueur_emb
update temp_PATTERN_issue_conditions set 
bond_issue_amount=NULL,
bond_issue_amount_currency_code=NULL,
bond_issue_amount_code=NULL,
number_of_issue_instruments=NULL
where marqueur_emb='D';
--14

-- marqueur_emr
update temp_PATTERN_issue_conditions set 
restrictions_domicile_code=NULL
where marqueur_emr='D';
--6

-- marqueur_emq
update temp_PATTERN_issue_conditions set 
restriction_country_start_date=NULL,
restriction_country_end_date=NULL,
restriction_max_amount=NULL,
restriction_max_amount_pct=NULL,
restriction_max_amount_currency_code=NULL,
restriction_min_amount=NULL,
restriction_min_amount_pct=NULL,
restriction_min_amount_currency_code=NULL
where marqueur_emq='D';
--0

-- marqueur_emk
update temp_PATTERN_issue_conditions set 
listing_first_trading_date=NULL,
listing_last_trading_date=NULL
where marqueur_emk='D';
--46

-- marqueur_gei
update temp_PATTERN_issue_conditions set 
issue_stock_exchange_id=NULL
where marqueur_gei='D';
--34

-- marqueur_wai
update temp_PATTERN_issue_conditions set 
issue_stock_exchange_currency_code=NULL
where marqueur_wai='D';
--34

--marqueur_txn
--select count(*) from  temp_PATTERN_issue_conditions where marqueur_txn='D';
update temp_PATTERN_issue_conditions set additional_remarks=NULL where marqueur_txn='D';
--40

-- nettoyage
delete from  temp_PATTERN_issue_conditions where marqueur_emt is null and marqueur_emo is null and marqueur_ema is null and marqueur_eme is null
and marqueur_ems is null and marqueur_emp is null and marqueur_emb is null 
and marqueur_emr is null and marqueur_emq is null and marqueur_emk  is null;

--16115
-- supprimer les variables inutiles
alter table temp_PATTERN_issue_conditions 
drop column sequential_number,
drop column message_type_code, drop column message_status_code,drop column date_extraction, 
drop column marqueur_mgg,drop column marqueur_mga,drop column marqueur_vak,drop column marqueur_emt,drop column marqueur_emo,
drop column marqueur_ema,drop column marqueur_pos,drop column marqueur_lri,drop column marqueur_eme,drop column marqueur_ems,
drop column marqueur_emp,drop column marqueur_emb,drop column marqueur_txn,drop column marqueur_emr,drop column marqueur_emq,
drop column marqueur_gei,drop column marqueur_wai,drop column marqueur_emk;


GRANT SELECT ON temp_PATTERN_issue_conditions TO GROUP group_edifact;

ALTER TABLE temp_PATTERN_issue_conditions ADD PRIMARY KEY (instrument_id,initial_entry_date,id);
