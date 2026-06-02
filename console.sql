
CREATE TABLE IF NOT EXISTS contractor (
                            contractor_id int PRIMARY KEY,
                            name_contractor VARCHAR(50) NOT NULL,
                            inn int NOT NULL,
                            address VARCHAR(100) NULL,
                            number_phone varchar(20) not null
);
CREATE TABLE IF NOT EXISTS category (
                                        category_id INT PRIMARY KEY,
                                        name_category varchar(64) not null
);


CREATE TABLE IF NOT EXISTS product (
                                       product_id INT PRIMARY KEY,
                                       name_product varchar(64) not null,
                                       price decimal(10,2) not null,
                                       category_id int,
                                       FOREIGN KEY (category_id) REFERENCES category (category_id)
);


CREATE TABLE IF NOT EXISTS  specification (
                                              specification_id INT PRIMARY KEY,
                                              product_id int,
                                              FOREIGN KEY (product_id) REFERENCES product (product_id),
                                              quantity int not null,
                                              contractor_id int,
                                              FOREIGN KEY (contractor_id) REFERENCES contractor (contractor_id),
                                              unit_of_measurement char(10) not null
);

CREATE TABLE IF NOT EXISTS production (
                            production_id INT PRIMARY KEY,
                            specification_id int,
                            FOREIGN KEY (specification_id) REFERENCES specification (specification_id),
                            code int not null
);


CREATE TABLE IF NOT EXISTS customerr(
    customer_id INT PRIMARY KEY,
     name varchar(50) not null,
     inn int not null,
    address VARCHAR(100) NULL,
    number_phone varchar(20) not null
);

CREATE TABLE IF NOT EXISTS  customer_order (
    customer_order_id INT PRIMARY KEY,
    specification_id INT,
    foreign key (specification_id) references specification (specification_id),
    contractor_id int,
    foreign key (contractor_id) references contractor (contractor_id),
    production_id INT,
    foreign key (production_id) references production (production_id),
    customer_id INT,
    foreign key (customer_id) references customerr (customer_id),
    product_id INT,
    foreign key (product_id) references product (product_id)
);

insert into contractor (contractor_id, name_contractor, inn, address, number_phone)
values
(1, 'ООО "тмыв"', '123456', 'ул.Успеха., д.13', '89990987865'),
(2, 'ЗАО "тмывом к нам"', '908876', 'ул.Водная., д9', '87776664567'),
(3, 'ООО "Успешный успех"', '234567', 'ул.Неудач., д.13', '86665674335');

insert into category (category_id, name_category)
values
(1, 'молочная продукция'),
(2, 'мясная продукция'),
(3, 'хлебная прдукция');

insert into product (product_id, name_product, price, category_id)
values
(1, 'Молоко', 100, 1),
(2, 'Хлеб белый', 50, 3),
(3, 'Мясо курицы', 500, 2);


insert into specification (specification_id, product_id, quantity, contractor_id, unit_of_measurement)
values
(1, 1, 4, 1, 'л'),
(2, 2, 5, 2, 'кг'),
(3, 3, 6, 3, 'кг');

insert into production (production_id, specification_id, code)
values
(1, 1, 1234),
(2, 2, 5678),
(3, 3, 6668);


insert into customerr (customer_id, name, inn, address, number_phone)
values
(1, 'ООО "тличкик"', '149325', 'ул.Кокетка., д3', '89992314567'),
(2, 'ПАО "Прайм"', '890785', 'ул.Неудача., д99', '89992314567'),
(3, 'ООО "Круто"', '567432', 'ул.Звезд., д.666', '89992314567');

insert into customer_order (customer_order_id, specification_id, contractor_id, production_id, customer_id, product_id)
VALUES
(1, 1, 1, 1, 1, 1),
(2, 2, 2, 2, 2, 2),
(3, 3, 3, 3, 3, 3);



select * from contractor;
select * from category;
select * from product;
select * from specification;
select * from production;
select * from customerr;
select * from customer_order;

create type genre as enum ('Триллер', 'Романтика', 'Драма', 'Комедия', 'Антиутопия', 'Приключения');
create type status_book as enum ('Выдана', 'Возвращена');

create table if not exists Данные_читателя (
    "Код_читателя" serial primary key,
    "Фамилия" varchar(64) not null,
    "Имя" varchar(64) not null,
    "Отчество" varchar(64) null,
    "Пол" char(1) check("Пол" in ('Ж', 'М')),
    "Дата рождения" date not null,
    "Домашний номер телефона" varchar(20) null,
    "Рабочий номер телефона" varchar(20) not null,
    "Домашний адрес" varchar(64) not null,
    "Почта" varchar(64) not null
);

create table if not exists Карточка_книги (
    "Код карточки книги" serial primary key,
    "Код каталога" int,
    foreign key ("Код каталога") references Каталог ("Код каталога"),
    "Библиотечный код" int not null unique,
    "Название книги" varchar(128) not null,
    "Описание книги" text not null,
    "Автор книги" varchar(64) not null,
    "Год выпуска" date not null,
    "Жанр" genre
);

create table if not exists Карточка_читателя (
    "Карточка читателя" serial primary key,
    "Код карточки книги" int,
    foreign key ("Код карточки книги") references Карточка_книги ("Код карточки книги"),
    "Статус" status_book
);

create table if not exists Читатель (
    "Код читателя" serial primary key,
    "Карточка читателя" int,
    foreign key ("Карточка читателя") references Карточка_читателя ("Карточка читателя"),
    "Код_читателя" int,
    foreign key ("Код_читателя") references Данные_читателя ("Код_читателя")
);

create table if not exists Тип_каталога (
    "Тип каталога" serial primary key ,
    "Название типа каталога" varchar(64 ) not null,
    "Тема книги" varchar(64) not null
);

create table if not exists Каталог (
   "Код каталога" serial primary key,
   "Тип каталога" int,
   foreign key ("Тип каталога") references Тип_каталога ("Тип каталога")
);


select * from "Данные_читателя";
select * from "Тип_каталога";
select * from "Каталог";
select * from "Читатель";
select * from "Карточка_читателя";
select * from "Карточка_книги";


insert into Данные_читателя ("Фамилия", "Имя", "Отчество", "Пол", "Дата рождения", "Домашний номер телефона", "Рабочий номер телефона", "Домашний адрес", "Почта")
values
    ('Иванов', 'Иван', 'Иванович', 'М', '1999-09-09', '89998887654', '89074567889', 'ул.Успеха, д.8, кв.89', 'ivan679@gmail.com'),
    ('Артемов', 'Артем', 'Артемович', 'М', '2000-06-06', '89633655212', '89451233656', 'ул.Печали, д.13, кв.2', 'artem89047@gmail.com'),
    ('Чернышев', 'Елесей', 'Петрович', 'М', '2006-12-09', '87955648789', '84563652141', 'ул.Жизни, д.9, кв.6', 'elesei345@gmail.com');


insert into Тип_каталога ("Название типа каталога", "Тема книги")
values
('Классическая литература', 'Биография писателей'),
('Фантастика', 'Другие миры'),
('Триллер', 'Расследования преступлений');

insert into Каталог ("Тип каталога")
values
('1'),
('2'),
('3');

insert into Карточка_книги ("Код каталога", "Библиотечный код", "Название книги", "Описание книги", "Автор книги", "Год выпуска", "Жанр")
values
('1', '123', 'Исчезнувшая', 'Эми Данн загадочно исчезла в пятую годовщину свадьбы', 'Гиллиан Флинн', '2012-09-09', 'Триллер'),
('2', '234', 'Молчание ягнят', 'психологический триллер о курсантке ФБР, которая, должна поймать серийного убийцу', 'Томас Харрис', '1998-09-09', 'Триллер'),
('3', '345', 'Безмолвный пациент', 'психологический триллер о художнице Алисии Беренсон, которая застрелила мужа и замолчала навсегда.', 'Алекс Михаэлидес', '2019-09-09', 'Триллер');


