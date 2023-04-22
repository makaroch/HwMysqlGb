-- 1. Подсчитать количество групп, в которые вступил каждый пользователь.
-- 2. Подсчитать количество пользователей в каждом сообществе.
-- 3. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
--    который больше всех общался с выбранным пользователем (написал ему сообщений).
-- 4. * Подсчитать общее количество лайков, которые получили пользователи младше 18 лет..
-- 5. * Определить кто больше поставил лайков (всего): мужчины или женщины.

-- 1.
SELECT user_id, count(*) as count_communities
FROM hw3_vk.users_communities
group by user_id;

-- видеть id пользователя конечно рикольно, но хотелось бы и самого пользователя
SELECT user_id, count(*) as count_communities, firstname, lastname, email, phone
FROM users_communities left join users
on user_id = id
group by user_id;

-- 2. просто добавил к выборке названия груп 
select UC.community_id, C.name, count(*) as count_user 
from users_communities as UC JOIN communities as C
on UC.community_id = C.id
group by community_id
order by community_id;
-- 3. пусть будет пользоватьтель с id = 1
select from_user_id, count(to_user_id) as count_messages, firstname, lastname, email, phone
from messages join users
on from_user_id = users.id
where to_user_id = 1
group by from_user_id
order by count(to_user_id) desc 
limit 1;

--4.
select count(*) as count_user
from likes join media
on likes.media_id = media.id
join profiles 
on media.user_id = profiles.user_id
where datediff(now(), birthday) < 18*365;

-- 5.

select gender, count(*)
from likes as L join profiles as  P
on L.user_id = P.user_id
group by gender
limit 1;