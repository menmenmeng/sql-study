CREATE TABLE USER (
	UserID					Int				NOT NULL,
    AccountStr				VarChar(100)	NOT NULL,
    DateCreated				Date			NOT NULL,
    CONSTRAINT			UserPK				PRIMARY KEY(UserID),
    CONSTRAINT			UserAK				UNIQUE(AccountStr)
    );
    /* User 가입하는 프로시져 만들기 */

CREATE TABLE CLASS ( /* 거의 변화 없는 table */
	ClassID					Int				NOT NULL,
    ClassDesc				VarChar(50)		NOT NULL,
    /*여기서 아래의 Attack ~ MagicPoint는 USER_CHARACTER와 다름. 여기는 디폴트값이고 위에는 유저가 성장시킨 것 */
    Attack					Int				NOT NULL,
    Defence					Int				NOT NULL,
    MagicAttck				Int				NOT NULL,
    MagicDefense			Int				NOT NULL,
    Avoidability			Int				NOT NULL,
    HealthPoint				Int				NOT NULL,
    MagicPoint				Int				NOT NULL,
    CONSTRAINT 			ClassPK				PRIMARY KEY(ClassID)
    );
    

CREATE TABLE USER_CHARACTER (
	CharacterID				Int				NOT NULL,
	UserID					Int 			NOT NULL,
    UserCharacterID			Int				NOT NULL,
    ClassID					Int				NOT NULL,	
    DateCreated				Date			NOT NULL,
    LastConnectDate			Date			NULL, /* 첫 접속 이라면 Null이 된다. */
    LastPlayedHour			Int				NULL,
    #TotalPayment			Int				NOT NULL DEFAULT 0, /* 이렇게 명시하는것보단 Character Payment에서 View로 보여주면 되지 않을까. */
    /*장비 관련 COLUMN도 추가해야 할 듯...*/
    CONSTRAINT			UserCharacterPK		PRIMARY KEY(CharacterID),
    CONSTRAINT			UserCharacterAK		UNIQUE(UserID, UserCharacterID),
	CONSTRAINT			UserCharDate		CHECK(LastConnectDate > DateCreated
												OR LastConnectDate IS NULL)
	/* 6개만 생성 가능하도록 하는 trigger */
	);
    /* 유저가 가입한 후, 캐릭터를 만드는 프로시져 만들기 */
	
    

CREATE TABLE CHARACTER_CONNECT (
	ConnectID				Int				NOT NULL,
	CharacterID				Int				NOT NULL,
    ConnectTime				Int				NOT NULL,
    ConnectDate				Date			NOT NULL,
    CONSTRAINT			ConnectPK			PRIMARY KEY(ConnectID)
	);
    

CREATE TABLE CHARACTER_PAYMENT (
	PaymentID				Int				NOT NULL,
	CharacterID				Int				NOT NULL,
    Payment					Int				NOT NULL,
    PayDate					Date			NOT NULL,
    CONSTRAINT			CharacterPaymentPK	PRIMARY KEY(PaymentID)
	);    
    
/* Tables For RFM Analysis. */
CREATE TABLE USER_R (
	UserID					INT				NOT NULL,
    LastConnectDayGap		INT				NULL,
    UserRank				DECIMAL(4, 2)	NOT NULL
    );
    
CREATE TABLE USER_F (
	UserID					INT				NOT NULL,
	TotalConnectTime		INT				NOT NULL,
    UserRank				DECIMAL(4, 2)	NOT NULL
    );
    
CREATE TABLE USER_M (
	UserID					INT				NOT NULL,
    TotalPayment			INT				NOT NULL,
    UserRank				DECIMAL(4, 2)	NOT NULL
    );
    
CREATE TABLE USER_RFM (
	UserID					INT				NOT NULL,
	R_Rank					INT				NOT NULL,
    F_Rank					INT				NOT NULL,
    M_Rank 					INT				NOT NULL
    );