insert into Читатель ("Карточка читателя", "Код читателя")
values
('1', '1'),
('2', '2'),
('3', '3');

insert into Карточка_читателя ("Код карточки книги", "Статус")
values
('1', 'Выдана'),
('2', 'Выдана'),
('3', 'Выдана');


create table if not exists Поставщики (
    код_поставщика serial primary key,
    название_фирмы_поставщика varchar(64) not null,
    адрес varchar(64) not null,
    телефон varchar(20) not null
);

create table if not exists Покупатели (
      код_покупателя serial primary key,
      название_фирмы_покупателя varchar(64) not null,
      адрес varchar(64) not null,
      телефон varchar(20) not null
);

create table if not exists Товары_на_складе (
    код_товара serial primary key,
    код_поставщика int,
    foreign key (код_поставщика) references Поставщики (код_поставщика),
    название_товара varchar(64) not null,
    единица_измерения varchar(5) not null,
    кол_во_товара int not null,
    цена_покупки_за_ед decimal(10, 2) not null,
    цена_продажи_за_ед decimal(10, 2) not null
);

create table if not exists Сделки_о_продаже (
    код_сделки serial primary key,
    код_товара int,
    foreign key (код_товара) references Товары_на_складе (код_товара),
    код_поставщика int,
    foreign key (код_поставщика) references Поставщики (код_поставщика),
    код_покупателя int,
    foreign key (код_покупателя) references Покупатели (код_покупателя),
    кол_во_проданного_товара int not null,
    сумма decimal(10,2)
);

select * from Поставщики;
select * from Покупатели;
select * from Товары_на_складе;
select * from Сделки_о_продаже;

/*drop table Поставщики, Покупатели, Товары_на_складе, Сделки_о_продаже;*/

insert into Поставщики (название_фирмы_поставщика, адрес, телефон)
values
('ООО "Мебельная Фабрика"','ул.Живая, д.15', '88005553555'),
('ООО "Строим будущее"', 'ул.Строителей, д.55', '89123655636'),
('ООО "Днако"', 'ул.Гоголя, д.3', '87966541220'),
('ООО "Орхидея"', 'ул.Садовая, д.9', '85632158596'),
('ООО "Динозавры"', 'ул.Рептилий, д.87', '84520122459');

insert into Покупатели (название_фирмы_покупателя, адрес, телефон)
values
('ООО "Вторая жизнь"', 'ул.Шанс, д.3', '89331236545'),
('ООО "Витязь"', 'ул.Вязов, д.13', '89635201414'),
('ООО "Маяк"', 'ул.Морская, л.18', '83025699512'),
('ООО "Викинги"', 'ул.Скандинавская, д.13', '89996663322'),
('ООО "Динамо"', 'ул.Ледовая, д.9', '84566665225');

insert into Товары_на_складе (код_поставщика, название_товара, единица_измерения, кол_во_товара, цена_покупки_за_ед, цена_продажи_за_ед)
values
(1, 'Огурец', 'кг', 5, 100, 190),
(2, 'Доски деревянные', 'шт', 7, 900, 1400),
(3, 'Обои рулонные', 'шт', 100, 1400, 1600),
(4, 'Орхидея в горшке', 'шт', 50, 1500, 1900),
(5, 'Игрушка динозавр', 'шт', 900, 500, 800);

insert into Сделки_о_продаже (код_товара, код_поставщика, код_покупателя, кол_во_проданного_товара, сумма)
values
(1, 1, 1, 2, 380),
(2, 2, 2, 4, 5600),
(3, 3, 3, 60, 96000),
(4, 4, 4, 34, 64600),
(5, 5, 5, 80, 64000);

select * from Товары_на_складе where код_поставщика = 5;
select * from Товары_на_складе where название_товара = 'Орхидея в горшке';


select * from Сделки_о_продаже;

/*запрос к системе*/
select
    код_товара,
    sum(кол_во_проданного_товара) as общее_количество_проданного
from
    Сделки_о_продаже
group by
    код_товара
order by
    общее_количество_проданного desc
limit 1;



/*=================================================================*/
create type plane_type as enum ('Пассажирский', 'Грузовой', 'Специальный');
create type class_type as enum ('Эконом', 'Бизнес');

create table if not exists Самолет (
    самолет_id serial primary key,
    название_самолета varchar(64) not null,
    тип_самолета plane_type,
    кол_во_мест int not null,
    технич_характеристики text null
);

create table if not exists Рейс (
    рейс_id serial primary key,
    самолет_id int,
    foreign key (самолет_id) references Самолет (самолет_id),
    пункт_отправления varchar(64) not null,
    пункт_назначения varchar(64) not null,
    дата_и_время_вылета timestamp not null
);

create table if not exists Паспорт3 (
    паспорт_id serial primary key,
    серия varchar(4) not null,
    номер varchar(6) not null
);

create table if not exists Класс (
    класс_id serial primary key,
    название_класса class_type,
    стоимость_билета decimal(10, 2)
);

create table if not exists Инф_пассажирах (
    пассажир_id serial primary key,
    рейс_id int,
    foreign key (рейс_id) references Рейс (рейс_id),
    класс_id int,
    foreign key (класс_id) references Класс (класс_id),
    паспорт_id int,
    foreign key (паспорт_id) references Паспорт3 (паспорт_id),
    фамилия varchar(64) not null,
    имя varchar(64) not null,
    отчество varchar(64) null,
    дата_рождения date not null ,
    номер_места int unique not null
);

select * from Паспорт3;
select * from Класс;
select * from Инф_пассажирах;
select * from Рейс;
select * from Самолет;


insert into Самолет ( название_самолета, тип_самолета, кол_во_мест, технич_характеристики)
values
('Boeing 787-10', 'Пассажирский', 440, 'Первой моделью Dreamliner стал B787-8, который имеет длину 56,7 метра и может вмещать до 381 пассажира. Через два года была представлена модель B787-9, длина которой составляет 62,81 метра, а предельная вместимость — 420 пассажиров.'),
('Airbus A350-900', 'Пассажирский', 440, 'Airbus A350 — дальнемагистральный пассажирский самолет, способный преодолевать расстояние до 15 000 км. Он конкурирует на рынке с самолетами серии 777, а также с новейшим Boeing 777X. Крупнейшим оператором модели A350-900 является авиакомпания Singapore Airlines, среди других значимых пользователей — Cathay Pacific, Qatar Airways и Air France.'),
('Airbus A330-300', 'Пассажирский', 440, 'Airbus A330-300 - широкофюзеляжный самолет, поступивший в эксплуатацию 2 ноября 1992 года. A330-300 самый большой из двухмоторных A330, он был разработан для замены Airbus A300. '),
('Airbus A340-300/600', 'Пассажирский', 440, ''),
('Airbus A330-900', 'Пассажирский', 460, 'Модель -900, являющаяся более крупной версией, совершила свой первый полет в октябре 2017 года и получила сертификат типа в ноябре 2018 года.');


insert into Рейс (самолет_id, пункт_отправления, пункт_назначения, дата_и_время_вылета)
values
(1, 'Томск', 'Москва', '2026-03-25 18:45:02'),
(2, 'Томск', 'Екатеринбург', '2026-03-25 09:45:02'),
(3, 'Томск', 'Новосибирск', '2026-03-25 15:45:02'),
(4, 'Томск', 'Тюмень', '2026-03-25 21:45:02'),
(5, 'Томск', 'Иркутск', '2026-03-25 14:45:02');


insert into Паспорт3 (серия, номер)
values
('1122', '111222'),
('2233', '222333'),
('3344', '333444'),
('4455', '444555'),
('5566', '555666');

insert into Класс (название_класса, стоимость_билета)
values
('Бизнес', '89000'),
('Эконом', '14000'),
('Бизнес', '80000'),
('Эконом', '25000'),
('Бизнес', '50000');


