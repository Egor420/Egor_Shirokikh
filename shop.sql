BEGIN;

CREATE TABLE shop (
   id serial,
   city varchar(255),
   street varchar(255),
   house_number varchar(255),
   latitude varchar(255),
   longitude varchar(255),
   date_open varchar(255),
   date_close varchar(255),
   CONSTRAINT shop_id PRIMARY KEY (id)
);

CREATE TABLE department (
    id serial,
    name varchar(255),
    CONSTRAINT department_id PRIMARY KEY (id)
);

CREATE TABLE division (
    id serial,
    name varchar(255),
    description varchar(255),
    date_start varchar(255),
    department_id integer REFERENCES department,
    CONSTRAINT division_id PRIMARY KEY (id)
);

CREATE TABLE employee (
    id serial,
    name varchar(255),
    surname varchar(255),
    second_name varchar(255),
    shop_id integer REFERENCES shop,
    division_id integer REFERENCES division,
    date_start varchar(255),
    date_finish varchar(255),
    CONSTRAINT employee_id PRIMARY KEY (id)
);

CREATE TABLE schedule (
    start_time varchar(255),
    finish_time varchar(255),
    employee_id integer REFERENCES employee
);

CREATE TABLE provider (
    id serial,
    name varchar(255),
    address varchar(255),
    contact_information varchar(255),
    CONSTRAINT provider_id PRIMARY KEY(id)
);

CREATE TABLE product (
id serial,
name varchar(255),
CONSTRAINT product_id PRIMARY KEY(id)
);

CREATE TABLE product_description (
    product_id integer REFERENCES product,
    product_Adjective varchar(255),
    product_Material varchar(255)
);

CREATE TABLE provider_product (
    id serial,
    provider_id integer REFERENCES provider,
    product_id integer REFERENCES priduct,
    price varchar(255),
    CONSTRAINT provider_product_id PRIMARY KEY (id)
);

CREATE TABLE delivery (
    id serial,
    employee_id integer REFERENCES employee,
    shop_id integer REFERENCES shop,
    provider_product_id integer REFERENCES provider_product,
    amount integer,
    CONSTRAINT delivery_id PRIMARY KEY(id)
);

CREATE TABLE shop_product (
    id serial,
    delivery_id integer REFERENCES delivery,
    price varchar(255),
    amount integer,
    CONSTRAINT shop_product PRIMARY KEY(id)
);

CREATE TABLE client (
    id serial,
    name varchar(255),
    surname varchar(255),
    second_name varchar(255),
    email varchar(255),
    number1 varchar(255)
);

CREATE TABLE discount (
    id serial,
    client_id integer REFERENCES client,
    terms varchar(255),
    amount integer,
    CONSTRAINT discount_id PRIMARY KEY(id)
);

CREATE TABLE discount_shop_product(
    discount_id integer REFERENCES discount,
    shop_product_id integer REFERENCES shop_product
);

CREATE TABLE discount_history (
    discount_id integer REFERENCES discount,
    date_start varchar(255),
    date_finish varchar(255)
);

CREATE TABLE price_history (
    shop_product_id ineger REFERENCES shop_product,
    date_start varchar(255),
    date_finish varchar(255),
    amount varchar(255)
);

INSERT INTO shop (city, street, house_number, latitude, longitude, date_open, date_close)
VALUES('Priceshire', 'Dach Falls', 9, '-89.6320', '25.7563', '2019-01-19T02:26:16.393Z','2030-02-11T02:12:37.624Z'),
('Schultzview', 'Dickinson Highway', 15, '8.4757', '131.1437', '2017-09-25T22:27:30.335Z','null'),
('Paxtonport', 'Lang Hill', 96, '-13.9627', '173.3577', '2017-05-30T10:04:42.098Z','2023-07-08T14:19:20.218Z'),
('Port Belle', 'Shana Summit', 14, '-63.5741', '-90.0858', '2011-10-09T19:31:09.966Z','2024-08-03T00:15:46.203Z'),
('Ziemannside', 'Predovic Vista', 12, '-75.2353', '31.3053', '2015-03-21T07:57:49.079Z','2029-12-16T12:44:29.488Z'),
('South Providenci', 'Bartoletti Pass', 98, '13.8208', '-113.2783', '2015-02-18T20:09:45.114Z','2026-11-21T20:58:00.921Z'),
('West Deron', 'Cleora Parks', 30, '76.5710', '-45.2784', '2016-10-23T18:50:07.368Z','2021-05-05T09:59:37.848Z'),
('Koelpintown', 'Beer Haven', 56, '54.9307', '-110.2043', '2014-06-20T21:17:51.427Z','2022-02-09T15:39:10.457Z'),
('Bereniceview', 'Richie Pines', 22, '34.6589', '145.6818', '2016-01-30T13:42:14.434Z','2023-08-21T19:53:40.176Z'),
('Celinechester', 'Okuneva Neck', 4, '60.1087', '-4.3427', '2011-04-30T10:52:46.008Z','2024-10-09T12:27:42.349Z');

