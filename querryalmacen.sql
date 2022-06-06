
CREATE DATABASE Mercadito;
/* | Creacion de tablas | */
DROP TABLE IF EXISTS Users;
CREATE TABLE Users(
	usrUsrname 	VARCHAR(45) 	NOT NULL PRIMARY KEY,
	usrFname 	VARCHAR(45) 	NOT NULL, 
	usrLname 	VARCHAR(45) 	NOT NULL,
	usrEmail	VARCHAR(45) 	NOT NULL UNIQUE,
	usrPswrd 	VARCHAR(45) 	NOT NULL);

DROP TABLE IF EXISTS Marca;
CREATE TABLE Marca(
	marcId		INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
	marcName	VARCHAR(25) NOT NULL);

DROP TABLE IF EXISTS Departamento;
CREATE TABLE Departamento(
	dptoId		INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY ,
	dptoName	VARCHAR(25) NOT NULL);

DROP TABLE IF EXISTS Sucursal;
CREATE TABLE Sucursal(
	sucId		INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	sucName		VARCHAR(25) NOT NULL,
	sucPais		VARCHAR(25) NOT NULL,
	sucCity		VARCHAR(45) NOT NULL,
	sucDirec	VARCHAR(45) NOT NULL);

DROP TABLE IF EXISTS Producto;
CREATE TABLE Producto(
	prodId		INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,		
	prodName	VARCHAR(100) NOT NULL,
	prodPrice	NUMERIC(9,2) NOT NULL,
	prodMarc	INT REFERENCES Marca(marcId)NOT NULL,
	prodDpto	INT REFERENCES Departamento(dptoId)NOT NULL,
	prodSuc		INT REFERENCES Sucursal(sucId) NOT NULL);

select prodId,prodName,prodPrice,marcName,dptoName,sucName  from Producto,Marca,Departamento,Sucursal ;
/* | Inserciones | */
INSERT INTO Marca (marcName) VALUES('Apple');		
INSERT INTO Marca (marcName) VALUES('Microsoft');
INSERT INTO Marca (marcName) VALUES('AmazonBasics');		
INSERT INTO Marca (marcName) VALUES('Meta');
INSERT INTO Marca (marcName) VALUES('Hyperx');		
INSERT INTO Marca (marcName) VALUES('Logitech');
INSERT INTO Marca (marcName) VALUES('Samsung');		
INSERT INTO Marca (marcName) VALUES('Razer');
INSERT INTO Marca (marcName) VALUES('Corsair');	
INSERT INTO Marca (marcName) VALUES('Kingston');
INSERT INTO Marca (marcName) VALUES('ElGato');		
INSERT INTO Marca (marcName) VALUES('Asus');
INSERT INTO Marca (marcName) VALUES('Hp');
INSERT INTO Marca (marcName) VALUES('Intel');
INSERT INTO Marca (marcName) VALUES('Ryzen');
INSERT INTO Marca (marcName) VALUES('Nvidia');
INSERT INTO Marca (marcName) VALUES('Otros');

INSERT INTO Departamento(dptoName) VALUES('Monitores');
INSERT INTO Departamento(dptoName) VALUES('Teclados');
INSERT INTO Departamento(dptoName) VALUES('Ratones');
INSERT INTO Departamento(dptoName) VALUES('Almacenamiento');
INSERT INTO Departamento(dptoName) VALUES('Memorias Ram');
INSERT INTO Departamento(dptoName) VALUES('Camaras');
INSERT INTO Departamento(dptoName) VALUES('Gadgets');
INSERT INTO Departamento(dptoName) VALUES('Fuentes de poder');
INSERT INTO Departamento(dptoName) VALUES('Ventilacion');
INSERT INTO Departamento(dptoName) VALUES('Motherboards');
INSERT INTO Departamento(dptoName) VALUES('Smartphones');
INSERT INTO Departamento(dptoName) VALUES('Gabinetes');
INSERT INTO Departamento(dptoName) VALUES('Mousepads');
INSERT INTO Departamento(dptoName) VALUES('Procesadores');
INSERT INTO Departamento(dptoName) VALUES('Tarjetas de Video');


select * from sucursal
select * from departamento
select * from marca