insert into Инф_пассажирах (рейс_id, класс_id, паспорт_id, фамилия, имя, отчество, дата_рождения, номер_места)
values
(1, 1, 1, 'Иванов', 'Иван', 'Иванович', '2006-02-11', 56),
(2, 2, 2, 'Кузнецов', 'Александр', 'Александрович', '2000-01-01', 89),
(3, 3, 3, 'Прохор', 'Шаляпин', '', '1999-12-09', 45),
(4, 4, 4, 'Медведьев', 'Дмитрий', 'Иванович', '1998-09-09', 100),
(5, 5, 5, 'Успенская', 'Любовь', 'Васильевна', '2007-09-04', 178);



/*рейс 7 дней*/

SELECT
    рейс_id,
    пункт_отправления,
    пункт_назначения,
    дата_и_время_вылета,
    самолет_id
FROM Рейс
WHERE дата_и_время_вылета >= CURRENT_TIMESTAMP
  AND дата_и_время_вылета <= CURRENT_TIMESTAMP + INTERVAL '7 days'
ORDER BY дата_и_время_вылета;




WITH занятые_места AS (
    SELECT COUNT(*) AS занятые
    FROM Инф_пассажирах
    WHERE рейс_id = 1
)
SELECT
    Самолет.кол_во_мест - занятые_места.занятые AS свободные_места
FROM Самолет
         JOIN Рейс ON Самолет.самолет_id = Рейс.самолет_id
         CROSS JOIN занятые_места
WHERE Рейс.рейс_id = 1;


SELECT
    И.пассажир_id,
    И.фамилия,
    И.имя,
    И.отчество,
    И.дата_рождения,
    И.номер_места,
    К.название_класса,
    К.стоимость_билета
FROM Инф_пассажирах И
         JOIN Класс К ON И.класс_id = К.класс_id
WHERE И.рейс_id = 1
ORDER BY И.номер_места;


SELECT
    COUNT(*) AS количество_пассажиров,
    SUM(К.стоимость_билета) AS общая_стоимость,
    AVG(К.стоимость_билета) AS средняя_стоимость
FROM Инф_пассажирах И
         JOIN Класс К ON И.класс_id = К.класс_id
WHERE И.рейс_id = 1;


SELECT
    COUNT(*) AS общее_количество_пассажиров
FROM Инф_пассажирах И
         JOIN Рейс Р ON И.рейс_id = Р.рейс_id
WHERE Р.дата_и_время_вылета BETWEEN '2026-03-01' AND '2026-03-31';



WITH загруженность_рейсов AS (
    SELECT
        Р.рейс_id,
        Р.пункт_отправления,
        Р.пункт_назначения,
        COUNT(И.пассажир_id) AS пассажиров_на_рейсе,
        С.кол_во_мест
    FROM Рейс Р
             JOIN Самолет С ON Р.самолет_id = С.самолет_id
             LEFT JOIN Инф_пассажирах И ON Р.рейс_id = И.рейс_id
    GROUP BY Р.рейс_id, Р.пункт_отправления, Р.пункт_назначения, С.кол_во_мест
)
SELECT
    пункт_отправления,
    пункт_назначения,
    ROUND(AVG(пассажиров_на_рейсе * 100.0 / кол_во_мест), 2) AS средняя_загруженность_процентов
FROM загруженность_рейсов
GROUP BY пункт_отправления, пункт_назначения
ORDER BY средняя_загруженность_процентов DESC;




/*=============================*/\
drop type status_number;
create type status_number as enum ('Занят', 'Свободен', 'Чистый', 'Назначен к уборке', 'Грязный');
create type status_number_bron as enum ('Забронирован', 'Свободен');
create type number_type as enum ('Люкс', 'Полулюкс');
create type other_number_type as enum ('Семейный', 'Для одиноких', 'Для пар');


create table if not exists Номер_люкс_полулюкс (
    крутые_номера_id serial primary key,
    тип_номера number_type,
    статус_номера status_number,
    кол_во_комнат int not null,
    этаж int not null,
    телефон varchar(20) not null,
    стоимость_номера_в_сутки decimal(10,2) not null,
    сведения_о_брони status_number_bron,
    кол_во_факт_проживающих int not null
);

create table if not exists Прочий_номер (
    прочий_номер_id serial primary key,
    тип_номера other_number_type,
    кол_во_мест int not null,
    этаж int not null,
    телефон varchar(20) not null,
    стоим_прожив_в_сут_1_чел decimal(10,2) not null,
    кол_во_свобод_мест int not null
);

create table if not exists Номер (
    номер_id serial primary key,
    крутые_номера_id int,
    foreign key (крутые_номера_id) references Номер_люкс_полулюкс (крутые_номера_id),
    прочий_номер_id int,
    foreign key (прочий_номер_id) references Прочий_номер (прочий_номер_id)
);

create table if not exists Паспорт_клиента (
   паспорт_клиента_id serial primary key,
   серия varchar(4) not null,
   номер varchar(6) not null
);

create table if not exists Карточка_регистрации_клиента (
    карточка_регистарции_клиента_id serial primary key,
    паспорт_клиента_id int,
    foreign key (паспорт_клиента_id) references Паспорт_клиента (паспорт_клиента_id),
    номер_id int,
    foreign key (номер_id) references Номер (номер_id),
    фамилия varchar(64) not null,
    имя varchar(64) not null,
    отчество varchar(64) null,
    пол char(1) check("пол" in ('Ж', 'М')),
    дата_рождения date not null,
    дата_прибытия date not null,
    домашний_адрес varchar(64) null,
    номер_телефона_домаш varchar(20) not null
);

create table if not exists Расчетная_карточка (
    рассчетные_карточки_id serial primary key,
    карточка_регистарции_клиента_id int,
    foreign key (карточка_регистарции_клиента_id) references Карточка_регистрации_клиента (карточка_регистарции_клиента_id),
    оплата_брони char(1) check ( "оплата_брони" in ('Д', 'Н')),
    предополог_дата_убытия date null,
    кол_во_оплаченных_дней int null,
    сумма_оплаты decimal(10,2) not null,
    окончательный_расчёт decimal(10,2) null
);

create table if not exists Архив (
    архив_id serial primary key,
    рассчетные_карточки_id int,
    foreign key (рассчетные_карточки_id) references Расчетная_карточка (рассчетные_карточки_id),
    дата_прибытия date not null,
    дата_убытия date not null
);

select * from Карточка_регистрации_клиента;
/*drop  table Паспорт_клиента, Номер,  Прочий_номер, Номер_люкс_полулюкс, Карточка_регистрации_клиента, Расчетная_карточка, Архив;*/
select * from Номер;

insert into Номер_люкс_полулюкс (тип_номера, статус_номера, кол_во_комнат, этаж, телефон, стоимость_номера_в_сутки, сведения_о_брони, кол_во_факт_проживающих)
values ('Люкс', 'Свободен', 4, 6, '4561237895', '50000', 'Свободен', 5);

insert into Прочий_номер (тип_номера, кол_во_мест, этаж, телефон, стоим_прожив_в_сут_1_чел, кол_во_свобод_мест)
values ('Для одиноких', 5, 6, '1234567896', '10000', 0);

insert into Номер (крутые_номера_id, прочий_номер_id)
VALUES (1, 1);

insert into Паспорт_клиента (серия, номер)
VALUES ('2233', '222333');

insert into Карточка_регистрации_клиента (паспорт_клиента_id, номер_id, фамилия, имя, отчество, пол, дата_рождения, дата_прибытия, домашний_адрес, номер_телефона_домаш)
VALUES (1, 2, 'Пупкин', 'Иван', 'Андреевич', 'М', '1999-04-01', '2026-04-01', 'ул.Успеха, дом.2, кв.2', '1564892378');

insert into Расчетная_карточка (карточка_регистарции_клиента_id, оплата_брони, предополог_дата_убытия, кол_во_оплаченных_дней, сумма_оплаты, окончательный_расчёт)
values (2, 'Д', '2026-05-01', 0, '50000', '50000');

insert into Архив (рассчетные_карточки_id, дата_прибытия, дата_убытия)
VALUES (2, '2026-04-01', '2026-05--01');

