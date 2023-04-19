/* 1. Создать БД vk, исполнив скрипт _vk_db_creation.sql (в материалах к уроку)
2. Написать скрипт, добавляющий в созданную БД vk 2-3 новые таблицы (с перечнем полей, 
указанием индексов и внешних ключей) (CREATE TABLE)
3. Заполнить 2 таблицы БД vk данными (по 10 записей в каждой таблице) (INSERT)

4.* Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных 
(поле is_active = true). При необходимости предварительно добавить такое поле в 
таблицу profiles со значением по умолчанию = false (или 0) (ALTER TABLE + UPDATE)
5.* Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней) (DELETE)*/

2. 
CREATE TABLE calls( --  решил добавить таблицу для вк звонков, с историей звонков
    id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
    to_user_id BIGINT UNSIGNED NOT NULL,
    start_call DATETIME DEFAULT NOW(), 
    end_call DATETIME ON UPDATE NOW(),

    FOREIGN KEY (from_user_id) REFERENCES users(id),
    FOREIGN KEY (to_user_id) REFERENCES users(id) 
);
-- насколько помню за использование вк звонков были какие-то плюшки, значит нужно хранить кто сколько звонил
CREATE TABLE duration_calls( 
    id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL, 
    count_call INT DEFAULT 0, -- кол-во звонков пользователя 
    duration_call INT DEFAULT 0, -- общая продолжительность 

    FOREIGN KEY (user_id) REFERENCES users(id)
);


3. INSERT INTO users(firstname, lastname, email, password_hash, phone)
VALUES  ('Иван1', 'Иванов1','иванов1@ya.ru','xsqwer1', 111),
        ('Иван2', 'Иванов2','иванов2@ya.ru','xsqwer2', 222),
        ('Иван3', 'Иванов3','иванов3@ya.ru','xsqwer3', 333),
        ('Иван4', 'Иванов4','иванов4@ya.ru','xsqwer4', 444),
        ('Иван5', 'Иванов5','иванов5@ya.ru','xsqwer5', 555),
        ('Иван6', 'Иванов6','иванов6@ya.ru','xsqwer6', 666),
        ('Иван7', 'Иванов7','иванов7@ya.ru','xsqwer7', 777),
        ('Иван8', 'Иванов8','иванов8@ya.ru','xsqwer8', 888),
        ('Иван9', 'Иванов9','иванов9@ya.ru','xsqwer9', 999),
        ('Иван10', 'Иванов10','иванов10@ya.ru','xsqwer10', 000);

INSERT INTO profiles(user_id, gender, birthday, hometown)
VALUES  (1, 'М', '2022-12-05', 'Moskow'),
        (2, 'М', '2021-12-05', 'Moskow'),
        (3, 'М', '2020-12-05', 'Moskow'),
        (4, 'М', '2019-12-05', 'Moskow'),
        (5, 'М', '2018-12-05', 'Moskow'),
        (6, 'М', '2005-12-05', 'Moskow'),
        (7, 'М', '2004-12-05', 'Moskow'),
        (8, 'М', '2003-12-05', 'Moskow'),
        (9, 'М', '2002-12-05', 'Moskow'),
        (10, 'М', '2000-12-05', 'Moskow');
        
4.
ALTER TABLE profiles 
ADD COLUMN is_active BOOL DEFAULT false;

UPDATE profiles 
SET is_active = true
WHERE DATEDIFF(NOW(), birthday) >= (365 * 18);

5.
DELETE FROM messages
WHERE DATEDIFF(NOW(), created_at) < 0;