create schema alkeWallet;
use alkeWallet;

CREATE TABLE usuario(
user_id INT PRIMARY KEY AUTO_INCREMENT,
 nombre VARCHAR(50) NOT NULL ,
 correo VARCHAR(50) NOT NULL,
 clave VARCHAR(50) DEFAULT NULL,
 saldo INT NOT NULL
);

INSERT INTO usuario (nombre, correo, clave, saldo)
VALUES 
    ('Horacio Olivera', 'ho@gmail.com', 'ho12345', 100000),
    ('Emma Zunz', 'ez@gmail.com', 'ez12345', 150300),
    ('Arturo Belano', 'eb@gmail.com', 'ab123456', 200100),
    ('Laura Avellaneda', 'lav@gmail.com', 'avel123', 75900),
    ('Bruno Diaz', 'bat@gmail.com', 'bd12345', 300201),
    ('Luisa Lane', 'luisal@gmail.com', 'lula1234', 50100),
    ('Ricardo Tapia', 'rtapia@gmail.com', 'tapia1234L', 120300),
    ('Mia Wallace', 'mwall@gmail.com', 'killbill123', 90000),
    ('Margot Tenenbaum', 'mgt@gmail.com', 'margot123', 180400),
    ('Ursula Iguaran', 'ursula@gmail.com', 'amaranta1234', 220860);



SELECT * FROM usuario;


CREATE TABLE moneda (
    currency_id INT PRIMARY KEY AUTO_INCREMENT,
    currency_name VARCHAR(50),
    currency_symbol VARCHAR(5)
);


INSERT INTO moneda (currency_name, currency_symbol) 
VALUES
    ('Peso chileno', 'CLP'),
    ('Peso argentino', 'ARS'),
    ('Dólar estadounidense', 'USD'),
    ('Euro', 'EUR');


SELECT * FROM moneda;


CREATE TABLE transaccion (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    sender_user_id INT,
    receiver_user_id INT,
    importe INT NOT NULL,
    transaction_date DATETIME,
    currency_id INT,
    CONSTRAINT fk_sender_user_id FOREIGN KEY (sender_user_id) REFERENCES usuario(user_id),
    CONSTRAINT fk_receiver_user_id FOREIGN KEY (receiver_user_id) REFERENCES usuario(user_id),
    CONSTRAINT fk_currency_id FOREIGN KEY (currency_id) REFERENCES moneda(currency_id)
);


INSERT INTO transaccion (transaction_id, sender_user_id, receiver_user_id, importe, transaction_date, currency_id) 
VALUES
    (1, 1, 2, 2000, NOW(), 1), -- Horacio Olivera envía $2000 pesos chilenos a Emma Zunz
    (2, 2, 1, 1500, NOW(), 1), -- Emma Zunz envía $1500 pesos chilenos a Horacio Olivera
    (3, 3, 4, 30000, NOW(), 2), -- Arturo Belano envía 30000 pesos argentinos a Laura Avellaneda
    (4, 4, 3, 2500, NOW(), 2), -- Laura Avellaneda envía 2500 pesos argentinos a Arturo Belano
    (5, 5, 6, 40, NOW(), 3), -- Bruno Diaz envía 40 dólares a Luisa Lane
    (6, 6, 5, 35, NOW(), 3), -- Luisa Lane envía 35 dólares a Bruno Diaz
    (7, 7, 8, 50, NOW(), 4), -- Ricardo Tapia envía 50 euros a Mia Wallace
    (8, 8, 7, 45, NOW(), 4), -- Mia Wallace envía 45 euros a Ricardo Tapia
    (9, 9, 10, 6000, NOW(), 1), -- Margot Tenenbaum envía $6000  pesos chilenos a Ursula Iguaran
    (10, 10, 9, 5500, NOW(), 1); -- Ursula Iguaran envía $5500  pesos chilenos a Margot Tenenbaum



SELECT m.currency_name
FROM usuario u
INNER JOIN transaccion t ON u.user_id = t.sender_user_id
INNER JOIN moneda m ON t.currency_id = m.currency_id
WHERE u.nombre = 'Bruno Diaz';


SELECT * FROM transaccion;



SELECT t.*
FROM transaccion t
INNER JOIN usuario u_sender ON t.sender_user_id = u_sender.user_id
INNER JOIN usuario u_receiver ON t.receiver_user_id = u_receiver.user_id
WHERE u_sender.nombre = 'Laura Avellaneda' OR u_receiver.nombre = 'Laura Avellaneda';



UPDATE usuario
SET correo= 'rayosycentellas@gmail.com'
WHERE user_id = 7;

SELECT * FROM usuario;

DELETE FROM transaccion
WHERE transaction_id =10;