SELECT
    krc.карточка_регистарции_клиента_id AS "ID клиента",
    krc.фамилия AS "Фамилия",
    krc.имя AS "Имя",
    a.дата_прибытия AS "Дата прибытия (архив)",
    a.дата_убытия AS "Дата убытия (архив)",
    rk.сумма_оплаты AS "Сумма оплаты",
    rk.окончательный_расчёт AS "Окончательный расчёт"
FROM Карточка_регистрации_клиента krc
         JOIN Архив a ON krc.карточка_регистарции_клиента_id = (
    SELECT карточка_регистарции_клиента_id
    FROM Расчетная_карточка
    WHERE рассчетные_карточки_id = a.рассчетные_карточки_id
)
         JOIN Расчетная_карточка rk ON a.рассчетные_карточки_id = rk.рассчетные_карточки_id
WHERE krc.карточка_регистарции_клиента_id = 2;



create type status_number as enum ('Занят', 'Свободен', 'Чистый', 'Назначен к уборке', 'Грязный');

/*drop table Клиент, Номер, Данные_о_номере, Данные_о_номерах_и_клиентах;*/


create table if not exists Клиент (
    client_id serial primary key,
    l_name varchar(64) not null,
    f_name varchar(64) not null,
    patronymic varchar(64) null
);

create table if not exists Номер (
    number_id serial primary key,
    floor varchar(10) not null,
    number_room int not null,
    category_room varchar(128) not null
);

create table if not exists Данные_о_номере (
    data_room serial primary key,
    number_id int,
    foreign key (number_id) references Номер(number_id),
    status_room status_number,
    departure_date date null
);

create table if not exists Данные_о_номерах_и_клиентах (
    data_r_c serial primary key,
    client_id int,
    foreign key (client_id) references Клиент (client_id),
    data_room int,
    foreign key (data_room) references Данные_о_номере(data_room),
    entry_date date
);

select * from Клиент;
select * from Номер;
select * from Данные_о_номере;
select * from Данные_о_номерах_и_клиентах;

insert into Клиент (l_name, f_name, patronymic)
values
    ('Шевченко', 'Ольга', 'Викторовна'),
    ('Мазалова','Ирина', 'Львовна'),
    ('Семеняка','Юрий', 'Геннадьевич'),
    ('Савельев','Олег', 'Иванович'),
    ('Бунин','Эдуард', 'Михайлович'),
    ('Бахшиев','Павел', 'Иннокентьевич'),
    ('Тюренкова','Наталья', 'Сергеевна'),
    ('Любяшева','Галина', 'Аркадьевна'),
    ('Александров','Петр', 'Константинович'),
    ('Мазалова','Ольга', 'Николаевна'),
    ('Лапшин','Виктор', 'Романович'),
    ('Гусев','Семен', 'Петрович'),
    ('Гладилина','Вера', 'Михайловна'),
    ('Масюк','Динара', 'Викторовна'),
    ('Лукин','Илья', 'Федорович'),
    ('Петров','Станислав', 'Игоревич'),
    ('Филь','Марина', 'Федоровна'),
    ('Михайлов','Игорь', 'Вадимович');

insert into Номер (floor, number_room, category_room)
values
    ('1 этаж', 101, 'Одноместный стандарт'),
    ('1 этаж', 102, 'Одноместный стандарт'),
    ('1 этаж', 103, 'Одноместный эконом'),
    ('1 этаж', 104, 'Одноместный эконом'),
    ('1 этаж', 105, 'Стандарт двухместный с 2 раздельными кроватями'),
    ('1 этаж', 106, 'Стандарт двухместный с 2 раздельными кроватями'),
    ('1 этаж', 107, 'Эконом двухместный с 2 раздельными кроватями'),
    ('1 этаж', 108, 'Эконом двухместный с 2 раздельными кроватями'),
    ('1 этаж', 109, '3-местный бюджет'),
    ('1 этаж', 110, '3-местный бюджет'),
    ('2 этаж', 201, 'Бизнес с 1 или 2 кроватями'),
    ('2 этаж', 202, 'Бизнес с 1 или 2 кроватями'),
    ('2 этаж', 203, 'Бизнес с 1 или 2 кроватями'),
    ('2 этаж', 204, 'Двухкомнатный двухместный стандарт с 1 или 2 кроватями'),
    ('2 этаж', 205, 'Двухкомнатный двухместный стандарт с 1 или 2 кроватями'),
    ('2 этаж', 206, 'Двухкомнатный двухместный стандарт с 1 или 2 кроватями'),
    ('2 этаж', 207, 'Одноместный стандарт'),
    ('2 этаж', 208, 'Одноместный стандарт'),
    ('2 этаж', 209, 'Одноместный стандарт'),
    ('3 этаж', 301, 'Студия'),
    ('3 этаж', 302, 'Студия'),
    ('3 этаж', 303, 'Студия'),
    ('3 этаж', 304, 'Люкс с 2 двуспальными кроватями'),
    ('3 этаж', 305, 'Люкс с 2 двуспальными кроватями'),
    ('3 этаж', 306, 'Люкс с 2 двуспальными кроватями');



insert into Данные_о_номере (number_id, status_room, departure_date)
values
    (1, 'Занят', '2025-03-02'),
    (2, 'Занят', null),
    (3, 'Чистый', null),
    (4, 'Занят', '2025-02-02'),
    (5, 'Занят', '2025-03-07'),
    (6, 'Чистый', null),
    (7, 'Занят', '2025-03-17'),
    (8, 'Занят', '2025-03-20'),
    (9, 'Занят', '2025-03-12'),
    (10, 'Занят', '2025-02-02'),
    (11, 'Занят', '2025-03-17'),
    (12, 'Занят', '2025-03-07'),
    (13, 'Чистый', null),
    (14, 'Назначен к уборке', null),
    (15, 'Занят', '2025-03-04'),
    (16, 'Занят', '2025-02-02'),
    (17, 'Занят', '2025-03-04'),
    (18, 'Занят', '2025-03-04'),
    (19, 'Занят', null),
    (20, 'Грязный', null),
    (21, 'Грязный', null),
    (22, 'Чистый', null),
    (23, 'Занят', '2025-03-15'),
    (24, 'Чистый', null),
    (25, 'Занят', null);


INSERT INTO Данные_о_номерах_и_клиентах (client_id, data_room, entry_date)
VALUES
    (1, 1, '2025-02-14'),
    (2, 2, '2025-02-28'),
    (3, 4, '2025-02-23'),
    (4, 5, '2025-03-01'),
    (5, 7, '2025-02-27'),
    (6, 7, '2025-02-24'),
    (7, 8, '2025-02-15'),
    (8, 9, '2025-02-27'),
    (9, 10, '2025-02-14'),
    (10, 11, '2025-02-24'),
    (11, 13, '2025-02-25'),
    (12, 15, '2025-03-01'),
    (13, 16, '2025-02-02'),
    (14, 17, '2025-02-25'),
    (15, 18, '2025-02-25'),
    (16, 19, '2025-02-27'),
    (17, 23, '2025-02-28'),
    (18, 25, '2025-02-11');



SELECT COUNT(*) AS total_rooms FROM Номер;

WITH проданные_ночи AS (
    SELECT
        SUM(
                CASE
                    WHEN don.departure_date IS NOT NULL
                        THEN GREATEST(0, (don.departure_date - dn.entry_date))
                    ELSE 0
                    END
        ) AS total_sold_nights
    FROM Данные_о_номерах_и_клиентах dn
             JOIN Данные_о_номере don ON dn.data_room = don.data_room
),
     общий_период AS (
         SELECT
             MIN(dn.entry_date) AS start_date,
             COALESCE(MAX(don.departure_date), CURRENT_DATE) AS end_date
         FROM Данные_о_номерах_и_клиентах dn
                  JOIN Данные_о_номере don ON dn.data_room = don.data_room
         WHERE don.departure_date IS NOT NULL OR dn.entry_date IS NOT NULL
     ),
     общее_количество_номеров AS (
         SELECT COUNT(*) AS total_rooms FROM Номер
     )