INSERT INTO department (name)
VALUES('e-business'),
('technologies'),
('web-readiness');

INSERT INTO division (name, description, date_start, department_id)
VALUES('capability', 'static', '2019-07-29T13:25:02.637Z', 1),
('infrastructure', 'upward-trending', '2017-08-18T20:38:07.799Z', 3),
('middleware', 'executive', '2015-06-19T15:49:42.417Z', 3),
('open system', 'maximized', '2015-03-06T13:54:25.452Z', 3),
('adapter', 'attitude-oriented', '2011-11-21T23:07:08.387Z', 3),
('algorithm', 'empowering', '2019-10-10T13:18:49.768Z', 1);

INSERT INTO employee (name, surname, second_name, shop_id, division_id, date_start, date_finish)
VALUES('Bo', 'Nikolaus', 'Chauncey', null, 5, '2014-05-17T07:27:48.264Z', 'null'),
('Nikki', 'Stark', 'Chase', 9, null, '2016-12-14T02:21:27.820Z', '2022-06-09T02:53:57.495Z'),
('Rickey', 'Hermann', 'Jerad', 2, null, '2011-07-25T15:37:01.311Z', 'null'),
('Arch', 'Roob', 'Meggie', 3, null, '2013-09-19T03:46:49.195Z', 'null'),
('Emmitt', 'Wiza', 'Susanna', null, 1, '2019-05-24T22:45:26.736Z', '2026-12-11T05:30:32.202Z'),
('Dessie', 'McKenzie', 'Cindy', 6, null, '2018-09-06T02:16:28.608Z', 'null'),
('Mckenzie', 'Tremblay', 'Kassandra', 9, null, '2012-10-19T23:04:33.713Z', 'null'),
('Arnaldo', 'Runolfsson', 'Thea', 6, null, '2018-04-06T21:35:19.078Z', '2021-10-23T11:11:03.018Z'),
('Tressie', 'Cronin', 'Martina', 6, null, '2019-07-24T04:42:16.991Z', '2029-08-28T08:14:54.848Z'),
('Gerardo', 'Bogan', 'Zachariah', 2, null, '2011-01-31T13:27:36.214Z', '2027-06-13T06:41:28.490Z'),
('Blanca', 'Bosco', 'Rickey', 3, null, '2020-03-29T12:23:18.000Z', '2022-04-27T20:56:17.774Z'),
('Kira', 'Feest', 'Tania', 10, null, '2011-10-25T00:56:02.001Z', '2023-09-28T05:03:09.073Z'),
('Louisa', 'Hermann', 'Lyda', 4, null, '2017-09-05T12:08:37.603Z', '2021-04-01T21:58:29.230Z'),
('Jeanette', 'Wilderman', 'Jaunita', 2, null, '2010-12-20T05:58:11.932Z', '2026-08-31T03:07:42.274Z'),
('Destany', 'Von', 'Frances', 6, null, '2020-04-20T05:59:03.268Z', '2022-11-10T00:39:45.044Z'),
('Furman', 'Kerluke', 'Dereck', 4, null, '2012-06-06T07:01:32.661Z', 'null'),
('Assunta', 'Rempel', 'Kyle', null, 2, '2015-12-22T10:48:28.680Z', 'null'),
('Harmon', 'Gusikowski', 'Ernestine', 2, null, '2011-04-07T00:34:45.636Z', '2023-09-19T23:50:43.476Z'),
('Sophia', 'Williamson', 'Nina', 5, null, '2014-04-19T18:53:54.065Z', '2029-03-14T00:28:18.465Z'),
('Maude', 'Cormier', 'Maximus', 2, null, '2019-05-23T07:12:55.159Z', '2030-01-20T00:47:10.596Z');

INSERT INTO schedule (start_time, finish_time, employee_id)
VALUES('8:00', '17:00', 0),
('8:00', '17:00', 1),
('8:00', '17:00', 2),
('8:00', '17:00', 3),
('8:00', '17:00', 4),
('8:00', '17:00', 5),
('8:00', '17:00', 6),
('8:00', '17:00', 7),
('8:00', '17:00', 8),
('8:00', '17:00', 9),
('8:00', '17:00', 10),
('8:00', '17:00', 11),
('8:00', '17:00', 12),
('8:00', '17:00', 13),
('8:00', '17:00', 14),
('8:00', '17:00', 15),
('8:00', '17:00', 16),
('8:00', '17:00', 17),
('8:00', '17:00', 18),
('8:00', '17:00', 19);

