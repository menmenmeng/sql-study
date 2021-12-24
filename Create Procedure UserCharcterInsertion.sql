DELIMITER //
CREATE PROCEDURE UserCharacter_Insert
	(
		IN varUserID		INT,
        IN varClassID		INT
	)
block:BEGIN
	DECLARE varRowcount				INT;
    DECLARE varUserCharacterID		INT;
    
    SELECT COUNT(*) INTO varRowcount
    FROM USER_CHARACTER
    WHERE UserID = varUserID;
    
    IF (varRowcount = 6) THEN
		SELECT 'Insertion Rejected: Too many Characters.' AS ErrorMessage;
		ROLLBACK;
		LEAVE block;
	
    ELSEIF (varRowcount = 0) THEN
		SET varUserCharacterID = 1;
	
    ELSE
		SELECT UserCharacterID+1 INTO varUserCharacterID
		FROM USER_CHARACTER
		WHERE UserID = varUserID
		ORDER BY UserCharacterID DESC
		LIMIT 1;
    
    END IF;
    
    INSERT INTO USER_CHARACTER
		(UserID, UserCharacterID, ClassID, DateCreated)
        VALUES (varUserID, varUserCharacterID, varClassID, date(now()));
    SELECT 'Insertion Succeeded.' AS SuccessMessage;    
END
//