SELECT
    ROUND(
            (
                (SELECT total_sold_nights FROM проданные_ночи) * 100.0 /
                (
                    (SELECT total_rooms FROM общее_количество_номеров) *
                    ((SELECT end_date FROM общий_период) - (SELECT start_date FROM общий_период))
                    )
                ),
            2
    ) AS процент_загрузки;


create type face_people as enum ('Физическое лицо', 'Юридическое лицо');
create type role_sub as enum ('Администратор', 'Клиент', 'Сотрудник');

create table subscriber (
    sub_id serial primary key,
    number_phone varchar(20) not null,
    l_name varchar(64) not null,
    f_name varchar(64) not null,
    patronymic varchar(64) null,
    address varchar(128) null,
    index int not null,
    face face_people,
    role role_sub
);

insert into subscriber (number_phone, l_name, f_name, patronymic, address, index, face, role)
values
('88005553555', 'Ivanov', 'Ivan', null, null, 189098,'Физическое лицо', 'Клиент'),
('82365235896', 'Ivanov', 'Grigori', 'Ivanovich', null, 456369,'Физическое лицо', 'Клиент'),
('87695632145', 'Остапчук', 'Евгений', null, null, 456369,'Физическое лицо', 'Клиент'),
('85632148965', 'Резников', 'Дмитрий', 'Ivanovich', null, 456369, 'Физическое лицо', 'Клиент'),
('82562541553', 'Злобина', 'Полина', 'Дмитриевна', null, 123345, 'Физическое лицо', 'Администратор'),
('89633124552', 'Джарышбекова', 'Диля', 'Джарышбековна', null, 125589,'Физическое лицо', 'Администратор'),
('87452033654', 'Кротова', 'Арина', 'Михайловна', null, 456987,'Физическое лицо', 'Администратор'),
('89050965234', 'Касумова', 'Диана', null, null, 785963,'Физическое лицо', 'Сотрудник'),
('89156322589', 'Хакимова', 'Алина', null, null, 125478,'Физическое лицо', 'Клиент'),
('89633695623', 'Гольцев', 'Кирилл', null, null, 452210,'Физическое лицо', 'Сотрудник'),
('81236545820', 'Гольцев', 'Никита', null, null, 741258,'Физическое лицо', 'Клиент'),
('82012350205', 'Нагорнов', 'Алексей', null, null, 102203,'Физическое лицо', 'Сотрудник'),
('87533112566', 'Каричев', 'Леонид', null, null, 115223,'Физическое лицо', 'Клиент'),
('89666312005', 'Никонова', 'Ксения', null, null, 456325,'Физическое лицо', 'Клиент');

select * from subscriber;

/*drop table subscriber;*/

/*==================================================*/
CREATE TYPE Тип_приема AS ENUM ('Первичный', 'Вторичный');


create table Пациенты(
                         id int primary key ,
                         Номер_истории_болезни int not null,
                         Фамилия varchar(64) not null,
                         Отчество varchar(64) null,
                         Имя varchar(64) not null,
                         Домашний_адрес varchar(64) null,
                         Телефон varchar(12) not null
);

create table Специалист(
                           id int primary key ,
                           Личный_номер_специалиста int not null,
                           Фамилия varchar(64) not null,
                           Отчество varchar(64) null,
                           Имя varchar(64) not null,
                           Домашний_адрес varchar(64) null,
                           Специальность varchar(64) null,
                           Телефон varchar(12) not null

);

create table Лекарства(
                          id int primary key ,
                          Наименование varchar(64) not null,
                          Назначение varchar(64) null,
                          Противопокозания varchar(64) not null,
                          Стоимсть decimal(10,2)

);

create table Услуга(
                       id int primary key ,
                       Наименование varchar(64) not null,
                       Стоимсть decimal(10,2)

);

create table Визиты(
                       id int primary key ,
                       Пациент int not null,
                       Специалист int not null,
                       Тип_визита Тип_приема,
                       Дата_визита date not null,
                       Анамнез varchar(100) not null,
                       Диагноз varchar(100) not null,
                       Лечение varchar(200) not null,
                       Стоимость_услуг decimal(10,2) not null,
                       Стоиомсть_израсход_лекарств decimal(10,2) not null,
                       Ирасход_лекарства int not null,
                       Услуга int not null,
                       foreign key (Ирасход_лекарства) references Лекарства(id),
                       foreign key (Пациент) references Пациенты(id),
                       foreign key (Специалист) references Специалист(id),
                       foreign key (Услуга) references Услуга(id)
);





insert into "Пациенты"(id, "Номер_истории_болезни", "Фамилия", "Имя", "Отчество", "Домашний_адрес", "Телефон") values
                                                                                                                   (1, 344,'Грин', 'Ралли', 'Федоровна', 'г.Ильмира ул.Третья кв.22','89990001188'),
                                                                                                                   (2, 34945,'Актинов', 'Лев', 'Иванов', 'г.Ильмира ул.Ленина кв.28' , '89990001188'),
                                                                                                                   (3, 291,'Реальный', 'Александр', 'Марков', 'г.Ильмира ул.Верный кв.1', '89990001188');


insert into "Специалист"(id, "Личный_номер_специалиста", "Фамилия", "Имя", "Отчество", "Домашний_адрес", "Телефон", "Специальность") values
                                                                                                                                         (1, 344,'Аруль', 'Ралли', 'Федоровна', 'г.Ильмира ул.Третья кв.22','89990001182', 'Лечение зубов'),
                                                                                                                                         (2, 34945,'Рожденный', 'Лев', 'Иванов', 'г.Ильмира ул.Ленина кв.28' , '89990006188', 'Ортадонт'),
                                                                                                                                         (3, 291,'Супер', 'Александр', 'Марков', 'г.Ильмира ул.Верный кв.1', '89990301188', 'Лечение десен');




insert into "Лекарства"(id, "Наименование", "Назначение", "Стоимсть", "Противопокозания") values
                                                                                              (1, 'Анальгин', 'При боли в голове', '1178', 'аллергия,беременность'),
                                                                                              (2, 'Тотема', 'Железодефицит', '219283', 'аллергия'),
                                                                                              (3, 'Хлорофил', 'Инфекция', '187', 'аллергия,беременность');
insert into "Услуга"(id, "Наименование", "Стоимсть") values
                                                         (1, 'Осмотр', '39303'),
                                                         (2, 'Удаление', '2893'),
                                                         (3, 'Чистка', '923828');

insert into "Визиты"(id, "Пациент", "Специалист", "Тип_визита", "Дата_визита", "Анамнез", "Диагноз", "Лечение", "Стоимость_услуг", "Стоиомсть_израсход_лекарств", "Услуга", "Ирасход_лекарства") values
                                                                                                                                                                                                     (1, 2,1, 'Первичный', '2026-11-11', 'боль в зубах','кариес', 'лечить', '192189', '23092', '1', 1),
                                                                                                                                                                                                     (2, 3,3, 'Первичный', '2026-01-01', 'боль в десне' , 'пульпит', 'удаление ', '192189', '23092', '3', 2 ),
                                                                                                                                                                                                     (3, 1,2, 'Вторичный', '2026-03-03', 'боль в зубах', 'периодонтит', 'удаление', '192189', '23092', '3', 2);

select * from "Пациенты";
select * from "Визиты";
select * from "Лекарства";
select * from "Услуга";
select * from "Специалист";
select SUM("Стоимость_услуг" + "Стоиомсть_израсход_лекарств") as "Общая_выручка" from "Визиты" WHERE "Дата_визита" = '2026-11-11';


/*==================================================*/
CREATE TYPE Status_A AS ENUM ('принят', 'в процессе', 'завершен');

create table if not exists Заказчик (
    id_customeR serial primary key,
    f_name varchar (64) not null,
    l_name varchar (64) not null,
    patronymic varchar (64) null,
    number_phone varchar(20) not null
);