INSERT INTO Sucursal(sucName,sucPais,sucCity,sucDirec) VALUES (
'BajaPC','Mexico',	'Tijuana',	'Calzada Tecnologico');
INSERT INTO Sucursal(sucName,sucPais,sucCity,sucDirec) VALUES (
'PCBox','Mexico',	'Tijuana',	'Otay');
INSERT INTO Sucursal(sucName,sucPais,sucCity,sucDirec) VALUES (
'Doctor PC','Mexico',	'Tijuana',	'Plaza Monarca');



INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'VERSA LE TM',	515.900, 12, 15, 1);
INSERT INTO Producto(prodName,prodPrice,prodContNet,prodDesc,prodMarc,prodDpto,prodSuc) VALUES(
'MacOS Sierra',	2000.0000,	1,
'Sistema operativo para computador portatil marca Apple.', 1, 14, 2);
INSERT INTO Producto(prodName,prodPrice,prodContNet,prodDesc,prodMarc, prodDpto,prodSuc) VALUES(
'Old Spice',	40.72,	0.096,
'Body Spray', 11, 11, 3);


/* | Consultas | */
/* Visualizamos Productos respecto a sus marcas */
SELECT DISTINCT dptoName AS 'Departamento', marcName AS 'Marca', prodName AS 'Producto', sucName AS 'Sucursal', prodPrice as 'Precio' 
/* ==== Tablas a consultar	   ==== */	FROM Marca, Sucursal, Producto, Departamento
/* ==== con base en las marcas ==== */	WHERE prodMarc = marcId AND prodSuc = sucId AND prodDpto = dptoId;

SELECT * FROM Users;


/* Tablas referentes a lista de productos del usuario*/ 
DROP TABLE IF EXISTS MiCarrito;
CREATE TABLE MiCarrito(
	mcarId		INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	mcarName	VARCHAR(300) NOT NULL,
	mcarDate	DATE,
	mcarUsr		VARCHAR(45) REFERENCES Users(usrUsrname) NOT NULL);
	/* Inserción de listas respect a un usuario (FALTA ASIGNAR FECHA mcarDate)*/
INSERT INTO MiCarrito (mcarName,mcarUsr) VALUES('Lista Kalixta','Alvaroggm123');
INSERT INTO MiCarrito (mcarName,mcarUsr) VALUES('Sorprendeme','chrisare18');
INSERT INTO MiCarrito (mcarName,mcarUsr) VALUES('La Big Mama','corona9955');
INSERT INTO MiCarrito (mcarName,mcarUsr) VALUES('SAjid','SajidEspadas450');

/* Tabla para asociar productos que seleccione el usuario respecto a su lista */
DROP TABLE IF EXISTS MisProductos;
CREATE TABLE MisProductos(
	mprodId		INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	mprodCantidad INT,
	mprodCar	INT REFERENCES MiCarrito(mcarId) NOT NULL,
	mprodProd	INT REFERENCES Producto(prodId) NOT NULL);

	/* Inserción de productos con base en lista de usuario*/
INSERT INTO MisProductos(mprodCar, mprodProd) VALUES(1, 1);
INSERT INTO MisProductos(mprodCar, mprodProd) VALUES(1, 2);
SELECT * FROM MisProductos;


SELECT DISTINCT mcarName as 'Lista de compras' , prodName AS 'Producto'							/*¨Elementos que se mostraran en la consulta */
/* ==== Tablas a consultar	   ==== */	FROM Users, MisProductos, MiCarrito, Producto			/* Las tablas de referencia */
/* ==== con base en las marcas ==== */	WHERE usrUsrname = mcarUsr AND usrUsrname = 'chrisare18'/* Comienzan las condiciones */
/* ==== que prod existan	   ==== */	AND mcarId = mprodCar
/* ==== que prod existan	   ==== */	AND mprodProd = prodId;									/* Terminan las condiciones y la consulta */

SELECT DISTINCT mcarName as 'Lista de compras' , prodName AS 'Producto'							/*¨Elementos que se mostraran en la consulta */
/* ==== Tablas a consultar	   ==== */	FROM Users, MisProductos, MiCarrito, Producto			/* Las tablas de referencia */
/* ==== con base en las marcas ==== */	WHERE usrUsrname = mcarUsr AND usrUsrname = 'chrisare18'/* Comienzan las condiciones */
/* ==== que prod existan	   ==== */	AND mcarId = mprodCar
/* ==== que prod existan	   ==== */	AND mprodProd = prodId;									/* Terminan las condiciones y la consulta */

