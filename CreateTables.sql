use vcriquinho;

CREATE TABLE users (
	id 				INT PRIMARY KEY AUTO_INCREMENT,
    userName		VARCHAR(50) NOT NULL,
    email			VARCHAR(256) NOT NULL,
    loginPassword 	VARCHAR(256) NOT NULL,
    salt 			CHAR(5) NOT NULL,
    isAdmin			BIT DEFAULT 0
); SELECT * FROM users;

CREATE TABLE userInfo (
	userId			INT NOT NULL,
    completeName	VARCHAR(60) NOT NULL,
	phone			VARCHAR(13) NOT NULL,
    personTypeId	INT NOT NULL,
    document		VARCHAR(14)	NOT NULL,
    FOREIGN KEY (userId) REFERENCES users(id)
); SELECT * FROM userInfo;

CREATE TABLE accountTypes (
	id				INT PRIMARY KEY AUTO_INCREMENT,
    accountTypeName VARCHAR(30)
);

CREATE TABLE accounts (
	id				INT PRIMARY KEY AUTO_INCREMENT,
    holderId 		INT NOT NULL,
    accountTypeId 	INT NOT NULL,
    balance			FLOAT NOT NULL DEFAULT 0,
    FOREIGN KEY (holderId) REFERENCES users(id),
    FOREIGN KEY (accountTypeId) REFERENCES accountTypes(id)
);

CREATE TABLE stockTypes (
	id 				INT PRIMARY KEY,
    typeDescription VARCHAR(50)
);

CREATE TABLE stocks (
	id				INT PRIMARY KEY AUTO_INCREMENT,
	companyName		VARCHAR(256) NOT NULL,
    stockCode		CHAR(4) NOT NULL,
    stockTypeId		INT NOT NULL,
    gracePeriodDays INT
);

CREATE TABLE stockHistory (
	stockId INT NOT NULL,
    price	FLOAT NOT NULL,
    moment	TIMESTAMP,
    
    FOREIGN KEY (stockId) REFERENCES stocks(id)
);

CREATE TABLE actionTypes (
	id			INT PRIMARY KEY AUTO_INCREMENT,
    actionDesc	VARCHAR(20) NOT NULL
);

CREATE TABLE transactionRegistry (
	accountId	INT NOT NULL,
    stockId 	INT NOT NULL,
    actionId	INT NOT NULL,
    actionDate	DATETIME NOT NULL,
    price 		FLOAT NOT NULL,
    FOREIGN KEY (accountId) REFERENCES accounts(id),
    FOREIGN KEY (stockId) REFERENCES stocks(id),
    FOREIGN KEY (actionId) REFERENCES actionTypes(id)
); -- DROP TABLE transactionRegistry;

WITH hiestHighsTable AS (
	WITH resultTable AS (
		WITH tableMomentRanksWithMaxMoment AS (
			WITH tableMomentRanks AS (
				SELECT *, ROW_NUMBER() OVER(PARTITION BY stockId ORDER BY moment) AS momentRank
				FROM stockhistory)
			SELECT *, MAX(momentRank) OVER(PARTITION BY stockId) AS maxMomentRank				
			FROM tableMomentRanks)
		SELECT *, ROW_NUMBER() OVER(PARTITION BY stockId) AS rowNum
		FROM tableMomentRanksWithMaxMoment WHERE momentRank > maxMomentRank - 2)
	SELECT rt1.stockId, rt1.price AS latestPrice, ROUND((rt2.price - rt1.price) * 100 / rt2.price, 2) * -1 AS lastVariationPerc
	FROM resultTable AS rt1
	INNER JOIN resultTable AS rt2
		ON rt1.stockId = rt2.stockId AND rt1.momentRank = rt2.momentRank + 1)
SELECT s.id, s.companyName, s.stockCode, s.stockTypeId, h.latestPrice, h.lastVariationPerc
FROM stocks s
INNER JOIN hiestHighsTable h
	ON s.id = h.stockId
ORDER BY h.lastVariationPerc ASC
LIMIT 10;

SELECT * FROM users;
SELECT * FROM userinfo;
SELECT * FROM stocks;
SELECT * FROM accounts;
SELECT * FROM accounttypes;
SELECT * FROM transactionregistry;

SELECT s.stockCode, s.companyName, tr.actionId, tr.actionDate FROM transactionregistry AS tr
INNER JOIN stocks s ON s.id = tr.stockId 
WHERE tr.accountId = 22
ORDER BY actionDate ASC;

UPDATE users SET isAdmin = 1 WHERE userName = 'MechAAV';
SELECT stockId, price, MAX(moment) FROM stockhistory GROUP BY stockId;

SELECT * FROM stockHistory WHERE stockId = 1;
SELECT stocks.id, stocks.companyName, stocks.stockCode, stocks.stockTypeId, sh1.price, stocks.gracePeriodDays
FROM stocks 
INNER JOIN
	(stockHistory sh1 LEFT JOIN stockHistory sh2 ON sh1.moment < sh2.moment)
    ON sh1.stockId = stocks.id
WHERE sh2.moment IS NULL;

SELECT * FROM stockHistory sh1
LEFT JOIN stockHistory sh2 ON (sh1.stockId = sh2.stockId AND sh1.moment < sh2.moment)
WHERE sh2.moment IS NULL;

SELECT * FROM accounts WHERE accountTypeId = 3;

SELECT s.stockCode, s.companyName, tr.actionId, tr.actionDate  FROM transactionregistry AS tr
INNER JOIN stocks s ON s.id = tr.stockId
WHERE tr.accountId = 55;

SELECT t1.boughtCount > t2.soldCount FROM (SELECT COUNT(*) AS boughtCount FROM transactionregistry WHERE actionId = 1 AND accountId = 55 AND stockId = 22) AS t1
INNER JOIN (SELECT COUNT(*) AS soldCount FROM transactionregistry WHERE actionId = 2 AND accountId = 55 AND stockId = 22) AS t2;
