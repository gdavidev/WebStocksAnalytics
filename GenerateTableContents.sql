-- CREATE STOCKS --
-- DELETE FROM stocks WHERE NOT companyName = "";
-- ALTER TABLE stocks AUTO_INCREMENT = 1;
-- DROP TABLE IF EXISTS stocks;
drop procedure if exists createStocks;
drop table if exists Nomes;
drop table if exists nameSufixes;
create table Nomes(nome VARCHAR(30));
insert into Nomes(nome)
values ('Tec'),('Inova'),('Eco'),('Stellar'),('GigaNet'),('Vista'),('Asteris'),('Quantum'),('Inova'),('Forta'),('BlueWave'),('Zenith'),('Fluxon'),('Digital'),('Strato'),('Nexa'),('TerraNova'),('Vertex'),('UltraWave'),('Quantum');

create table nameSufixes(nome VARCHAR(30));
insert into nameSufixes(nome)
values ('Nova'),('Prime'),('Forte'),('Works'),('Global'),('Plus'),('Web'),('Com'),('Industries'),('Innovations'),('Tech'),('Zen'),('Space'),('Dynamics'),('Ventures'),('Systems'),('Solutions'),('Era');
DELIMITER //    
CREATE PROCEDURE createStocks(quantity INT) 
BEGIN
	DECLARE companyName VARCHAR(60);
	declare companyNameSufix VARCHAR(60);
	declare companyNameFinal VARCHAR(60);
	declare stockcode CHAR(4);
	declare stockType INT;
    declare gracePeriodDays INT;
    
	WHILE quantity > 0 DO
		SELECT nome INTO companyName FROM Nomes ORDER BY RAND() LIMIT 1;
		SELECT nome INTO companyNameSufix FROM nameSufixes ORDER BY RAND() LIMIT 1;
		SET companyNameFinal = CONCAT(companyName, ' ', companyNameSufix);
		SET stockcode = UPPER(CONCAT(MID(companyName, 1, 2), MID(companyNameSufix, 1, 2)));
		SET stockType = ROUND(RAND() * (11-1)+1, 0);
        SET gracePeriodDays = ROUND(RAND() * (24-1)+1, 0) * 30;

		INSERT INTO stocks(companyName, stockCode, stockTypeId, gracePeriodDays)
		VALUES (companyNameFinal, stockcode, stockType, gracePeriodDays);

		set quantity = quantity - 1;
	END WHILE;
END //
DELIMITER ;  
call createStocks(120);
select * from stocks;

-- CREATE STOCKHISTORY --
-- DROP TABLE stockHistory;
DROP PROCEDURE IF EXISTS createStockHistory;
DELIMITER //
CREATE PROCEDURE createStockHistory(days INT)
BEGIN    
    DECLARE stockQuantity INT;
    DECLARE stockId INT;
    DECLARE price INT;
    DECLARE moment TIMESTAMP;
    
    SELECT COUNT(*) INTO stockQuantity FROM stocks;     
    SET moment = CURDATE();    
	WHILE days > 0 DO
		SET stockId = stockQuantity;
		WHILE stockId > 0 DO
			INSERT INTO stockHistory(stockId, price, moment)
			VALUES (stockId, ROUND(RAND() * (200.00-0.10)+0.10, 2), moment);
			SET stockId = stockId - 1;
		END WHILE;
		SET moment = DATE_ADD(moment, INTERVAL 1 DAY);
		
		SET days = days - 1;
	END WHILE;
END //
DELIMITER ;
CALL createStockHistory(20);
SELECT * FROM stockHistory;