select * from producto

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Ram 8gb 3200hz',	815, 5, 5, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Ram 16gb 2666hz',	1300, 5, 5, 3);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Ram 8gb 2666hz',	750, 5, 5, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Ryzen 5 5600X 3.7GHz',	5035, 15, 14, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Ryzen 3 3300X 3.8GHz',	4500, 15, 14, 3);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Teclado Hyperx Origins Core TKL',	2000, 5, 2, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Teclado Razer Huntsman Mini 60%',	2500, 8, 2, 3);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Teclado Corsair K95 RGB PLATINUM',	4000, 5, 2, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Teclado RedDragon Kumara K552 TKL',1015, 17, 2, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Teclado Logitech G213 Prodigy',  698, 6, 2, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Razer Mouse Bungee',  800, 8, 7, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Razer Kiyo Full HD 1080p',  1750, 8, 6, 3);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Cable USB  Lightning 1.8m',  259, 3, 7, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Cable USB  USBtypeC 1.8m',  3, 6, 2, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Elgato HD60 S+ Capturadora',  4250, 11, 7, 3);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Elgato Camlink',  2500, 11, 7, 3);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Kingston SSD A400 512GB',  1815, 10, 4, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Kingston SSD KC3000 1024GB',  3689, 10, 4, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Kingston SSD NV1 500GB',  937, 10, 4, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Corsair iCUE 4000X RGB',  3648, 9, 12, 3);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Corsair Crystal Series 680X RGB',  6134, 9, 12, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Intel Pentium Gold G7400 3.70ghz',    1900, 14, 14, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Intel I3 10100F 3.60ghz',    2000, 14, 14, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Intel I5 12600K 4.90ghz ',    6500, 14, 14, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Intel I7 11700K 5ghz',    8000, 14, 14, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Intel I9 12900KF 5.20ghz ',    14000, 14, 14, 3);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Mousepad Logitech KDA XL 3mm',    1000, 6, 13, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Mousepad Logitech LOL G840 XL 3mm ',    900, 6, 13, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Mousepad Logitech PowerPlay Lightspeed ',    2600, 6, 13, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Mousepad Logitech Studios Series ',    160, 6, 13, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Mousepad Logitech Studios Series XL',    400, 6, 13, 2);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Logitech G Pro X Superlight 25K DPI ',    1500, 6, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Logitech G203 LightSync RGB ',    400, 6, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Logitech G305 ',    700, 6, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Logitech G502 16K DPI ',    1100, 6, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Razer Viper Ultimate Chroma RGB ',    3200, 8, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Razer Viper Mini  ',    700, 8, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Razer Viper 8KHZ Chroma RGB  ',    1100, 8, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'HyperX Haste 59grs  ',    900, 5, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'HyperX PulseFire Raid RGB  ',    1050, 5, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'HyperX PulseFire Surge RGB  ',    800, 5, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Corsair Harpoon RGB Pro  ',    500, 9, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Corsair Katar Pro Wireless ',    850, 9, 3, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Nvidia GeForce GTX 1660 Twin Fan 6gb  ',    7000, 16, 15, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Zotac Nvidia GeForce RTX 3060 12gb GDDR6 ',    12000, 16, 15, 1);
 
INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Zotac Nvidia GeForce RTX 3070 Twin Edge ',    17000, 16, 15, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'MSI Nvidia GeForce RTX 3080 10gb  ',    21000, 16, 15, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Msi Nvidia GeForce RTX 3090 24gb OC',    47000, 16, 15, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Apple Iphone 13 Pro 128gb ',    26000, 1, 11, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Apple Iphone 13 Pro Max 128gb ',    29000, 1, 11, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Monitor Asus Rog 240hz IPS',    10000, 12, 1, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Monitor Hp Omen 240hz IPS',    11000, 12, 1, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Meta Quest 2 128gb',    8000, 4, 7, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Samsung Galaxy Z Flip 3',    19000, 7, 11, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Logitech C920 HD ',    1100, 6, 6, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Logitech C922 HD ',    1500, 6, 6, 1);

INSERT INTO Producto(prodName,prodPrice,prodMarc,prodDpto,prodSuc) VALUES(
'Logitech StreamCam  ',    2100, 6, 6, 1);

