/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_listing_event ;
create table temp_PATTERN_listing_event  as
select distinct on (instrument_id,initial_entry_date,listing_stock_exchange_id,delisting_stock_exchange_id,suspension_stock_exchange_id,
change_of_symbol_stock_exchange_id,change_of_calculation_stock_exchange_id) *
from PATTERN_listing_event
order by instrument_id,initial_entry_date,listing_stock_exchange_id,delisting_stock_exchange_id,suspension_stock_exchange_id,
change_of_symbol_stock_exchange_id,change_of_calculation_stock_exchange_id,date_extraction desc, 
case marqueur_mgg
	when 'D' then 1
	when 'M' then 2
	when 'E' then 3
	when 'N' then 4
	when 'S' then 5 END;

-- 71641



/*Etape 2*/

-- marqueur_mgg
--select * from  temp_PATTERN_listing_event  where marqueur_zaa='D';
delete from temp_PATTERN_listing_event  where marqueur_mgg='D';
-- 5678

-- message_type_code
--select * from  temp_PATTERN_listing_event  where message_type_code=3;
delete from temp_PATTERN_listing_event  where message_type_code=3;
-- 0

-- marqueur_geg
--select * from  temp_PATTERN_listing_event  where marqueur_geg='D';
update temp_PATTERN_listing_event set
listing_stock_exchange_id=NULL
where marqueur_geg='D';
-- 362

-- marqueur_gek
--select * from  temp_PATTERN_listing_event  where marqueur_gek='D';
update temp_PATTERN_listing_event set
listing_stock_exchange_short_name=NULL
where marqueur_gek='D';
-- 362

-- marqueur_huk
--select * from  temp_PATTERN_listing_event  where marqueur_='huk';
update temp_PATTERN_listing_event set
listing_first_trading_date=NULL
where marqueur_huk='D';
-- 362

-- marqueur_geh
--select * from  temp_PATTERN_listing_event  where marqueur_geh='D';
update temp_PATTERN_listing_event SET
delisting_stock_exchange_id=NULL
where marqueur_geh='D';
-- 782

-- marqueur_gek2
--select * from  temp_PATTERN_listing_event  where marqueur_gek2='D';
update temp_PATTERN_listing_event set
delisting_stock_exchange_short_name=NULL
where marqueur_gek2='D';
-- 362

-- marqueur_hul
--select * from  temp_PATTERN_listing_event  where marqueur_='hul';
update temp_PATTERN_listing_event set
last_trading_date=NULL
where marqueur_hul='D';
-- 362

-- marqueur_gei
--select * from  temp_PATTERN_listing_event  where marqueur_gei='D';
update temp_PATTERN_listing_event set 
suspension_stock_exchange_id=NULL
where marqueur_gei='D';
-- 8121

-- marqueur_gek3
--select * from  temp_PATTERN_listing_event  where marqueur_gek3='D';
update temp_PATTERN_listing_event set
suspension_stock_exchange_short_name=NULL
where marqueur_gek3='D';
-- 362

-- marqueur_hus
--select * from  temp_PATTERN_listing_event  where marqueur_='hus';
update temp_PATTERN_listing_event set
suspension_start_date=NULL,
suspension_end_date=NULL,
suspension_start_time=NULL,
suspension_end_time=NULL,
trading_resumption_date=NULL
where marqueur_hus='D';
-- 362



-- marqueur_geb
--select * from  temp_PATTERN_listing_event  where marqueur_geb='D';
update temp_PATTERN_listing_event set
change_of_symbol_stock_exchange_id=NULL
where marqueur_geb='D';
-- 0

-- marqueur_gek4
--select * from  temp_PATTERN_listing_event  where marqueur_gek4='D';
update temp_PATTERN_listing_event set
change_of_symbol_stock_exchange_name=NULL
where marqueur_gek4='D';
-- 362

-- marqueur_hub
--select * from  temp_PATTERN_listing_event  where marqueur_='hub';
update temp_PATTERN_listing_event set
trading_scheme_id=NULL,
old_symbol=NULL,
new_symbol=NULL,
new_symbol_effective_date=NULL
where marqueur_hub='D';
-- 362

-- marqueur_gej
--select * from  temp_PATTERN_listing_event  where marqueur_gej='D';
update temp_PATTERN_listing_event set
change_of_calculation_stock_exchange_id=NULL
where marqueur_gej='D';
-- 0

-- marqueur_gek5
--select * from  temp_PATTERN_listing_event  where marqueur_gek5='D';
update temp_PATTERN_listing_event set
change_of_calculation_stock_exchange_name=NULL
where marqueur_gek5='D';
-- 362

-- marqueur_hur
--select * from  temp_PATTERN_listing_event  where marqueur_='hur';
update temp_PATTERN_listing_event set
old_method_calculation=NULL,
new_method_calculation=NULL,
new_method_calculation_start_date=NULL
where marqueur_hur='D';
-- 362
--marqueur_txz
--select count(*) from  temp_PATTERN_listing_event where marqueur_txz='D';
update temp_PATTERN_listing_event  set 
description=NULL
where marqueur_txz='D';
--14

--marqueur_txn
--select count(*) from  temp_PATTERN_listing_event where marqueur_txn='D';
update temp_PATTERN_listing_event  set 
additional_remarks=NULL
where marqueur_txn='D';
--384


-- supprimer les variables inutiles
alter table temp_PATTERN_listing_event  
drop column sequential_number,
drop column message_type_code, drop column message_status_code,
drop column marqueur_geg,drop column marqueur_gek,drop column marqueur_huk,
drop column marqueur_geh,drop column marqueur_gek2,drop column marqueur_hul,
drop column marqueur_gei,drop column marqueur_gek3,drop column marqueur_hus,
drop column marqueur_geb,drop column marqueur_gek4,drop column marqueur_hub, 
drop column marqueur_gej,drop column marqueur_gek5,drop column marqueur_hur,
drop column marqueur_mgg, drop column marqueur_mga, drop column marqueur_vak,drop column marqueur_txz,drop column marqueur_txn,
drop column  marqueur_tqu,drop column date_extraction, drop column source_date;




GRANT SELECT ON temp_PATTERN_listing_event  TO GROUP group_edifact;


ALTER TABLE temp_PATTERN_listing_event  ADD PRIMARY KEY (instrument_id,initial_entry_date,id);

