SET FOREIGN_KEY_CHECKS=0; -- to disable them
SET FOREIGN_KEY_CHECKS=1; -- to re-enable them
show triggers from db128;

CREATE TABLE `Passeggero` (
    `ID_pass` VARCHAR(8) PRIMARY KEY,
    `nome` VARCHAR(100),
    `surname` VARCHAR(100),
    `email` VARCHAR(300) NOT NULL UNIQUE,
    `date_of_birth` DATE,
    `phone_number` VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE `Programma_fedelta` (
    `ID_pass` VARCHAR(8) PRIMARY KEY,
    `points` VARCHAR(8) default '0',
    CONSTRAINT `programma_fedelta_ibfk_1` FOREIGN KEY (`ID_pass`)
        REFERENCES `Passeggero` (`ID_pass`)
);

CREATE TABLE `Treno_passeggeri` (
    `ID_tp` VARCHAR(8) PRIMARY KEY,
    `capacity` INT(255) NOT NULL,
    `bags_capacity` INT NOT NULL,
    `average_speed` INT NOT NULL,
    `n_economy` INT(8) NOT NULL,
    `n_business` INT(8) NOT NULL,
    `n_premium` INT(8) NOT NULL,
    CHECK (`average_speed` < 320)
);

CREATE TABLE `Treno_merci` (
    `ID_tm` VARCHAR(10) PRIMARY KEY,
    `average_speed` INT NOT NULL,
    `n_wagons` INT NOT NULL,
    `max_capacity` VARCHAR(15) NOT NULL,
    `type_product` VARCHAR(30),
    CHECK (`average_speed` < 320)
);

CREATE TABLE `Dipendenti` (
    `ID_dip` VARCHAR(8) PRIMARY KEY,
    `name` VARCHAR(100),
    `surname` VARCHAR(100),
    `age` TINYINT(80),
    `email` VARCHAR(300) UNIQUE,
    `IBAN` VARCHAR(27) NOT NULL UNIQUE,
    CHECK (`age` < 65)
);

CREATE TABLE `Azienda` (
    `ID_azienda` VARCHAR(8) PRIMARY KEY,
    `partita_IVA` VARCHAR(11) NOT NULL UNIQUE,
    `type_product` VARCHAR(30),
    CHECK (LENGTH(`partita_IVA`) = 11)
);

CREATE TABLE `Impiegati` (
    `ID_dip` VARCHAR(8) PRIMARY KEY,
    `role` VARCHAR(30) NOT NULL,
    `office` VARCHAR(50),
    `type_of_contract` VARCHAR(50),
    CONSTRAINT `impiegato_ibfk_1` FOREIGN KEY (`ID_dip`)
        REFERENCES `Dipendenti` (`ID_dip`)
);

CREATE TABLE `Rotta` (
    `ID_rotta` VARCHAR(8) PRIMARY KEY,
    `departure_station` VARCHAR(60) NOT NULL,
    `arrival_station` VARCHAR(60) NOT NULL,
    `n_stops` TINYINT(20),
    `type` VARCHAR(14),
    CHECK (`n_stops` >= 2)
);

CREATE TABLE `Fermate` (
    `ID_fermata` VARCHAR(8) PRIMARY KEY,
    `city` VARCHAR(60) NOT NULL,
    `stop_time` TINYINT(20),
    CHECK (`stop_time` < 15)
);

CREATE TABLE `Equipaggio` (
    `ID_dip` VARCHAR(8) PRIMARY KEY,
    `ruolo` VARCHAR(15),
    `fav_route` VARCHAR(8),
    `working_hours` TINYINT(40),
    KEY `fav_route` (`fav_route`),
    CONSTRAINT `equipaggio_ibfk_1` FOREIGN KEY (`ID_dip`)
        REFERENCES `Dipendenti` (`ID_dip`),
    CONSTRAINT `equipaggio_ibfk_2` FOREIGN KEY (`fav_route`)
        REFERENCES `Rotta` (`ID_rotta`),
    CHECK (`working_hours` <= 20)
);

CREATE TABLE `Viaggio` (
    `ID_viaggio` VARCHAR(8) PRIMARY KEY,
    `ID_rotta` VARCHAR(8) NOT NULL,
    `ID_tp` VARCHAR(8),
    `ID_tm` VARCHAR(8),
    `passengers` INT,
    `departure_date` DATETIME,
    `arrival_date` DATETIME,
    `departure_bin` INT,
    `arrival_bin` INT,
    KEY `ID_rotta` (`ID_rotta`),
    KEY `ID_tp` (`ID_tp`),
    KEY `ID_tm` (`ID_tm`),
    CONSTRAINT `viaggio_ibfk_1` FOREIGN KEY (`ID_rotta`)
        REFERENCES `Rotta` (`ID_rotta`),
    CONSTRAINT `viaggio_ibfk_2` FOREIGN KEY (`ID_tp`)
        REFERENCES `Treno_passeggeri` (`ID_tp`),
    CONSTRAINT `viaggio_ibfk_3` FOREIGN KEY (`ID_tm`)
        REFERENCES `Treno_merci` (`ID_tm`),
    CHECK (`passengers` > 30)
);
 
CREATE TABLE `Prenotazione` (
    `ID_pren` VARCHAR(8) PRIMARY KEY,
    `ID_pass` VARCHAR(8),
    `ID_azienda` VARCHAR(8),
    `ID_viaggio` VARCHAR(8) NOT NULL,
    `n_passengers` TINYINT(4) NULL,
    `n_bags` TINYINT(8) NULL,
    `insurance` VARCHAR(2) NOT NULL,
    `type` VARCHAR(10) NOT NULL,
    KEY `ID_pass` (`ID_pass`),
    KEY `ID_azienda` (`ID_azienda`),
    KEY `ID_viaggio` (`ID_viaggio`),
    CONSTRAINT `prenotazione_ibfk_1` FOREIGN KEY (`ID_pass`)
        REFERENCES `Passeggero` (`ID_pass`),
    CONSTRAINT `prenotazione_ibfk_2` FOREIGN KEY (`ID_azienda`)
        REFERENCES `Azienda` (`ID_azienda`),
    CONSTRAINT `prenotazione_ibfk_3` FOREIGN KEY (`ID_viaggio`)
        REFERENCES `Viaggio` (`ID_viaggio`),
    CHECK (`n_passengers` > 0)
);

CREATE TABLE `Assicurazione` (
    `ID_pren` VARCHAR(8) PRIMARY KEY,
    `state` VARCHAR(15) NOT NULL,
    `price_paid` DECIMAL(10 , 2 ) NOT NULL,
    `compensation` DECIMAL(10 , 2 ) NULL,
    `max_compensation` DECIMAL(10 , 2 ) NOT NULL,
    CONSTRAINT `assicurazione_ibfk_1` FOREIGN KEY (`ID_pren`)
        REFERENCES `Prenotazione` (`ID_pren`),
    CHECK (`compensation` <= `max_compensation`)
);

CREATE TABLE `Recensioni` (
    `ID_pren` VARCHAR(8) PRIMARY KEY,
    `n_stars` TINYINT(5) NOT NULL,
    `ID_rotta` VARCHAR(8),
    KEY `ID_rotta` (`ID_rotta`),
    CONSTRAINT `recensioni_ibfk_1` FOREIGN KEY (`ID_pren`)
        REFERENCES `Prenotazione` (`ID_pren`),
    CONSTRAINT `recensioni_ibfk_2` FOREIGN KEY (`ID_rotta`)
        REFERENCES `Rotta` (`ID_rotta`),
    CHECK (`n_stars` > 0)
);

CREATE TABLE `Ciurma` (
    `ID_viaggio` VARCHAR(8),
    `ID_dip` VARCHAR(8),
    KEY `ID_viaggio` (`ID_viaggio`),
    KEY `ID_dip` (`ID_dip`),
    CONSTRAINT `abcd` FOREIGN KEY (`ID_viaggio`)
        REFERENCES `Viaggio` (`ID_viaggio`),
    CONSTRAINT `abcd2` FOREIGN KEY (`ID_dip`)
        REFERENCES `Equipaggio` (`ID_dip`)
);

CREATE TABLE `Percorso` (
    `ID_fermata` VARCHAR(8),
    `ID_rotta` VARCHAR(8),
    KEY `ID_fermata` (`ID_fermata`),
    KEY `ID_rotta` (`ID_rotta`),
    CONSTRAINT `abcd3` FOREIGN KEY (`ID_fermata`)
        REFERENCES `Fermate` (`ID_fermata`),
    CONSTRAINT `abcd4` FOREIGN KEY (`ID_rotta`)
        REFERENCES `Rotta` (`ID_rotta`)
);