create table if not exists Закройщик (
    id_cutter serial primary key,
    f_name varchar (64) not null,
    l_name varchar (64) not null,
    patronymic varchar (64) null,
    number_phone varchar(20) not null
);

create table if not exists Каталог_тканей (
   catalog_textil_id serial primary key,
   name varchar(64) not null,
   performance varchar(64) not null,
   width decimal (10,2) not null,
   length decimal (10,2) not null,
    count decimal(10,2) not null
);

create table if not exists Каталог_моделей (
    catalog_model_id serial primary key,
    count decimal (10,2) not null,
    cost_of_tailoring decimal (10,2),
    catalog_textil_id int,
    foreign key (catalog_textil_id) references Каталог_тканей(catalog_textil_id),
    need_count int not null
);

create table if not exists Склад_тканей (
    place_textil_id serial primary key,
    Общий_метраж decimal(10,2) not null,
    catalog_textil_id int,
    foreign key (catalog_textil_id) references Каталог_тканей(catalog_textil_id)
);

create table if not exists Заказ (
    zakaz_id serial primary key,
    id_customeR int,
    foreign key (id_customeR) references Заказчик(id_customeR),
    id_cutter int,
    foreign key (id_cutter) references Закройщик(id_cutter),
    catalog_textil_id int,
    foreign key (catalog_textil_id) references Каталог_тканей(catalog_textil_id),
    catalog_model_id int,
    foreign key (catalog_model_id) references Каталог_моделей(catalog_model_id),
    date_start date not null,
    status Status_A,
    date_end date not null
);


INSERT INTO Заказчик (f_name, l_name, patronymic, number_phone) VALUES
                                                                    ('Анна', 'Иванова', 'Сергеевна', '+7 (912) 345-67-81'),
                                                                    ('Дмитрий', 'Петров', 'Александрович', '+7 (912) 345-67-82'),
                                                                    ('Елена', 'Сидорова', 'Владимировна', '+7 (912) 345-67-83'),
                                                                    ('Михаил', 'Козлов', 'Игоревич', '+7 (912) 345-67-84'),
                                                                    ('Ольга', 'Волкова', 'Дмитриевна', '+7 (912) 345-67-85'),
                                                                    ('Алексей', 'Морозов', 'Викторович', '+7 (912) 345-67-86'),
                                                                    ('Наталья', 'Павлова', 'Романовна', '+7 (912) 345-67-87'),
                                                                    ('Сергей', 'Волков', 'Геннадьевич', '+7 (912) 345-67-88'),
                                                                    ('Ирина', 'Никитина', 'Олеговна', '+7 (912) 345-67-89'),
                                                                    ('Андрей', 'Соколов', 'Юрьевич', '+7 (912) 345-67-90');

INSERT INTO Закройщик (f_name, l_name, patronymic, number_phone) VALUES
                                                                     ('Татьяна', 'Федорова', 'Михайловна', '+7 (923) 456-78-01'),
                                                                     ('Виктор', 'Белов', 'Станиславович', '+7 (923) 456-78-02'),
                                                                     ('Людмила', 'Орлова', 'Анатольевна', '+7 (923) 456-78-03'),
                                                                     ('Игорь', 'Лебедев', 'Павлович', '+7 (923) 456-78-04'),
                                                                     ('Марина', 'Тихонова', 'Валерьевна', '+7 (923) 456-78-05'),
                                                                     ('Роман', 'Григорьев', 'Евгеньевич', '+7 (923) 456-78-06'),
                                                                     ('Светлана', 'Васильева', 'Николаевна', '+7 (923) 456-78-07'),
                                                                     ('Денис', 'Семёнов', 'Андреевич', '+7 (923) 456-78-08'),
                                                                     ('Юлия', 'Никифорова', 'Борисовна', '+7 (923) 456-78-09'),
                                                                     ('Павел', 'Макаров', 'Константинович', '+7 (923) 456-78-10');


INSERT INTO Каталог_тканей (name, performance, width, length, count) VALUES
                                                                         ('Хлопок премиум', '100% хлопок', 150.00, 50.00, 120.50),
                                                                         ('Лён натуральный', '100% лён', 140.00, 45.00, 85.75),
                                                                         ('Шёлк атлас', '95% шёлк, 5% эластан', 135.00, 30.00, 60.25),
                                                                         ('Шерсть мериноса', '100% шерсть', 160.00, 40.00, 75.00),
                                                                         ('Вискоза стрейч', '92% вискоза, 8% спандекс', 145.00, 55.00, 90.80),
                                                                         ('Деним классический', '98% хлопок, 2% эластан', 155.00, 60.00, 110.30),
                                                                         ('Бархат', '80% полиэстер, 20% вискоза', 140.00, 25.00, 45.60),
                                                                         ('Трикотаж джерси', '95% хлопок, 5% лайкра', 180.00, 70.00, 130.40),
                                                                         ('Сатин', '100% хлопок', 220.00, 50.00, 105.90),
                                                                         ('Габардин', '65% полиэстер, 35% шерсть', 150.00, 48.00, 88.20);

INSERT INTO Каталог_моделей (count, cost_of_tailoring, catalog_textil_id, need_count) VALUES
                                                                                          (1.50, 5000.00, 1, 2),
                                                                                          (2.00, 7000.00, 2, 3),
                                                                                          (1.80, 8000.00, 3, 2),
                                                                                          (3.00, 9500.00, 4, 4),
                                                                                          (2.50, 6500.00, 5, 3),
                                                                                          (4.00, 4500.00, 6, 5),
                                                                                          (1.20, 3500.00, 7, 2),
                                                                                          (2.80, 6000.00, 8, 3),
                                                                                          (3.50, 7200.00, 9, 4),
                                                                                          (2.20, 5800.00, 10, 3);


INSERT INTO Склад_тканей (Общий_метраж, catalog_textil_id) VALUES
                                                               (200.00, 1),
                                                               (150.00, 2),
                                                               (100.00, 3),
                                                               (180.00, 4),
                                                               (220.00, 5),
                                                               (250.00, 6),
                                                               (80.00, 7),
                                                               (300.00, 8),
                                                               (280.00, 9),
                                                               (160.00, 10);


INSERT INTO Заказ (id_customeR, id_cutter, catalog_textil_id, catalog_model_id, date_start, status, date_end) VALUES
                                                                                                                  (1, 1, 1, 1, '2024-01-15', 'принят', '2024-02-01'),
                                                                                                                  (2, 2, 2, 2, '2024-01-20', 'в процессе', '2024-02-10'),
                                                                                                                  (3, 3, 3, 3, '2024-02-01', 'в процессе', '2024-02-20'),
                                                                                                                  (4, 4, 4, 4, '2024-02-05', 'завершен', '2024-02-25'),
                                                                                                                  (5, 5, 5, 5, '2024-02-10', 'принят', '2024-03-01'),
                                                                                                                  (6, 6, 6, 6, '2024-02-15', 'в процессе', '2024-03-10'),
                                                                                                                  (7, 7, 7, 7, '2024-03-01', 'завершен', '2024-03-20'),
                                                                                                                  (8, 8, 8, 8, '2024-03-05', 'принят', '2024-03-25'),
                                                                                                                  (9, 9, 9, 9, '2024-03-10', 'в процессе', '2024-04-01'),
                                                                                                                  (10, 10, 10, 10, '2024-03-15', 'принят', '2024-04-09');

select * from Заказчик;
select * from Закройщик;
select * from Каталог_тканей;
select * from Каталог_моделей;
select * from Склад_тканей;
select * from Заказ;



/*=============================================================*/

create table if not exists dealer (
    dealer_id serial primary key,
    l_name varchar(64) not null,
    f_name varchar(64) not null,
    patronymic varchar (64) null,
    photo varchar(255) null,
    home_address varchar(255) null,
    phone varchar(20) not null
);

create table if not exists buyer (
    buyer_id serial primary key,
    l_name varchar(64) not null,
    f_name varchar(64) not null,
    patronymic varchar (64) null,
    city_name varchar(64) null,
    address varchar(255) null,
    phone varchar(20) not null
);

