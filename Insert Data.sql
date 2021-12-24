/* INSERT INTO USER TABLE */
INSERT INTO USER VALUES (1, 'sinatrasinatra', '2021-07-04');
INSERT INTO USER VALUES (2, 'armstrong111', '2021-07-21');
INSERT INTO USER VALUES (3, 'colkingnat', '2021-08-28');
INSERT INTO USER VALUES (4, '20bennett', '2021-08-29');
INSERT INTO USER VALUES (5, 'jamesbobby', '2021-09-03');
INSERT INTO USER VALUES (6, '4_play', '2021-09-09');
INSERT INTO USER VALUES (7, 'GeorgeBenson', '2021-09-20');
INSERT INTO USER VALUES (8, 'aluminumeola', '2021-10-01');
INSERT INTO USER VALUES (9, 'mason0409', '2021-10-11');
INSERT INTO USER VALUES (10, 'jackson251', '2021-10-13');

/* INSERT INTO CLASS TABLE */
INSERT INTO CLASS VALUES (1, 'Worrier', 10, 10, 1, 1, 1, 10, 5);
INSERT INTO CLASS VALUES (2, 'Magician', 1, 1, 10, 10, 3, 3, 10);
INSERT INTO CLASS VALUES (3, 'Archer', 5, 4, 5, 4, 10, 5, 5);
INSERT INTO CLASS VALUES (4, 'Blacksmith', 4, 4, 4, 4, 10, 8, 4);

/* INSERT INTO USER_CHARACTER TABLE */
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (1, 1, 1, 1, '2021-07-04');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (2, 1, 2, 4, '2021-07-06');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (3, 1, 3, 2, '2021-09-09');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (4, 1, 4, 3, '2021-10-11');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (5, 1, 5, 4, '2021-12-10');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (6, 1, 6, 4, '2021-12-10');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (7, 2, 1, 2, '2021-07-21');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (8, 2, 2, 1, '2021-11-25');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (9, 3, 1, 1, '2021-08-28');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (10, 4, 1, 1, '2021-08-29');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (11, 5, 1, 1, '2021-09-03');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (12, 5, 2, 2, '2021-10-25');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (13, 6, 1, 3, '2021-09-09');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (14, 7, 1, 1, '2021-09-20');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (15, 8, 1, 3, '2021-10-01');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (16, 9, 1, 4, '2021-10-11');
INSERT INTO USER_CHARACTER
	(CharacterID, UserID, UserCharacterID, ClassID, DateCreated)
	VALUES (17, 9, 2, 3, '2021-10-14');

/* 이후 Navigator에서 Table Data Import Wizard 기능을 이용해 csv 파일을 불러오기 한다. */


