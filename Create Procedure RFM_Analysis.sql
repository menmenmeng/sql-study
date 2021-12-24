DELIMITER //

CREATE PROCEDURE computeUser_R ()

BEGIN
	
    DECLARE varUserID				INT;
    DECLARE varLastConnectDate	 	Date;
    DECLARE varLastConnectDayGap	INT;
    DECLARE varUserNum				INT;
    DECLARE crank					INT DEFAULT 1;  
	DECLARE done					INT DEFAULT 0;
    DECLARE CNTCursor				CURSOR FOR
									SELECT UserID, LastConnectDate
									FROM UserLastConnectView
									ORDER BY LastConnectDate DESC;

    DECLARE continue				HANDLER FOR NOT FOUND SET done = 1;

    
    TRUNCATE TABLE USER_R;
    
    SELECT COUNT(*) INTO varUserNum FROM USER;
    
    OPEN CNTCursor;
		REPEAT
		FETCH CNTCursor INTO varUserID, varLastConnectDate;
			IF NOT done THEN
				IF varLastConnectDate IS NOT NULL THEN
					SET varLastConnectDayGap = DATEDIFF(date(now()), varLastConnectDate);
					INSERT INTO USER_R (UserID, LastConnectDayGap, UserRank)
							VALUES (varUserID, varLastConnectDayGap, crank/varUserNum);
				ELSE
					INSERT INTO USER_R (UserID, LastConnectDayGap, UserRank)
							VALUES (varUserID, NULL, 1.0);
				END IF;
				SET crank = crank + 1;
			END IF;
		UNTIL done END REPEAT;
	CLOSE CNTCursor;

    UPDATE USER_R SET UserRank = 5 WHERE UserRank > 0.8 AND UserRank <= 1;        
	UPDATE USER_R SET UserRank = 1 WHERE UserRank <= 0.2;
    UPDATE USER_R SET UserRank = 2 WHERE UserRank > 0.2 AND UserRank <= 0.4;
    UPDATE USER_R SET UserRank = 3 WHERE UserRank > 0.4 AND UserRank <= 0.6;
    UPDATE USER_R SET UserRank = 4 WHERE UserRank > 0.6 AND UserRank <= 0.8;

END
//


DELIMITER //

CREATE PROCEDURE computeUser_F ()

BEGIN
	
    DECLARE varUserID				INT;
    DECLARE varTotalConnectTime		INT;
    DECLARE varUserNum				INT;
    DECLARE crank					INT DEFAULT 1;  
	DECLARE done					INT DEFAULT 0;
    DECLARE CNTCursor				CURSOR FOR
									SELECT UserID, TotalConnectTime
									FROM UserLastConnectView
									ORDER BY TotalConnectTime DESC;

    DECLARE continue				HANDLER FOR NOT FOUND SET done = 1;

    
    TRUNCATE TABLE USER_F;
    
    SELECT COUNT(*) INTO varUserNum FROM USER;
    
    OPEN CNTCursor;
		REPEAT
		FETCH CNTCursor INTO varUserID, varTotalConnectTime;
			IF NOT done THEN
				IF varTotalConnectTime IS NOT NULL THEN
					INSERT INTO USER_F (UserID, TotalConnectTime, UserRank)
							VALUES (varUserID, varTotalConnectTime, crank/varUserNum);
				ELSE
					INSERT INTO USER_F (UserID, TotalConnectTime, UserRank)
							VALUES (varUserID, 0, 1.0);
				END IF;
				SET crank = crank + 1;
			END IF;
		UNTIL done END REPEAT;
	CLOSE CNTCursor;

    UPDATE USER_F SET UserRank = 5 WHERE UserRank > 0.8 AND UserRank <= 1;        
	UPDATE USER_F SET UserRank = 1 WHERE UserRank <= 0.2;
    UPDATE USER_F SET UserRank = 2 WHERE UserRank > 0.2 AND UserRank <= 0.4;
    UPDATE USER_F SET UserRank = 3 WHERE UserRank > 0.4 AND UserRank <= 0.6;
    UPDATE USER_F SET UserRank = 4 WHERE UserRank > 0.6 AND UserRank <= 0.8;

END
//


DELIMITER //

CREATE PROCEDURE computeUser_M ()

BEGIN
	
    DECLARE varUserID				INT;
    DECLARE varTotalPayment			INT;
    DECLARE varUserNum				INT;
    DECLARE crank					INT DEFAULT 1;  
	DECLARE done					INT DEFAULT 0;
    DECLARE PMTCursor				CURSOR FOR
									SELECT UserID, TotalPayment
									FROM UserTotalPaymentView
									ORDER BY TotalPayment DESC;

    DECLARE continue				HANDLER FOR NOT FOUND SET done = 1;

    
    TRUNCATE TABLE USER_M;
    
    SELECT COUNT(*) INTO varUserNum FROM USER;
    
    OPEN PMTCursor;
		REPEAT
		FETCH PMTCursor INTO varUserID, varTotalPayment;
			IF NOT done THEN
				IF varTotalPayment IS NOT NULL THEN
					INSERT INTO USER_M (UserID, TotalPayment, UserRank)
							VALUES (varUserID, varTotalPayment, crank/varUserNum);
				ELSE
					INSERT INTO USER_M (UserID, TotalPayment, UserRank)
							VALUES (varUserID, 0, 1.0);
				END IF;
				SET crank = crank + 1;
			END IF;
		UNTIL done END REPEAT;
	CLOSE PMTCursor;

    UPDATE USER_M SET UserRank = 5 WHERE UserRank > 0.8 AND UserRank <= 1;        
	UPDATE USER_M SET UserRank = 1 WHERE UserRank <= 0.2;
    UPDATE USER_M SET UserRank = 2 WHERE UserRank > 0.2 AND UserRank <= 0.4;
    UPDATE USER_M SET UserRank = 3 WHERE UserRank > 0.4 AND UserRank <= 0.6;
    UPDATE USER_M SET UserRank = 4 WHERE UserRank > 0.6 AND UserRank <= 0.8;

END
//

DELIMITER //
CREATE PROCEDURE computeUser_RFM()
	
BEGIN
	CALL computeUser_R();
	CALL computeUser_F();
    CALL computeUser_M();
    
    TRUNCATE TABLE USER_RFM;
    
    INSERT INTO USER_RFM
		(UserID, R_Rank, F_Rank, M_Rank)
		SELECT USER_R.UserID AS UserID, USER_R.UserRank AS R_Rank,
				USER_F.UserRank AS F_Rank, USER_M.UserRank AS M_Rank
                FROM USER_R, USER_F, USER_M
                WHERE USER_R.UserID = USER_F.UserID
                AND USER_F.UserID = USER_M.UserID;
		

END
//