create table if not exists contract_d_b (
    contract serial primary key,
    dealer_id int,
    foreign key (dealer_id) references dealer(dealer_id),
    buyer_id int,
    foreign key (buyer_id) references buyer(buyer_id),
    contract_date date not null,
    car_brand varchar(64) not null,
    manufacture_date date not null,
    mileage int null,
    sale_date date not null,
    price decimal(10, 2) not null,
    note text null
);

select * from buyer;
select * from dealer;
select * from contract_d_b;

/*drop table buyer, dealer, contract_d_b;*/

insert into dealer (l_name, f_name, patronymic, photo, home_address, phone)
values
    ('Иванов', 'Иван', 'Иванович', 'фото1', 'ул.Смирнова, д.5, кв.6', '85236988741'),
    ('Остапчук', 'Александр', 'Александрович', 'фото2', 'ул.Прокопенко, д.5, кв.6', '89125639874'),
    ('Крепчук', 'Игорь', null, 'фото3', 'ул.Гоголя, 55', '89631478520'),
    ('Романенко', 'Юрий', 'Михайлович', 'фото4', 'ул.Фрунзе, д.89, кв.36', '82589631478'),
    ('Казанцев', 'Вадим', 'Юрьевич', 'фото5', 'ул.Родная, д.1, кв.12', '81236547896');

insert into buyer (l_name, f_name, patronymic, city_name, address, phone)
values
    ('Кузьмин', 'Максим', 'Дмитриевич', 'Кемерово', 'ул.Смирнова, д.75, кв.12', '89123025062'),
    ('Кольцов', 'Артём', 'Мирославович', 'Москва', 'ул.Линия, д.5, кв.6', '89125639632'),
    ('Архипова', 'Ксения', 'Игоревна', 'Альметьевск', 'ул.Гоголя, д.45, кв.89', '89122035268'),
    ('Андрианова', 'Виктория', 'Кирилловна', 'Казань', 'ул.Железнодорожная, д.5, кв.6', '89124568529'),
    ('Новиков', 'Артём', 'Львович', 'Ярославль', 'ул.Бакина, д.55, кв.36', '89125406321');

insert into contract_d_b (dealer_id, buyer_id, contract_date, car_brand, manufacture_date, mileage, sale_date, price, note)
values
    (1, 1, '2026-12-12', 'Шкода', '2022-02-25', 258, '2026-12-12', 120220.36, null),
    (2, 2, '2026-03-12', 'Тойота', '2025-02-09', 896, '2026-03-12', 8963214.36, 'не битая, не крашенная'),
    (3, 3, '2026-04-21', 'Кия', '2024-08-08', 632, '2026-04-21', 12896632.36, 'не стояла на учетах по угону и не участвовала в авариях'),
    (4, 4, '2026-05-13', 'Лада', '2022-02-16', 789, '2026-05-13', 8920220.36, null),
    (5, 5, '2026-05-16', 'Мерседес', '2022-03-05', 100, '2026-05-16', 15236599.36, null);

/*Посчитать количество договоров, заключённых с каждым клиентом*/
SELECT
    b.buyer_id,
    b.l_name AS фамилия_клиента,
    b.f_name AS имя_клиента,
    COUNT(c.contract) AS количество_договоров
FROM buyer b
         LEFT JOIN contract_d_b c ON b.buyer_id = c.buyer_id
GROUP BY b.buyer_id, b.l_name, b.f_name
ORDER BY количество_договоров DESC;

/*Посчитать количество договоров, обслуживаемых каждым дилером*/
SELECT
    d.dealer_id,
    d.l_name AS фамилия_дилера,
    d.f_name AS имя_дилера,
    COUNT(c.contract) AS количество_договоров
FROM dealer d
         LEFT JOIN contract_d_b c ON d.dealer_id = c.dealer_id
GROUP BY d.dealer_id, d.l_name, d.f_name
ORDER BY количество_договоров DESC;

/*Выдать информацию обо всех договорах*/
SELECT
    d.l_name AS фамилия_дилера,
    d.f_name AS имя_дилера,
    c.contract_date AS дата_заключения_договора,
    b.l_name AS фамилия_клиента,
    b.f_name AS имя_клиента,
    c.car_brand AS марка_автомобиля,
    c.price AS цена,
    c.note AS отметка_о_продаже
FROM contract_d_b c
         JOIN dealer d ON c.dealer_id = d.dealer_id
         JOIN buyer b ON c.buyer_id = b.buyer_id
ORDER BY c.contract_date;

/*Выдать информацию о договорах за определённый промежуток времени*/
SELECT
    d.l_name AS фамилия_дилера,
    d.f_name AS имя_дилера,
    c.contract_date AS дата_заключения_договора,
    b.l_name AS фамилия_клиента,
    b.f_name AS имя_клиента,
    c.car_brand AS марка_автомобиля,
    c.price AS цена,
    c.note AS отметка_о_продаже
FROM contract_d_b c
         JOIN dealer d ON c.dealer_id = d.dealer_id
         JOIN buyer b ON c.buyer_id = b.buyer_id
WHERE c.contract_date BETWEEN '2026-01-01' AND '2026-12-31'
ORDER BY c.contract_date;

/*Выдать информацию о договорах, удовлетворяющих определённому условию*/
SELECT
    d.l_name AS фамилия_дилера,
    d.f_name AS имя_дилера,
    c.contract_date AS дата_заключения_договора,
    b.l_name AS фамилия_клиента,
    b.f_name AS имя_клиента,
    c.car_brand AS марка_автомобиля,
    c.price AS цена,
    c.note AS отметка_о_продаже
FROM contract_d_b c
         JOIN dealer d ON c.dealer_id = d.dealer_id
         JOIN buyer b ON c.buyer_id = b.buyer_id
WHERE c.price > 10000000
ORDER BY c.price DESC;


/*===================================================================*/
create type current_s as enum ('Отличное', 'Хорошее', 'Плохое');
create type status_l as enum ('Действителен', 'Оформлен', 'Завершен', 'Активен');


create table if not exists tenant (
    tenant_id serial primary key,
    name_company varchar(64) null,
    FIO varchar(255) null,
    rental_history text null,
    phone varchar(20) not null
);

create table if not exists landlord (
    landlord_id serial primary key,
    name_company varchar(64) null,
    FIO varchar(255) null,
    list_of_equipment text null,
    phone varchar(20) not null
);

create table construction_equipment (
    construction_equipment_id serial primary key,
    type_equipment varchar(64) not null,
    mark varchar(64) not null,
    main_characteristics varchar(255) not null,
    current_status current_s,
    rental_price decimal(10,2) not null
);

create table if not exists equipment_maintenance (
     equipment_maintenance_id serial primary key,
     construction_equipment_id int,
    foreign key (construction_equipment_id) references construction_equipment(construction_equipment_id),
     вates_of_work_performed date not null,
     description_of_work_performed text not null,
     responsible_person varchar(255)
);

create table if not exists Transfer_and_Return_of_Equipment (
    Transfer_and_Return_of_Equipment_id serial primary key,
    date_time_begin timestamp not null,
    begin_state varchar(64) not null,
    date_time_end timestamp not null,
    end_state varchar(64) not null
);

create table if not exists lease_agreement(
    lease_agreement serial primary key,
    tenant_id int,
    foreign key (tenant_id) references tenant(tenant_id),
    landlord_id int,
    foreign key (landlord_id) references landlord(landlord_id),
    construction_equipment_id int,
    foreign key (construction_equipment_id) references construction_equipment(construction_equipment_id),
    Transfer_and_Return_of_Equipment_id int,
    foreign key (Transfer_and_Return_of_Equipment_id) references Transfer_and_Return_of_Equipment(Transfer_and_Return_of_Equipment_id),
    count decimal (10, 2) not null,
    status_lease status_l
);

