/* User ID 기준으로 DateCreated, LastConnectDate, 두 날짜 차이인 DayGap을 보여주는 View */
CREATE VIEW UserLastConnectView AS
	SELECT USER.UserID, USER.DateCreated, MAX(USER_CHARACTER.LastConnectDate) AS LastConnectDate,
			COUNT(USER_CHARACTER.LastConnectDate) AS ConnectFreq, 
            SUM(CHARACTER_CONNECT.ConnectTime) AS TotalConnectTime,
			DATEDIFF(MAX(USER_CHARACTER.LastConnectDate), USER.DateCreated) as DayGap
	FROM (USER LEFT JOIN USER_CHARACTER 
		  ON USER.UserID = USER_CHARACTER.UserID) LEFT JOIN CHARACTER_CONNECT
		  ON USER_CHARACTER.CharacterID = CHARACTER_CONNECT.CharacterID
	GROUP BY USER.UserID;


/* User ID 기준으로 현재까지의 현금 결제 횟수와 합계를 보여주는 View */
CREATE VIEW UserTotalPaymentView AS
	SELECT USER.UserID, COUNT(Payment) AS PayCount, SUM(CHARACTER_PAYMENT.Payment) AS TotalPayment
	FROM (USER LEFT JOIN USER_CHARACTER
		  ON USER.UserID = USER_CHARACTER.UserID) LEFT JOIN CHARACTER_PAYMENT
		  ON USER_CHARACTER.CharacterID = CHARACTER_PAYMENT.CharacterID
	GROUP BY USER.UserID;