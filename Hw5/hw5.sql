-- 1. Создайте представление с произвольным SELECT-запросом из прошлых уроков [CREATE VIEW] (вывести друзей друзей пользователя с id=1)
-- 2. Выведите данные, используя написанное представление [SELECT]
-- 3. Удалите представление [DROP VIEW]
--*4. Сколько новостей (записей в таблице media) у каждого пользователя? Вывести поля: news_count (количество новостей), 
--   user_id (номер пользователя), user_email (email пользователя). Попробовать решить с помощью CTE или с помощью обычного JOIN.


-- 1.
create view friends_of_friends as
select * 
from friend_requests left join users
on initiator_user_id = id
where status = "approved" 
and initiator_user_id in ((select target_user_id 
						from  friend_requests
						where initiator_user_id = 1 and status = "approved"
						union
						select initiator_user_id 
						from  friend_requests
						where target_user_id = 1 and status = "approved"))
union
select * 
from friend_requests left join users
on initiator_user_id = id
where status = "approved" 
and target_user_id in  ((select target_user_id 
						from  friend_requests
						where initiator_user_id = 1 and status = "approved"
						union
						select initiator_user_id 
						from  friend_requests
						where target_user_id = 1 and status = "approved"));
                
-- 2.
select * from friends_of_friends;

-- 3.
drop view friends_of_friends; 

-- 4.
SELECT user_id, email as user_email, count(*) as news_count
FROM media join users
on user_id = users.id
group by user_id;