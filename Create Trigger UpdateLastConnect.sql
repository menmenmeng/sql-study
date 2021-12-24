DELIMITER //
CREATE TRIGGER After_CharacterConnectInsert_UpdateUserCharacter
AFTER INSERT ON CHARACTER_CONNECT
FOR EACH ROW

BEGIN
	DECLARE varCharacterID			INT;
    DECLARE varLastConnectDate		Date;
    DECLARE varLastPlayedTime		INT;
    
    SET varCharacterID = new.CharacterID;
    SET varLastConnectDate = new.ConnectDate;
    SET varLastPlayedTime = new.ConnectTime;
    
    UPDATE USER_CHARACTER
		SET LastConnectDate = varLastConnectDate,
			LastPlayedHour = varLastPlayedTime
		WHERE CharacterID = varCharacterID;

END
//
    