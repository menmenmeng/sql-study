DELIMITER //
CREATE PROCEDURE DungeonCheck
	(
		IN varUserNum		INT,	# should be 3 or more.
		IN varCharID1		INT,
        IN varCharID2		INT,
        IN varCharID3		INT,
        IN varCharID4		INT
	)

block:BEGIN
	DECLARE 	TotalATK			INT;
	DECLARE		TotalDEF			INT;
    DECLARE     TotalMAT			INT;
    DECLARE     TotalMDF			INT;
    DECLARE   	TotalAVD			INT;
    DECLARE		TotalHP				INT;
    DECLARE     TotalMP				INT;
    
    DECLARE 	ATKLimit			INT DEFAULT 10;
    DECLARE		DEFLimit			INT DEFAULT 10;
    DECLARE		MATLimit			INT DEFAULT 10;
    DECLARE		MDFLimit			INT DEFAULT 10;
    DECLARE		AVDLimit			INT DEFAULT 10;
    DECLARE		HPLimit				INT DEFAULT 10;
    DECLARE		MPLimit				INT DEFAULT 10;
    
	IF (varUserNum < 3) THEN
		SELECT 'Need More User' AS ErrorMessage;
        ROLLBACK;
        LEAVE block;
	END IF;
    
    IF (varUserNum = 3) THEN
		SELECT 	SUM(CLASS.Attack), SUM(CLASS.Defence), SUM(CLASS.MagicAttck), SUM(CLASS.MagicDefense), 
				SUM(CLASS.Avoidability), SUM(CLASS.HealthPoint), SUM(CLASS.MagicPoint) 
		INTO	TotalATK, TotalDEF, TotalMAT, TotalMDF, TotalAVD, TotalHP, TotalMP
		FROM USER_CHARACTER, CLASS
        WHERE USER_CHARACTER.ClassID = CLASS.ClassID 
        AND USER_CHARACTER.CharacterID IN (varCharID1, varCharID2, varCharID3);
        
	ELSEIF (varUserNum = 4) THEN
		SELECT 	SUM(CLASS.Attack), SUM(CLASS.Defence), SUM(CLASS.MagicAttck), SUM(CLASS.MagicDefense), 
				SUM(CLASS.Avoidability), SUM(CLASS.HealthPoint), SUM(CLASS.MagicPoint) 
		INTO	TotalATK, TotalDEF, TotalMAT, TotalMDF, TotalAVD, TotalHP, TotalMP
		FROM USER_CHARACTER, CLASS
        WHERE USER_CHARACTER.ClassID = CLASS.ClassID 
        AND USER_CHARACTER.CharacterID IN (varCharID1, varCharID2, varCharID3, varCharID4);
	
    END IF;
    
    IF 	   ((TotalATK > ATKLimit) 
		AND (TotalDEF > DEFLimit)
        AND (TotalMAT > MATLimit)
        AND (TotalMDF > MDFLimit)
        AND (TotalAVD > AVDLimit)
        AND (TotalHP > HPLimit)
        AND (TotalMP > MPLimit)) THEN
		SELECT 'OK' AS Message;
	ELSE
		SELECT 'Rejected' AS Message;
	END IF;
END;
//
    