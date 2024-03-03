--изменение пароля 
update users set password = '$2a$10$lDyjp2iJ2HhWwrDHI5q37O32CIVqENgrztOCxGyCoJqT7TbxzXX92' where date_trunc('DAY',created_date)=date_trunc('DAY',now()) 

--деактивация тестов без степов
update  orders
set status='COMPLETED'
where id not in (select o.id from step s join orders o on s.order_id=o.id)

--очистка таблицы interview_item от тяжеловесных json для 3го скрипта
DELETE FROM interview_item

--очистка базы от "черновых заказаов" для 4го скрипта
delete from video where tester_task_id   in (select id from tester_task where participant_group_id  in (select id from participant_group pg where order_id in (select id from orders where orders_type='INTERVIEW')));
delete from system_info_snapshot where tester_task_id in (select id from tester_task where participant_group_id  in (select id from participant_group pg where order_id in (select id from orders where orders_type='INTERVIEW')));
delete from profile_snapshot where tester_task_id in (select id from tester_task where participant_group_id  in (select id from participant_group pg where order_id in (select id from orders where orders_type='INTERVIEW')));
delete from tester_task where participant_group_id  in (select id from participant_group pg where order_id in (select id from orders where orders_type='INTERVIEW'));
delete from part_group_educations where participant_group_id in (select id from participant_group pg where order_id in (select id from orders where orders_type='INTERVIEW'));
delete from part_group_social_statuses where participant_group_id in (select id from participant_group pg where order_id in (select id from orders where orders_type='INTERVIEW'));
delete from participant_group where id in (select id from orders where orders_type='INTERVIEW');
delete from participant_group where id in (select id from orders where orders_type='INTERVIEW');
delete from interview_item;
delete from customer_orders where id in (select id from orders where orders_type='INTERVIEW');
delete from orders where orders_type='INTERVIEW';

