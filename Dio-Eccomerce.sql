-- Criação do banco de dados
CREATE DATABASE ecommerce;
USE ecommerce;

-- Criar tabela cliente
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(50) NOT NULL,
    Minit CHAR(1),
    Lname VARCHAR(50) NOT NULL,
    CPF CHAR(11) NOT NULL UNIQUE,
    Address VARCHAR(255)
);

-- Criar tabela produto
CREATE TABLE product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(50) NOT NULL,
    classification_kids BOOLEAN DEFAULT FALSE,
    category ENUM('Eletronico', 'Vestimenta', 'Brinquedos', 'Alimentos', 'Móveis') NOT NULL,
    avaliação FLOAT DEFAULT 0,
    size VARCHAR(10)
);

-- Criar tabela de pedidos
CREATE TABLE orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT,
    orderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_orders_cliente FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente)
);

-- Criar tabela pedido
CREATE TABLE productOrder (
    idPOproduct INT,
    idPOorder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOproduct, idPOorder),
    CONSTRAINT fk_productOrder_product FOREIGN KEY (idPOproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_productOrder_orders FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
);

-- Criar tabela fornecedor
CREATE TABLE Seller (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbstName VARCHAR(255),
    CPF CHAR(11),
    CNPJ CHAR(14) NOT NULL,
    location VARCHAR(255),
    contact VARCHAR(15) NOT NULL,
    CONSTRAINT unique_CNPJ_supplier UNIQUE(CNPJ),
    CONSTRAINT unique_CPF_supplier UNIQUE(CPF)
);

-- Criar tabela de relação entre produto e fornecedor
CREATE TABLE productSeller (
    idPseller INT,
    idProduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idPseller, idProduct),
    CONSTRAINT fk_productSeller_supplier FOREIGN KEY (idPseller) REFERENCES Seller(idSupplier),
    CONSTRAINT fk_productSeller_product FOREIGN KEY (idProduct) REFERENCES product(idProduct)
);

-- Criar tabela de localização de armazenamento
CREATE TABLE storageLocation (
    idproduct INT,
    idstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idproduct, idstorage),
    CONSTRAINT fk_storageLocation_product FOREIGN KEY (idproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storageLocation_productSeller FOREIGN KEY (idstorage)
    );
    
    
show databases;
use information_schema;
show tables;
desc referential_constraints;
select * from referential_constraints;



-- Inserção de dados e queries
USE ecommerce;

SHOW TABLES;

-- idClient, Fname, Minit, Lname, CPF, Address
INSERT INTO Clients (Fname, Minit, Lname, CPF, Address)
VALUES
    ('Maria', 'M', 'Silva', 12346789, 'rua silva de prata 29, Carangola - Cidade das flores'),
    ('Matheus', 'O', 'Pimentel', 987654321, 'rua alameda 289, Centro - Cidade das flores'),
    ('Ricardo', 'F', 'Silva', 45678913, 'avenida alameda vinha 1009, Centro - Cidade das flores'),
    ('Julia', 'S', 'França', 789123456, 'rua lareijas 861, Centro - Cidade das flores'),
    ('Roberta', 'G', 'Assis', 98745631, 'avenidade koller 19, Centro - Cidade das flores'),
    ('Isabela', 'M', 'Cruz', 654789123, 'rua alameda das flores 28, Centro - Cidade das flores');

-- idProduct, Pname, classification_kids boolean, category ('Eletrônico','Vestimenta','Brinquedos','Alimentos','Móveis'), avaliação, size
INSERT INTO product (Pname, classification_kids, category, avaliação, size) VALUES
    ('Fone de ouvido', false, 'Eletrônico', '4', NULL),
    ('Barbie Elsa', true, 'Brinquedos', '3', NULL),
    ('Body Carters', true, 'Vestimenta', '5', NULL),
    ('Microfone Vedo - Youtuber', false, 'Eletrônico', '4', NULL),
    ('Sofá retrátil', false, 'Móveis', '3', '3x57x80'),
    ('Farinha de arroz', false, 'Alimentos', '2', NULL),
    ('Fire Stick Amazon', false, 'Eletrônico', '3', NULL);

SELECT * FROM clients;
SELECT * FROM product;

-- Inserção de pedidos
-- idOrder, idOrderClient, orderStatus, orderDescription, sendValue, paymentCash
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES
    (1, NULL, 'compra via aplicativo', NULL, 1),
    (2, NULL, 'compra via aplicativo', 50, 0),
    (3, 'Confirmado', NULL, NULL, 1),
    (4, NULL, 'compra via web site', 150, 0);

-- idPOproduct, idPOorder, poQuantity, poStatus
select * from orders;
insert into productOrder (idPOproduct, idPOorder, poQuantity, poStatus) values
(1,5,2,null),
(2,5,1,null),
(3,6,1,null);

-- storageLocation, quantity
insert into productStorage (storageLocation, quantity) values
('Rio de Janeiro', 1000),
('Rio de Janeiro', 500),
('São Paulo', 10),
('São Paulo', 100),
('São Paulo', 10);

INSERT INTO storageLocation (idProduct, idLstorage, location) VALUES
(1, 2, 'RJ'),
(2, 6, 'GO');

INSERT INTO supplier (SocialName, CNPJ, contact) VALUES
('Almeida e Filhos', '123456789123456', '2198574'),
('Eletrônicos Silva', '854519649143457', '21985484'),
('Eletrônicos Valma', '934567893934695', '21975474');

SELECT * FROM supplier;

INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity) VALUES
(1, 1, 500),
(1, 2, 400);

INSERT INTO supplier (SocialName, CNPJ, contact) VALUES
('Almeida e filhos', 123456789123456, '21985474'),
('Eletrônicos Silva', 854519649143457, '21985484'),
('Eletrônicos Valma', 934567893934695, '21975474');

SELECT * FROM supplier;

-- idPsSupplier, idPsProduct, quantity
INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity) VALUES
(1, 1, 500),
(1, 2, 400),
(2, 4, 633),
(3, 3, 5),
(2, 5, 10);

-- idSeller, SocialName, AbstName, CNPJ, CPF, location, contact
insert into seller (Socialname,AbstName,CNPJ,CPF,location,contact) values
        ('Tech eletronics ', null, 123456789456321, null, 'Rio de Janeiro','219946287'),
        ('Botique Durgas',null,null,123456783,'Rio de Janeiro',219567895),
        ('Kids world',null,456789123654485,null,'São Paulo',1198657484);
        
        
	select * from seller;
    select count(*) from clients;
    select * from clients c, orders o where c.idClient = idOrderClient;
    
        -- idPseller,idPproduct, prodQuantity
        insert into productSeller (idPseller, idPproduct, prodQuantity) values
                    (1,6,80),
                    (2,7,10);
        
        select* from clientes c, orders o where c.idClient = idOrderClient;
        select concat(Fname,' ',Lname) as Client, idORder as request, orderStatus as order_Status from clients c, orders o where c.idClient = idOrderClient 
        
	insert into orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) values
			
		 (2, default,'compra via aplicativo', null ,1)
	
    -- Recuperar quanto pedidos foram realizados pelos clientes?(não sei n vi no video e coloquei >-<)
    select* from clientes c, orders o 
    where c.idCliente = idOrdemClient
    
    select * from orders;
    select count(*) as Number_of_orders from clients left outer join orders ON idCliente = idOrdemClient
                inner join productOrder p on p.orderCliente = idOrder;
                group by idClient;