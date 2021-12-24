/* INSERT USER */
/* UserID = 10 까지 있는 것을 확인할 수 있습니다. */
SELECT * FROM USER;

/* User 를 Insert 하면, */
INSERT INTO USER
	(AccountStr, DateCreated)
	VALUES ('newidid', date(now()));

/* 하나의 User instance가 증가한 것을 확인할 수 있씁니다. */
SELECT * FROM USER;

/* SAVE Last inserted UserID. */
SET @newuserid = LAST_INSERT_ID();
SELECT @newuserid;

/* Call procedure : User_Character Table에 insert하는 procedure 호출 */
/* 새로 가입된 계정이 두 개의 게임 캐릭터를 만들었다고 가정. */
/* 하나는 class가 3(Archer)이고, 하나는 class가 2(Magician) 이다. */
CALL UserCharacter_Insert(@newuserid, 3);
CALL UserCharacter_Insert(@newuserid, 2);

/* CharacterID = 18, 19 인 2개의 instance가 insert되었음을 확인할 수 있다. */
SELECT * FROM USER_CHARACTER;

/* DELETE USER_CHARACTER */
DELETE FROM USER_CHARACTER
	WHERE CharacterID = LAST_INSERT_ID();

/* 가장 마지막에 insert된, (@newuserid, 2)가 삭제되고 처음에 insert된 (@newuserid, 3)은 아직 삭제되지 않음. */
SELECT * FROM USER_CHARACTER;

/* DELETE USER */
/* 아래의 Query를 수행하고 USER_CHARACTER를 확인하면, 새로 만들었던 Character가 Cascade Delete됨을 확인할수 있다. */
DELETE FROM USER
	WHERE UserID = @newuserid;
SELECT * FROM USER;

/* CharacterID = 18 이 Cascade delete됨 */
SELECT * FROM USER_CHARACTER;
    
/* INSERT LIMITATION : NUMBER EXCEEDED */
SELECT * FROM USER_CHARACTER WHERE UserID = 1;

/* UserID = 1 의 User는 이미 6개의 Character를 가지고 있으므로 Insert가 일어나지 않는다. */
CALL UserCharacter_Insert(1, 2);
SELECT * FROM USER_CHARACTER WHERE UserID = 1;


/* New Connection : Insert CHARACTER_CONNECT, And By trigger, Update USER_CHARACTER */
/* UserID = 9 의 최근 Connect 상태 */
SELECT CharacterID, UserID, UserCharacterID, LastConnectDate, LastPlayedHour
FROM USER_CHARACTER
WHERE UserID = 9;

/* UserID = 9의 캐릭터인 CharacterID = 17의 Character가, 오늘 3시간 동안 접속했다고 가정. */
INSERT INTO CHARACTER_CONNECT
	(CharacterID, ConnectTime, ConnectDate)
    VALUES (17, 3, date(now()));

/* CHARACTER_CONNECT 의 TRIGGER에 의해, USER_CHARACTER의 LastConnectDate와 LastPlayedHour가 변경되었다. */
SELECT CharacterID, UserID, UserCharacterID, LastConnectDate, LastPlayedHour
FROM USER_CHARACTER
WHERE UserID = 9;
    
/* Character를 삭제할 경우, CHARACTER_CONNECT에 기록된 Character의 접속내역과 결제내역은 모두 삭제된다. */
/* 접속 내역 */
SELECT USER_CHARACTER.UserID, USER_CHARACTER.UserCharacterID, 
		CHARACTER_CONNECT.CharacterID, CHARACTER_CONNECT.ConnectDate, CHARACTER_CONNECT.ConnectTime
FROM USER_CHARACTER, CHARACTER_CONNECT
WHERE USER_CHARACTER.UserID = 9 
AND USER_CHARACTER.CharacterID = CHARACTER_CONNECT.CharacterID;

/* 결제 내역 */
SELECT USER_CHARACTER.UserID, USER_CHARACTER.UserCharacterID,
		CHARACTER_PAYMENT.CharacterID, CHARACTER_PAYMENT.PayDate, CHARACTER_PAYMENT.Payment
FROM USER_CHARACTER, CHARACTER_PAYMENT
WHERE USER_CHARACTER.UserID = 9
AND USER_CHARACTER.CharacterID = CHARACTER_PAYMENT.CharacterID;

/* UserID = 9 의 2번째 캐릭터 삭제(CharacterID = 17) */
DELETE FROM USER_CHARACTER
	WHERE UserID = 9 AND UserCharacterID = 2;
/* 캐릭터 삭제 이후 삭제 쿼리 위의 쿼리를 실행하여 접속 내역, 결제 내역을 다시 확인하면, Cascade delete된 것을 확인할 수 있음 */


/* Dungeon Check */
/* Dungeon에는 3명, 또는 4명의 게임 캐릭터가 입장할 수 있다. */
/* (3명이 입장할 때는 dungeoncheck()의 마지막 parameter에 0을 전달한다.) */
/* 그러나 함께 입장하는 게임 캐릭터들이 균형 잡힌 조합이어야만 입장할 수 있다는 조건이 있다. (Procedure DungeonCheck) */
SELECT UserID, CharacterID, ClassID
FROM USER_CHARACTER;

/* 3 people, CharacterID = 1, 7, 13 */
/* 아래 쿼리를 실행해 보면 Worrier, Magician, Archer의 조합으로, 균형잡혔다고 볼 수 있음. */
SELECT USER_CHARACTER.UserID, USER_CHARACTER.CharacterID, CLASS.ClassID, CLASS.ClassDesc
FROM USER_CHARACTER, CLASS
WHERE USER_CHARACTER.ClassID = CLASS.ClassID
AND CharacterID IN (1, 7, 13);

/* DungeonCheck 결과는 OK이다.*/
CALL dungeoncheck(3, 1, 7, 13, 0);

/* 4 people, CharacterID = 1, 7, 13, 16 */
/* 마찬가지로 아래 쿼리를 실행해 보면, 균형잡힌 조합이다. */
SELECT USER_CHARACTER.UserID, USER_CHARACTER.CharacterID, CLASS.ClassID, CLASS.ClassDesc
FROM USER_CHARACTER, CLASS
WHERE USER_CHARACTER.ClassID = CLASS.ClassID
AND CharacterID IN (1, 7, 13, 16);

/* DungeonCheck 결과는 OK이다. */
CALL dungeoncheck(4, 1, 7, 13, 16);

/* 4 people, CharacterID = 1, 8, 9, 14 */
/* 최대 인원이 입장하려 하지만, 모든 캐릭터의 class가 worrier이다. */
SELECT USER_CHARACTER.UserID, USER_CHARACTER.CharacterID, CLASS.ClassID, CLASS.ClassDesc
FROM USER_CHARACTER, CLASS
WHERE USER_CHARACTER.ClassID = CLASS.ClassID
AND CharacterID IN (1, 8, 9, 14);

/* Dungeoncheck 결과는 Rejected이다. */
CALL dungeoncheck(4, 1, 8, 9, 14);


/* RFM Analysis */
/* 얼마나 최근에 게임에 Connect했는지, 얼마나 게임을 오랫동안 플레이했는지, 그리고 얼마나 많은 결제를 했는지에 대한 분석 */
/* 각각의 지표를 R, F, M으로 하여, User가 얼마나 게임을 즐기고, 얼마나 많은 결제를 했는지에 따라 5개의 Group으로 나누었다. */
CALL computeUser_RFM();
SELECT * FROM USER_RFM ORDER BY UserID;