select distinct customeror0_.id as id1_22_, customeror0_1_.created as created2_22_, customeror0_1_.updated as updated3_22_, customeror0_1_.version as version4_22_, customeror0_1_.customer_id as custome13_22_, customeror0_1_.introduction 
as introduc5_22_, customeror0_1_.pre_screener_intro as pre_scre6_22_, customeror0_1_.pre_screener_outro as pre_scre7_22_, customeror0_1_.start_date as start_da8_22_, customeror0_1_.status as status9_22_, customeror0_1_.target_site 
as target_10_22_, customeror0_1_.tariff_plan_id as tariff_14_22_, customeror0_1_.test_type as test_ty11_22_, customeror0_1_.orders_type as orders_12_22_, customeror0_.app_name as app_name1_8_, customeror0_.consent_document_id 
as consent_9_8_, customeror0_.payment as payment10_8_, customeror0_.test_title as test_tit2_8_, customeror0_.tester_type as tester_t3_8_, customeror0_.their_fc_testers_count as their_fc4_8_, customeror0_.their_testers_count 
as their_te5_8_, customeror0_.url_completed_order as url_comp6_8_, customeror0_.url_completed_task as url_comp7_8_ from customer_orders customeror0_ inner join orders customeror0_1_ on customeror0_.id=customeror0_1_.id 
cross join customer customer24_ inner join users customer24_1_ on customer24_.id=customer24_1_.id where customeror0_1_.customer_id=customer24_.id and (customeror0_.id in (select customeror1_.id from customer_orders customeror1_ 
inner join orders customeror1_1_ on customeror1_.id=customeror1_1_.id where (select count(distinct testertask3_.id) from customer_orders customeror2_ inner join tester_task testertask3_ on customeror2_.id=testertask3_.orders_id 
where (testertask3_.pre_screener_status='A' or testertask3_.pre_screener_status='B') and testertask3_.tester_id<>401357 and testertask3_.pre_screener_created>='V' 
and customeror1_.id=customeror2_.id)<((select sum(cast(participan5_.count as int8)) from customer_orders customeror4_ inner join participant_group participan5_ on customeror4_.id=participan5_.order_id 

where customeror1_.id=customeror4_.id)-(select count(distinct testertask7_.id) from customer_orders customeror6_ inner join tester_task testertask7_ on customeror6_.id=testertask7_.orders_id where (testertask7_.status in ('COMPLETED', 'CANCELLED')) 
and customeror1_.id=customeror6_.id))*$39) or exists (select testertask8_.id from tester_task testertask8_ where testertask8_.pre_screener_created>='G' and (testertask8_.pre_screener_status='D' or testertask8_.pre_screener_status='E') 
and testertask8_.tester_id=401357)) and (customeror0_.id not in  (select customeror9_.id from customer_orders customeror9_ inner join orders customeror9_1_ on customeror9_.id=customeror9_1_.id inner join tester_task testertask10_ 
on customeror9_.id=testertask10_.orders_id where testertask10_.tester_id=401357 and (testertask10_.pre_screener_status is not null) and (testertask10_.pre_screener_status=$12 or testertask10_.pre_screener_status=$13 
and (testertask10_.status in ($14 , $15))))) and (select count(customeror11_.id) from customer_orders customeror11_ inner join orders customeror11_1_ on customeror11_.id=customeror11_1_.id inner join participant_group participan12_ 
on customeror11_.id=participan12_.order_id cross join customer customer14_ where customeror11_1_.customer_id=customer14_.id and participan12_.count>cast((select count(distinct testertask13_.id) from tester_task testertask13_ 
where testertask13_.participant_group_id=participan12_.id and testertask13_.status<>$16 and testertask13_.status<>$17 and (testertask13_.status<>$18 or testertask13_.tester_id<>$19)) as int4) 
and customeror0_.id=participan12_.order_id and (customer14_.block_past_tester=$20 or customeror11_1_.customer_id not in  (select pasttester15_.customer_id from past_tester_lock pasttester15_ cross join customer customer16_ 
inner join users customer16_1_ on customer16_.id=customer16_1_.id where pasttester15_.customer_id=customer16_.id and pasttester15_.tester_id=$21 and customer16_.block_past_tester=$22)) and (participan12_.gender=$23 or participan12_.gender=$24) and (participan12_.family_status=$25 or participan12_.family_status=$26) and (participan12_.childrens=$27 or participan12_.childrens=$28) and ($29 in (select socialstat18_.social_status_id 
from part_group_social_statuses socialstat18_ where participan12_.id=socialstat18_.participant_group_id) or $30 in (select socialstat19_.social_status_id from part_group_social_statuses socialstat19_ 
where participan12_.id=socialstat19_.participant_group_id) or (select count(socialstat25_.participant_group_id) from part_group_social_statuses socialstat25_ where participan12_.id = socialstat25_.participant_group_id)=$40) 
and ($31 in (select educations20_.education_id from part_group_educations educations20_ where participan12_.id=educations20_.participant_group_id) or $32 in (select educations21_.education_id from part_group_educations educations21_ 
where participan12_.id=educations21_.participant_group_id) or (select count(educations26_.participant_group_id) from part_group_educations educations26_ where participan12_.id = educations26_.participant_group_id)=$41) 
and (participan12_.min_age<=$42 and participan12_.max_age>=$43 or cast($44 as int8)<=$45 and participan12_.max_age>=$46) and (participan12_.household_income_min<=$47 and participan12_.household_income_max>=$48 
or participan12_.household_income_max>$49 and participan12_.household_income_max=$50))<>$51 and  not (exists (select customeror22_.id from customer_orders customeror22_ inner join orders customeror22_1_ 
on customeror22_.id=customeror22_1_.id inner join tester_task testertask23_ on customeror22_.id=testertask23_.orders_id where customeror0_.id=testertask23_.orders_id and testertask23_.tester_id=$33 and (testertask23_.status 
in ($34 , $35)))) and customeror0_.tester_type=$36 and customer24_1_.locale=$37 and customeror0_1_.status=$38