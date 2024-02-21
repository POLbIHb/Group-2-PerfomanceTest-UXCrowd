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
delete from interview_item
delete from customer_orders where id in (select id from orders where orders_type='INTERVIEW');
delete from orders where orders_type='INTERVIEW'
