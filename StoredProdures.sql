DROP PROCEDURE IF EXISTS `sp_store_user`;
DELIMITER //
CREATE PROCEDURE `sp_store_user`(
	IN _userName VARCHAR(50),
	IN _email VARCHAR(256),
    IN _loginPassword VARCHAR(256),
    IN _completeName VARCHAR(60),
    IN _phone VARCHAR(13),
    IN _personTypeId INT,
    IN _document VARCHAR(14),
	OUT _userId INT)
BEGIN
	DECLARE lastAddedUserId INT DEFAULT 0;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
		BEGIN
			ROLLBACK;
		END;
        
    START TRANSACTION;
		INSERT INTO users(userName, email, loginPassword)
			VALUES (_userName, _email, _loginPassword);
		SET lastAddedUserId = LAST_INSERT_ID();
		INSERT INTO userInfo(userId, completeName, phone, personTypeId, document)
			VALUES (lastAddedUserId, _completeName, _phone, _personTypeId, _document); 
		SET _userId = lastAddedUserId;
	COMMIT;
END//
DELIMITER ;
CALL sp_store_user('MechAAV','gabrields.net@gmail.com','123456','Gabriel David dos Santos','1190000000',0,'00000000000', @userId);  SELECT @userId;
select * from users;
SELECT * FROM userinfo;