INSERT INTO provider (name, address, contact_information)
VALUES('Bahringer LLC', '37036 Rickey Pines', '591.801.3247 x96633'),
('VonRueden LLC', '741 Crist Skyway', '(133) 279-0849'),
('Nolan - Moore', '786 Rocky Flats', '675-731-7489'),
('Bruen Group', '063 Purdy Plains', '955.314.6893'),
('Christiansen and Sons', '4995 Block Centers', '(255) 409-8394 x56002'),
('Keeling, Tromp and Reinger', '25941 Soledad Drive', '(461) 402-9351 x38439'),
('Weissnat Inc', '4715 Schimmel Falls', '1-441-799-9788'),
('Pagac and Sons', '68403 Davonte Landing', '000.117.9872 x648'),
('Sporer Inc', '795 Hand Mission', '858.554.5295'),
('Monahan - Barrows', '82033 Aron Wells', '1-908-894-0828 x823');

INSERT INTO product (name)
VALUES('Fish'),
('Chicken'),
('Tuna'),
('Sausages'),
('Car'),
('Pants'),
('Hat'),
('Chair'),
('Chicken'),
('Chips');

INSERT INTO product_description (product_id, product_Adjective, product_Material)
VALUES(5,'Unbranded','Metal'),
(6,'Small','Frozen'),
(3,'Unbranded','Soft'),
(8,'Unbranded','Fresh'),
(4,'Intelligent','Cotton'),
(9,'Awesome','Metal'),
(1,'Ergonomic','Fresh'),
(8,'Rustic','Frozen'),
(5,'Incredible','Granite'),
(10,'Rustic','Steel'),
(9,'Awesome','Plastic'),
(5,'Refined','Wooden'),
(3,'Intelligent','Steel'),
(7,'Ergonomic','Concrete'),
(9,'Handmade','Granite'),
(5,'Awesome','Granite'),
(7,'Ergonomic','Granite'),
(7,'Tasty','Frozen'),
(7,'Practical','Rubber'),
(8,'Practical','Concrete');

INSERT INTO provider_product (provider_id, product_id, price, amount)
VALUES(8,3,'888.00', 50),
(10,1,'310.00', 16),
(2,3,'393.00', 78),
(2,10,'456.00', 50),
(8,4,'577.00', 85),
(2,4,'855.00', 75),
(9,6,'978.00', 77),
(4,1,'140.00', 39),
(10,1,'843.00', 45),
(3,4,'618.00', 42);

INSERT INTO delivery (employee_id, shop_id, provider_product_id, amount)
VALUES(14, 6, 5, 35),
(7, 2, 5, 32),
(14, 10, 4, 82),
(13, 9, 9, 22),
(2, 10, 9, 49),
(11, 1, 10, 54),
(12, 2, 6, 60),
(19, 1, 8, 61),
(4, 2, 9, 87),
(16, 10, 3, 79),
(9, 4, 5, 18),
(11, 1, 4, 11),
(12, 9, 10, 55),
(5, 6, 5, 72),
(19, 10, 9, 1),
(15, 3, 6, 44),
(9, 3, 8, 15),
(13, 9, 4, 40),
(17, 5, 8, 95),
(10, 1, 4, 34);

INSERT INTO shop_product (delivery_id, price, amount)
VALUES(16, '680.00', 72),
(14, '500.00', 23),
(1, '612.00', 98),
(7, '64.00', 12),
(4, '326.00', 46),
(20, '453.00', 28),
(18, '227.00', 58),
(10, '86.00', 69),
(12, '532.00', 27),
(17, '655.00', 32),
(3, '602.00', 45),
(7, '645.00', 37),
(17, '648.00', 29),
(11, '826.00', 48),
(5, '638.00', 53),
(17, '242.00', 62),
(7, '210.00', 55),
(5, '559.00', 82),
(12, '423.00', 43),
(17, '476.00', 40);

