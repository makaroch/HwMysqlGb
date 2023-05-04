-- 1. Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk. Пользователь задается по id. 
--    Удалить нужно все сообщения, лайки, медиа записи, профиль и запись из таблицы users.
--    Функция должна возвращать номер пользователя.
-- 2 Предыдущую задачу решить с помощью процедуры и обернуть используемые команды в транзакцию внутри процедуры.
-- 1.
USE vk;
DROP FUNCTION IF EXISTS del_user;
DELIMITER //

CREATE FUNCTION del_user (_user_id int)
RETURNS int deterministic
BEGIN
	delete from profiles
    where user_id = _user_id;
    
	update media
    set user_id = 0
    where user_id = _user_id;
    
	delete from messages
    where from_user_id = _user_id or to_user_id = _user_id;
    
    delete from likes
    where user_id = _user_id;
    
    delete from friend_requests
	where  _user_id = initiator_user_id or _user_id = target_user_id;
    
    delete from users_communities
	where _user_id = user_id;
    
    delete from users
	where id = _user_id;
    
    return _user_id;
END//
DELIMITER ;

select del_user(7);

-- 2.
DELIMITER //
CREATE PROCEDURE del_us ()
BEGIN
  START TRANSACTION;
	delete from profiles
    where user_id = _user_id;
    
	update media
    set user_id = 0
    where user_id = _user_id;
    
	delete from messages
    where from_user_id = _user_id or to_user_id = _user_id;
    
    delete from likes
    where user_id = _user_id;
    
    delete from friend_requests
	where  _user_id = initiator_user_id or _user_id = target_user_id;
    
    delete from users_communities
	where _user_id = user_id;
    
    delete from users
	where id = _user_id;
COMMIT;
END //
DELIMITER ;