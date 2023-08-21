-- -----------------------------------------------------
CREATE DATABASE IF NOT EXISTS vendas;
-- -----------------------------------------------------

USE vendas;

-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table vendas.estado
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS estado (
  codestado INT NOT NULL,
  nome VARCHAR(45) NULL,
  PRIMARY KEY (codestado));


-- -----------------------------------------------------
-- Table vendas.tipocliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS tipocliente (
  codtipo INT NOT NULL,
  nometipo VARCHAR(45) NULL,
  PRIMARY KEY (codtipo));


-- -----------------------------------------------------
-- Table vendas.cliente
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS cliente (
  codcliente INT NOT NULL,
  nome VARCHAR(100) NULL,
  email VARCHAR(100) NULL,
  telefone VARCHAR(45) NULL,
  cep VARCHAR(45) NULL,
  rua VARCHAR(45) NULL,
  numero INT NULL,
  complemento VARCHAR(45) NULL,
  cidade VARCHAR(45) NULL,
  codestado INT NOT NULL,
  codtipo INT NOT NULL,
  PRIMARY KEY (codcliente),
  FOREIGN KEY (codestado) REFERENCES estado (codestado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (codtipo)
    REFERENCES tipocliente (codtipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


-- -----------------------------------------------------
-- Table IF NOT EXISTS Pedido
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS pedido (
  codpedido INT NOT NULL,
  data DATE NULL,
  valor DECIMAL(22,7) NULL,
  codcliente INT NOT NULL,
  PRIMARY KEY (codpedido),
  FOREIGN KEY (codcliente) REFERENCES cliente (codcliente)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table IF NOT EXISTS Categoria
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS categoria (
  codcategoria INT NOT NULL,
  nome VARCHAR(100) NULL,
  PRIMARY KEY (codcategoria));


-- -----------------------------------------------------
-- Table IF NOT EXISTS Produto
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS produto (
  codproduto INT NOT NULL,
  nome VARCHAR(100) NULL,
  preco DECIMAL(22,7) NULL,
  codcategoria INT NOT NULL,
  PRIMARY KEY (codproduto),
  FOREIGN KEY (codcategoria) REFERENCES categoria (codcategoria)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table IF NOT EXISTS Item
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS item (
  coditem INT NOT NULL,
  quantidade INT NULL,
  valorunitario DECIMAL(22,7) NULL,
  codpedido INT NOT NULL,
  codproduto INT NOT NULL,
  PRIMARY KEY (coditem),
  FOREIGN KEY (codpedido) REFERENCES pedido (codpedido)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (codproduto) REFERENCES produto (codproduto)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Inserção de Dados
-- -----------------------------------------------------
INSERT INTO estado VALUES (1,'Acre'),(2,'Alagoas'),(3,'Amapá'),(4,'Amazonas'),(5,'Bahia'),(6,'Ceará'),(7,'Distrito Federal'),(8,'Espírito Santo'),(9,'Goiás'),(10,'Maranhão'),(11,'Mato Grosso'),(12,'Mato Grosso do Sul'),(13,'Minas Gerais'),(14,'Pará'),(15,'Paraíba'),(16,'Paraná'),(17,'Pernambuco'),(18,'Piauí'),(19,'Rio de Janeiro'),(20,'Rio Grande do Norte'),(21,'Rio Grande do Sul'),(22,'Rondônia'),(23,'Roraima'),(24,'Santa Catarina'),(25,'São Paulo'),(26,'Sergipe'),(27,'Tocantins');

insert into tipocliente values (1,'OURO'),
(2,'PRATA'),
(3,'BRONZE'),
(4,'NORMAL');

insert into cliente values (1,'Aaron Nelson Lopes','aaronnl@lojaesportes.com.br','31 33111001',30000000,'Rua A',1,1,'Belo Horizonte',13,1),
(2,'Estefano João Del Rei Belo da Silva','estefanojs@lojaesportes.com.br','31 33111002',30000000,'Rua O',1,2,'Belo
Horizonte',13,1),
(3,'Evandro macahuba','evandromac@lojaesportes.com.br','31 33111003',30000000,'Rua A',1,1,'Belo Horizonte',13,2),
(4,'Fabiana de Araújo Delfino','fabianaadel@lojaesportes.com.br','31 33111011',30000000,'Rua Q',1,1,'Belo Horizonte',13,4),
(5,'Fabio Benevides de Barros','fabiobene@lojaesportes.com.br','31 33111021',30000000,'Rua B',1,1,'Belo Horizonte',13,3),
(6,'Felipe Alves de Souza','felipeasouza@lojaesportes.com.br','31 33111031',30000000,'Rua C',1,1,'São Paulo',27,2),
(7,'Henrique de Pedro','henriquepe@lojaesportes.com.br','31 33111041',30000000,'Rua T',1,1,'São Paulo',27,3),
(8,'Homero Caporali Campos','homerocapo@lojaesportes.com.br','31 33111051',30000000,'Rua R',1,1,'São Paulo',27,4),
(9,'Igor Araujo Costa','igorac@lojaesportes.com.br','31 33111061',30000000,'Rua S',1,1,'Rio de Janeiro',19,1),
(10,'Renato dias de Souza','renatodsouza@lojaesportes.com.br','31 33111071',30000000,'Rua L',1,1,'Rio de Janeiro',19,2);

insert into categoria values (1,'Adventure'),
(2,'Artes Marciais'),
(3,'Automobilismo'),
(4,'Basquete'),
(5,'Bikes'),
(6,'Casual'),
(7,'Fitness'),
(8,'Futebol'),
(9,'Golfe'),
(10,'Handebol'),
(11,'Jogos de Mesa'),
(12,'Running'),
(13,'Skate'),
(14,'Tennis e Squash'),
(15,'Trainning');

insert into produto values (1,'Sacola Gymsack Pet',29,15),
(2,'Monitor Cardíaco Heart',149,14),
(3,'Jaqueta Tracktop',99,15),
(4,'Tênis Shoes',129,15),
(5,'Simulador de Caminhada Training',349,15),
(6,'Colchonete Polimetrico',45,15),
(7,'Camisa Esportiva',99,15),
(8,'Camisa Esportiva Manga Longa',169,15),
(9,'Camisa Oficial do Brasil',229,15),
(10,'Tênis Runner',159,15),
(11,'Tênis Mountain',89,15),
(12,'Calça NBA',49,15),
(13,'Agasalho NBA',59,15),
(14,'Bola Baller',34,15),
(15,'Skate Stick Up Cop 7.7',149,15),
(16,'Skate Skulls 7.875',259,15),
(17,'Tênis Vulc Mid',299,15),
(18,'Sk8 Tron 814',2815,14),
(19,'Capacete SkateBoards',77,14),
(20,'Boné Washington DC',49,15),
(21,'Boné New Style Black',99,15),
(22,'Bicicleta Aluminium 2010 Aro 26',399,14),
(23,'Bicicleta T-Type Aro 26',1049,15),
(24,'Bomba H Dupla Ação',24,15),
(25,'Sapatilha Aerospeed',439,15),
(26,'Tênis Drive',199,15),
(27,'Testeira NX',14,15),
(28,'Bola de Tennis Championship Gold',16,15),
(29,'Camiseta New Dry-Fit',49,15),
(30,'Mochila Ferrari',149,15),
(31,'Tênis Urban Racer SF',378,14),
(32,'Tênis Place Cat',249,15),
(33,'Bolsa SF Medium Team Bag',328,14),
(34,'Tênis Tube Explosion',99,15),
(35,'Kit Tatame Premium 9',639,14),
(36,'Kimono Jiu-Jitsu Série Gold',225,14),
(37,'Kimono Jiu-Jitsu Série Standart',199,15),
(38,'Luva de Boxe 16 oz',109,14),
(39,'Faixa Ponta Preta - Branca',25,14),
(40,'Faixa Ponta Preta - Amarela',25,14),
(41,'Camiseta Treino Competição',28,15),
(42,'Trampolim Professional',199,15),
(43,'Sandália Sunray Adjust 3',99,15),
(44,'Bicicleta TRS Aro 26',599,15),
(45,'Bota Trail Dust 2',279,15),
(46,'Mochila Hidratação Marathon Grande',79,15),
(47,'Saco de Dormir Pantanal',75,15),
(48,'Sandália Papete Adjust 3',79,15),
(49,'Bolsa Térmica PVC 14L',23,15),
(50,'Bolsa Térmica Cap 32L',33,15),
(51,'Meião Lotto',19,15),
(52,'Munhequeira United',29,15),
(53,'Luva Match Junior',49,15),
(54,'Caneleira Slip in',39,15),
(55,'Tornozeleira Cadarço',39,15),
(56,'Saia Fiesta Skort',89,15);

insert into pedido values 
(1,'2009-11-11',659.10, 1),
(2,'2009-11-03',34.90, 2),
(3,'2009-11-13',77.90,3),
(4,'2009-11-22',199.80,3),
(5,'2009-11-30',129.90,3),
(6,'2009-07-01',229.90,4),
(7,'2009-07-15',99.80,5),
(8,'2009-05-05',89.70,6),
(9,'2009-05-19',169.00,7),
(10,'2009-11-06',14.90,8),
(11,'2010-02-15',3.82,9),
(12,'2010-02-02',26.48,10),
(13,'2010-02-22',56.78,10),
(14,'2010-02-27',87.09,10),
(15,'2010-03-01',117.39,2),
(16,'2010-03-10',147.69,2),
(17,'2010-04-15',178.00,2),
(18,'2010-05-15',208.30,4),
(19,'2010-06-06',238.60,4),
(20,'2010-06-18',268.91,7),
(21,'2010-06-22',299.20,8),
(22,'2010-07-01',329.52,9),
(23,'2023-08-01',329.52,9);

insert into item values (1,2,29.9,1,1),
(2,2,29.9,1,1),
(3,3,159.9,10,1),
(4,2,29.9,1,1),
(5,1,34.9,12,2),
(6,1,77.9,20,3),
(7,2,99.9,3,4),
(8,1,129.9,4,5),
(9,1,229.9,9,6),
(10,2,49.9,12,7),
(11,3,29.9,1,8);