INSERT INTO tenant (name_company, FIO, rental_history, phone) VALUES
  ('СтройМастер', 'Иванов Алексей Петрович', 'Аренда экскаватора в 2023 г.', '89123456789'),
  ('РемСтрой', 'Петрова Мария Сергеевна', 'Аренда погрузчика в 2022 г.', '89234567890'),
  ('Новый Горизонт', 'Сидоров Дмитрий Викторович', 'Аренда бетономешалки в 2024 г.', '89345678901'),
  ('СпецТехника', 'Козлова Анна Игоревна', 'Аренда крана в 2021 г.', '89456789012'),
  ('МегаСтрой', 'Николаев Сергей Владимирович', 'Аренда бульдозера в 2023 г.', '89567890123');

INSERT INTO landlord (name_company, FIO, list_of_equipment, phone) VALUES
   ('АрендаТех', 'Смирнов Андрей Николаевич', 'Экскаваторы, погрузчики', '89678901234'),
   ('СтройРесурс', 'Васильева Елена Олеговна', 'Краны, бетономешалки', '89789012345'),
   ('ТехСервис', 'Федоров Михаил Юрьевич', 'Бульдозеры, самосвалы', '89890123456'),
   ('Прокатный Двор', 'Морозова Ольга Дмитриевна', 'Компрессоры, генераторы', '89901234567'),
   ('СпецАренда', 'Павлов Алексей Сергеевич', 'Автовышки, манипуляторы', '89012345678');

INSERT INTO construction_equipment (type_equipment, mark, main_characteristics, current_status, rental_price) VALUES
  ('Экскаватор', 'CAT 320', 'Объём ковша 1 м³, мощность 140 л.с.', 'Отличное', 5000.00),
  ('Погрузчик', 'Volvo L60', 'Грузоподъёмность 6 т, объём ковша 2 м³', 'Хорошее', 3500.00),
  ('Кран', 'Liebherr LTM 1050', 'Грузоподъёмность 50 т, вылет стрелы 40 м', 'Отличное', 8000.00),
  ('Бетономешалка', 'ЗИЛ БМ-150', 'Объём барабана 150 л', 'Плохое', 1200.00),
  ('Бульдозер', 'Komatsu D65', 'Мощность 200 л.с., ширина отвала 3.5 м', 'Хорошее', 6000.00);


INSERT INTO equipment_maintenance (construction_equipment_id, вates_of_work_performed, description_of_work_performed, responsible_person) VALUES
(1, '2024-01-15', 'Замена гидравлического масла, проверка фильтров', 'Механик Иванов И.И.'),
(2, '2024-02-20', 'Регулировка тормозов, замена тормозных колодок', 'Механик Петров П.П.'),
(3, '2024-03-10', 'Проверка гидравлической системы, замена уплотнителей', 'Механик Сидоров С.С.'),
(4, '2024-04-05', 'Ремонт барабана, замена подшипников', 'Механик Козлова К.К.'),
(5, '2024-05-12', 'ТО двигателя, замена воздушного фильтра', 'Механик Николаев Н.Н.');

INSERT INTO Transfer_and_Return_of_Equipment (date_time_begin, begin_state, date_time_end, end_state) VALUES
('2024-06-01 09:00:00', 'Отличное', '2024-06-15 18:00:00', 'Хорошее'),
('2024-07-10 10:00:00', 'Хорошее', '2024-07-25 17:00:00', 'Хорошее'),
('2024-08-05 08:30:00', 'Отличное', '2024-08-20 16:30:00', 'Отличное'),
('2024-09-12 09:15:00', 'Плохое', '2024-09-27 18:45:00', 'Хорошее'),
('2024-10-01 11:00:00', 'Хорошее', '2024-10-16 19:00:00', 'Отличное');


INSERT INTO lease_agreement (tenant_id, landlord_id, construction_equipment_id, Transfer_and_Return_of_Equipment_id, count, status_lease) VALUES
(1, 1, 1, 1, 1.00, 'Действителен'),
(2, 2, 2, 2, 1.00, 'Активен'),
(3, 3, 3, 3, 1.00, 'Оформлен'),
(4, 4, 4, 4, 1.00, 'Завершен'),
(5, 5, 5, 5, 1.00, 'Действителен');


select * from tenant;
select * from landlord;
select * from construction_equipment;
select * from equipment_maintenance;
select * from Transfer_and_Return_of_Equipment;
select * from lease_agreement;



/*==================================================*/


select * from Хозяйство;
select * from Продукция;
select * from Специализация;

/*drop table Хозяйство;*/

create table if not exists Продукция (
    продукция_идф serial primary key,
    название_товара varchar(64) not null,
    ед_измерения varchar(3) not null,
    цена_за_ед_товара decimal(10,2) not null,
    предлагаемое_кол_во_за_раз int not null,
    дата date not null
);

create table if not exists Специализация (
    специализаця_идф serial primary key,
    название_специализации varchar(64) not null,
    продукция_идф int,
    foreign key (продукция_идф) references Продукция (продукция_идф)
);

create table if not exists Хозяйство (
    хозяйтсво_идф serial primary key,
    специализаця_идф int,
    foreign key (специализаця_идф) references Специализация (специализаця_идф),
    название_хозяйства varchar(64) not null,
    личные_данные text null,
    регион varchar(64) not null,
    адрес varchar(64) not null,
    телефон varchar(20) not null
);

insert into Продукция(название_товара, ед_измерения, цена_за_ед_товара, предлагаемое_кол_во_за_раз, дата)
values ('Виноград', 'кг', 68.99, 100, '2026-06-05'),
       ('Мясо курицы', 'кг', 150.99, 100, '2026-06-05'),
       ('Яблоки', 'л', 96.99, 100, '2026-06-05'),
       ('Листвинница', 'шт', 120.99, 100, '2026-06-05'),
       ('Молочный коктель', 'л', 68.99, 100, '2026-06-05');

insert into Специализация (название_специализации, продукция_идф)
values ('Виноградарство', 1),
       ('Животноводство', 2),
       ('Овощеводство', 3),
       ('Селекционерство', 4),
       ('Молочный комбинат', 5);

insert into Хозяйство (специализаця_идф, название_хозяйства, личные_данные, регион, адрес, телефон)
values
        (1, 'Моя семья', 'null', 'Томская область', 'ул.Успеха, д.8', '89638521478'),
        (2, 'Давай мясо', 'null', 'Томская область', 'ул.Убийств, д.8', '89127456963'),
        (1, 'Овощной комбинат', 'Все люди овощи', 'Томская область', 'ул.Овощная, д.21', '89126398963512'),
        (1, 'Лес дружбы', 'Тут растут деревья, сделаем мир зеленее', 'Томская область', 'ул.Лесная, д.56', '89121230255620'),
        (1, 'Любимый', 'Везде есть яблоко', 'Томская область', 'ул.Обнама, д.66', '89998886655');


/*========================================================*/

create type имя_типа as enum ('названия для типов', 'названия для типов', 'названия для типов');

create table if not exists Name_table (
    id serial primary key,
    name_colon varchar(64) not null,
    name_colon2 text not null,
    name_colon3 int not null,
    name_colon4 decimal(10, 2) not null
);

create table if not exists Name_table2 (
    id_table serial primary key,
    id int,
    foreign key (id) references Name_table (id),
    name_colon varchar(64) not null,
    name_colon2 text null,
    name_colon3 int not null,
    name_colon4 decimal(10, 2) not null
);

insert into Name_table (name_colon, name_colon2, name_colon3, name_colon4)
values
    ('', '', 1, 14.09),
    ('', '', 2, 14.09),
    ('', '', 3, 14.09),
    ('', '', 4, 14.09),
    ('', '', 5, 14.09);

insert into Name_table2 (id, name_colon, name_colon2, name_colon3, name_colon4)
values
    (1, '', 'null', 1, 20.0),
    (2, '', '', 2, 20.2),
    (3, '', '', 3, 20.3),
    (4, '', 'null', 4, 20.4),
    (5, '', '', 5, 20.5);

select * from Name_table;
select * from Name_table2;
