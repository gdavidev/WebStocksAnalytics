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

INSERT INTO
	users(userName, email, loginPassword, salt, isAdmin)
VALUES
	('Felipe', 'felipe-silva73@semco.com.br', '1aPGdHHkTZ', 'AABC', 0),  
	('Isadora', 'isadora.tania.pinto@inepar.com.br', 'N8GscAIjB3', 'AABC', 0),  
	('Ian', 'ian-figueiredo80@10clic.com.br', 'aOoc4O4Pjx', 'AABC', 0),  
	('Tomás', 'tomasthomasgalvao@eletrolexeng.com.br', 'iA0KAPIC4g', 'AABC', 0),  
	('Vinicius', 'vinicius_benicio_drumond@grupoitamaraty.com.br', 'dX3IZE4m75', 'AABC', 0),  
	('Isabela', 'isabela_lais_bernardes@cielo.com.br', 'kkQ1be3kmh', 'AABC', 0),  
	('Nathan', 'nathan-aparicio81@r7.com', 'ETmsYL3C2Y', 'AABC', 0),  
	('Vinicius', 'viniciusvictoralmeida@rafaelsouza.com.br', 'bG5FXB0KQ8', 'AABC', 0),  
	('Alícia', 'alicia_sueli_damota@revati.com.br', 'aRPWqXMNSF', 'AABC', 0),  
	('Sandra', 'sandra_jaqueline_jesus@studiodeideias.com', 'qtCcCLEzNo', 'AABC', 0),  
	('Luna', 'luna.marlene.farias@cenavip.com.br', '2ElAidu1ke', 'AABC', 0),  
	('Cecília', 'ceciliafabianabarros@gap.com.br', 'ayW9iFPjh4', 'AABC', 0),  
	('Gabriela', 'gabriela_andrea_carvalho@foxtech.com.br', 'iSUcxZC0B5', 'AABC', 0),  
	('Carlos', 'carloseduardobarbosa@splicenet.com.br', 'T3eFA5xshM', 'AABC', 0),  
	('Marcos', 'marcos-moraes86@anfip.org.br', 'AdWAaX6Po5', 'AABC', 0),  
	('Malu', 'malu_daniela_fernandes@solviagens.com', 'SMJdMwFNIe', 'AABC', 0),  
	('Rayssa', 'rayssalarissaporto@consultorialk.com.br', 'dj0sXxbWPr', 'AABC', 0),  
	('Luiz', 'luiz-fogaca92@comercialrizzo.com', 'AsWpk6ailK', 'AABC', 0),  
	('Mateus', 'mateus_vinicius_novaes@localiza.com', 'fL8Pxbj6iE', 'AABC', 0),  
	('Luiza', 'luiza_sueli_dasneves@atualvendas.com', 'Dp4g9CfZOl', 'AABC', 0),  
	('Elias', 'elias-dacruz86@silicotex.net', 'Ehwnhgzxup', 'AABC', 0),  
	('Maitê', 'maiteheloisaaragao@zf.com', 'WF9muPCbqA', 'AABC', 0),  
	('Antônia', 'antoniajulianagomes@pharmaterra.com.br', 'CgPDBqtu24', 'AABC', 0),  
	('Eloá', 'eloafatimarodrigues@nextel.com.br', 'lWFn4KArc2', 'AABC', 0),  
	('Marlene', 'marlene_camila_mendes@tita.com.br', 'qPAuDKf0Yx', 'AABC', 0),  
	('Elaine', 'elaine_giovana_assis@i9tec.com.br', 'XT4kpaF94i', 'AABC', 0),  
	('João', 'joao.matheus.brito@galvao.com', 'RQXM0ZarFB', 'AABC', 0),  
	('Jaqueline', 'jaqueline-depaula96@terrabrasil.com.br', 'NrA44gSmIN', 'AABC', 0),  
	('Luiz', 'luiz.nathan.baptista@rcstechnology.com.br', 'KFFh8UyaEk', 'AABC', 0),  
	('Andreia', 'andreia-duarte76@jpmanager.com.br', 'xtf3Y61qrX', 'AABC', 0);

INSERT INTO
	userInfo(userId, document, phone, completeName, personTypeId)
VALUES
	(1, '245.000.349-51', '21 99163-0017', 'Felipe Oliver Murilo Silva', 1),
	(2, '245.000.349-51', '21 99163-0017', 'Isadora Tânia Fabiana Pinto', 1),
	(3, '938.887.878-74', '85 98921-4247', 'Ian Benício Manoel Figueiredo', 1),
	(4, '440.935.455-88', '67 98924-7034', 'Tomás Thomas Galvão', 1),
	(5, '075.114.150-08', '95 99978-1556', 'Vinicius Benício Drumond', 1),
	(6, '147.946.823-10', '12 98104-6758', 'Isabela Laís Bernardes', 1),
	(7, '543.423.169-43', '86 99520-6417', 'Nathan Edson Aparício', 1),
	(8, '705.077.740-43', '82 98988-5709', 'Vinicius Victor Márcio Almeida', 1),
	(9, '391.451.864-21', '65 99721-0304', 'Alícia Sueli da Mota', 1),
	(10, '301.945.443-38', '65 99932-7086', 'Sandra Jaqueline Manuela Jesus', 1),
	(11, '537.471.802-99', '41 98272-2250', 'Luna Marlene Farias', 1),
	(12, '375.581.834-56', '67 98428-5287', 'Cecília Fabiana Gabriela Barros', 1),
	(13, '580.974.137-10', '75 98397-4419', 'Gabriela Andrea Carvalho', 1),
	(14, '806.629.956-78', '48 99544-7348', 'Carlos Eduardo Hugo Barbosa', 1),
	(15, '457.305.181-37', '83 99728-5514', 'Marcos Sérgio Manuel Moraes', 1),
	(16, '461.087.845-39', '87 99189-5655', 'Malu Daniela Fernandes', 1),
	(17, '692.776.831-98', '96 98502-4235', 'Rayssa Larissa Andreia Porto', 1),
	(18, '179.096.121-17', '63 98647-9566', 'Luiz Miguel Manuel Fogaça', 1),
	(19, '570.253.298-86', '96 99415-7351', 'Mateus Vinicius Novaes', 1),
	(20, '073.598.849-85', '95 99103-2169', 'Luiza Sueli Cecília das Neves', 1),
	(21, '365.662.060-19', '92 99995-9776', 'Elias Jorge Samuel da Cruz', 1),
	(22, '193.057.565-30', '69 98326-5199', 'Maitê Heloisa Aragão', 1),
	(23, '364.646.213-27', '87 99769-3233', 'Antônia Juliana Raimunda Gomes', 1),
	(24, '390.500.700-27', '69 99605-5980', 'Eloá Fátima Rodrigues', 1),
	(25, '123.733.481-01', '86 98405-5323', 'Marlene Camila Emily Mendes', 1),
	(26, '702.247.692-60', '27 99280-4927', 'Elaine Giovana Assis', 1),
	(27, '237.826.393-75', '53 99596-5827', 'João Matheus Brito', 1),
	(28, '449.198.523-55', '81 99281-1107', 'Jaqueline Elisa Raimunda de Paula', 1),
	(29, '816.781.553-65', '82 99906-6810', 'Luiz Nathan Manoel Baptista', 1),
	(30, '162.837.726-76', '68 99156-6039', 'Andreia Isabella Marina D', 1);