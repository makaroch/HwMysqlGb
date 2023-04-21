-- 1. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений
--    в алфавитном порядке. [ORDER BY]
-- 2. Выведите количество мужчин старше 35 лет [COUNT].
-- 3. Сколько заявок в друзья в каждом статусе? (таблица friend_requests) [GROUP BY]
-- 4.* Выведите номер пользователя, который отправил больше всех заявок в друзья (таблица friend_requests) [LIMIT].
-- 5.* Выведите названия и номера групп, имена которых состоят из 5 символов [LIKE].

--1. 
SELECT DISTINCT firstname
FROM users 
ORDER BY firstname;
-- 2.
SELECT COUNT(*) AS количество_мужчин
FROM profiles
WHERE DATEDIFF(NOW(), birthday) >= (365 * 35);
-- 3.
SELECT target_user_id, COUNT(*) as количество_заявок
FROM friend_requests
GROUP BY target_user_id;
-- 4.
SELECT initiator_user_id, COUNT(*) as количество_заявок
FROM friend_requests
GROUP BY initiator_user_id
ORDER BY initiator_user_id
LIMIT 1;
-- 5.
SELECT id, name 
FROM communities
WHERE name LIKE '_____'; 