INSERT INTO client (name, surname, second_name, email, number)
VALUES('Darius', 'Doyle', 'Alexane', 'Alejandra82@hotmail.com', '668.720.6180'),
('Sophie', 'White', 'Naomi', 'Celine95@hotmail.com', '(483) 730-9058'),
('Katlyn', 'Corkery', 'Aryanna', 'Berniece_Mitchell6@gmail.com', '(180) 938-1376 x426'),
('Alexie', 'Gusikowski', 'Harrison', 'Della.Carroll27@gmail.com', '(028) 617-2132 x058'),
('Kristian', 'Brown', 'Donnell', 'Keira.Klocko@gmail.com', '1-944-020-1981 x81339'),
('Sally', 'Daugherty', 'Amiya', 'Cole.Weissnat@gmail.com', '(558) 974-7609 x9031'),
('Mara', 'Dooley', 'Ryley', 'Orpha.Bartell@gmail.com', '244-473-2582 x85399'),
('Chance', 'Balistreri', 'Marilie', 'Vivienne41@yahoo.com', '529.696.7031 x87702'),
('Wilhelm', 'Beatty', 'Octavia', 'Bertrand.Smitham@yahoo.com', '374-043-0013'),
('Myles', 'Sawayn', 'Xavier', 'Robbie.Balistreri@yahoo.com', '(287) 057-6304');

INSERT INTO discount (client_id, terms, amount)
VALUES(7, '449.00', 230),
(6, '983.00', 161),
(7, '578.00', 120),
(1, '938.00', 183),
(6, '324.00', 151),
(10, '988.00', 146),
(1, '192.00', 16),
(5, '339.00', 107),
(4, '806.00', 25),
(5, '485.00', 82);

INSERT INTO discount (client_id, terms, amount)
VALUES(9, 0, '2015-12-07T10:43:26.799Z', '2021-09-18T04:05:19.989Z'),
(13, 1, '2015-11-19T19:42:54.708Z', '2026-01-16T08:18:59.334Z'),
(14, 2, '2012-07-26T05:30:30.203Z', '2020-06-13T04:35:33.826Z'),
(3, 3, '2015-06-27T16:31:33.095Z', '2022-07-08T13:25:45.100Z'),
(20, 4, '2011-07-01T08:03:22.854Z', 'null'),
(3, 5, '2018-05-06T10:05:00.860Z', '2022-03-30T07:20:04.854Z'),
(1, 6, '2020-03-26T22:07:03.722Z', '2025-02-16T13:16:13.604Z'),
(16, 7, '2020-05-07T09:30:12.591Z', '2022-04-18T16:37:32.793Z'),
(4, 8, '2012-08-11T22:56:47.735Z', '2021-12-02T18:31:13.141Z'),
(13, 9, '2015-12-26T20:01:54.508Z', 'null');

INSERT INTO discount_history (discount_id, date_start, date_finish)
VALUES(0, '2014-03-23T05:18:45.732Z', '2023-04-23T11:49:45.559Z'),
(1, '2020-01-27T07:59:24.613Z', '2022-02-14T01:08:51.633Z'),
(2, '2010-07-02T06:34:08.638Z', 'null'),
(3, '2014-07-15T23:37:05.059Z', 'null'),
(4, '2014-02-16T16:39:15.877Z', '2025-12-20T05:51:06.457Z'),
(5, '2010-12-04T02:28:08.449Z', '2029-06-20T13:45:52.379Z'),
(6, '2018-12-20T18:11:37.990Z', 'null'),
(7, '2017-04-02T03:58:08.097Z', '2028-01-30T09:54:13.735Z'),
(8, '2019-06-27T04:57:58.238Z', '2028-11-18T03:46:13.951Z'),
(9, '2012-09-01T11:00:32.114Z', '2021-01-14T13:15:25.474Z');

INSERT INTO price_history (shop_product_id, date_start, date_finish, amount)
VALUES(0, '2014-01-07T01:10:45.615Z', 'null', '793.00'),
(1, '2013-02-09T14:57:37.934Z', '2029-09-27T21:04:24.333Z', '104.00'),
(2, '2011-07-08T13:35:31.583Z', '2028-01-07T16:21:54.966Z', '93.00'),
(3, '2013-03-11T16:50:03.813Z', '2027-08-30T07:56:13.022Z', '280.00'),
(4, '2017-10-04T05:23:26.886Z', '2029-08-15T01:14:24.231Z', '858.00'),
(5, '2014-06-13T21:23:51.736Z', '2026-03-13T12:23:38.051Z', '452.00'),
(6, '2011-09-01T23:07:31.348Z', '2022-08-11T02:49:28.433Z', '477.00'),
(7, '2015-11-30T08:43:02.439Z', '2022-12-23T14:12:16.328Z', '103.00'),
(8, '2011-12-10T19:38:53.609Z', 'null', '381.00'),
(9, '2012-05-10T07:06:47.003Z', '2020-06-06T07:01:36.541Z', '150.00');

COMMIT;