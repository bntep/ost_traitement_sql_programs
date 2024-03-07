/**
3 étapes :
1 on crée une table sans doublon en gardant la ligne prioritaire en fonction 
du marqueur (voir tri specifique)
2 : on gère les marqueurs
3 : on supprime les variables inutiles
**/

/*Etape 1*/

drop table if exists temp_PATTERN_meeting;
create table temp_PATTERN_meeting as
select distinct on (company_id,event_id,initial_entry_date,meeting_participant_type_code,items_on_agenda_code) *
from PATTERN_meeting
order by company_id,event_id,initial_entry_date,meeting_participant_type_code,items_on_agenda_code,date_extraction desc, 
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
--select count(*) from  temp_PATTERN_meeting where marqueur_mgg='D';
delete from temp_PATTERN_meeting where marqueur_mgg='D';
-- 281

-- message_type_code
--select count(*) from  temp_PATTERN_meeting where message_type_code=3;
delete from temp_PATTERN_meeting where message_type_code=3;
-- 58

-- marqueur_iga
--select count(*) from  temp_PATTERN_meeting where marqueur_iga='D';
update temp_PATTERN_meeting set 
meeting_type_code=NULL,
meeting_status_code=NULL,
meeting_date=NULL,
meeting_time=NULL,
meeting_place=NULL
where marqueur_iga='D';
-- 0

-- marqueur_tuz
update temp_PATTERN_meeting set meeting_description=NULL
where marqueur_tuz='D';
--3

-- marqueur_igk
update temp_PATTERN_meeting set 
meeting_participant_type_code=NULL
where marqueur_igk='D';
--650

--marqueur_txn
--select count(*) from  temp_PATTERN_meeting where marqueur_txn='D';
update temp_PATTERN_meeting set additional_remarks=NULL where marqueur_txn='D';
--197

-- marqueur_igt
--select count(*) from  temp_PATTERN_meeting_agenda where marqueur_igt='D';
update temp_PATTERN_meeting set
items_on_agenda_code=NULL,
marqueur_txz=NULL,
agenda_description=NULL
where marqueur_igt='D';
--12

-- marqueur_txz
--select count(*) from  temp_PATTERN_meeting_agenda where marqueur_txz='D';
update temp_PATTERN_meeting set 
agenda_description=NULL
where marqueur_txz='D';
--47

--marqueur_igs
--select count(*) from  temp_PATTERN_meeting where marqueur_igs='D';
update temp_PATTERN_meeting set 
proxies_flag=NULL,
proxy_statement=NULL,
last_submission_date_for_proxy=NULL,
registered_shares_recording_date=NULL,
bearer_shares_recording_date=NULL
where marqueur_igs='D';
--189

--marqueur_igp
--select count(*) from  temp_PATTERN_meeting where marqueur_igp='D';
update temp_PATTERN_meeting set
deposited_start_date=NULL,
deposited_end_date=NULL
where marqueur_igp='D';
--0

--marqueur_tzz
--select count(*) from  temp_PATTERN_meeting where marqueur_tzz='D';
update temp_PATTERN_meeting set
depository_description=NULL
where marqueur_tzz='D';
--15


-- nettoyage des lignes sans informations
delete from temp_PATTERN_meeting where 
marqueur_iga=NULL 
;
--0

-- supprimer les variables inutiles
alter table temp_PATTERN_meeting 
drop column sequential_number,
drop column message_type_code, drop column message_status_code,drop column date_extraction, drop column source_date,
drop column  marqueur_mgg,drop column  marqueur_mga,drop column  marqueur_gek,drop column  marqueur_iga,drop column  marqueur_igt,
drop column  marqueur_txz,drop column  marqueur_tuz,drop column  marqueur_txn,drop column  marqueur_igs,drop column  marqueur_igk,
drop column  marqueur_tyz,drop column  marqueur_igp,drop column  marqueur_tzz,drop column  marqueur_tqu;


GRANT SELECT ON temp_PATTERN_meeting TO GROUP group_edifact;

--ALTER TABLE temp_PATTERN_meeting RENAME TO temp_202001_ost_capital_change;

ALTER TABLE temp_PATTERN_meeting ADD PRIMARY KEY (company_id,event_id,initial_entry_date,id);
