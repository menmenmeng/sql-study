DELIMITER //
CREATE PROCEDURE prereq_LastRecordUpdate()
BEGIN
	DECLARE varCharID		INT;
	DECLARE done			INT 	DEFAULT 0;
	DECLARE UserCharCursor	CURSOR FOR
							SELECT CharacterID
							FROM USER_CHARACTER
							ORDER BY CharacterID;
    DECLARE continue		HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN UserCharCursor;
		REPEAT
        FETCH UserCharCursor INTO varCharID;
        IF NOT done THEN
			UPDATE USER_CHARACTER
				SET LastConnectDate = 	(SELECT ConnectDate
										FROM CHARACTER_CONNECT
										WHERE CharacterID = varCharID
										ORDER BY ConnectDate DESC
										LIMIT 1),
					LastPlayedHour = 	(SELECT ConnectTime
										FROM CHARACTER_CONNECT
										WHERE CharacterID = varCharID
										ORDER BY ConnectDate DESC
										LIMIT 1)
				WHERE CharacterID = varCharID;
			END IF;
		UNTIL done END REPEAT;
	CLOSE	UserCharCursor;
END
//
		