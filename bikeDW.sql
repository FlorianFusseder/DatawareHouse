----------------------------------------------------------------
-- Installation of the Database BIKE for Oracle 
--
--                        to use with SQL Developer, Oracle V11 or later 
--                         E. Schicker, March 2016
----------------------------------------------------------------

SET TERMOUT ON
PROMPT Installation of Database BIKE. Please wait

ACCEPT User CHAR PROMPT 'Please insert your account on the server ORA12C: '
ACCEPT Password CHAR PROMPT 'Please insert your password on the server ORA12C: '
SET TERMOUT OFF
SET FEEDBACK OFF
PROMPT

-- Existing tables will be deleted
DROP TABLE articlereservation;
DROP TABLE orderposition;
DROP TABLE orders;
DROP TABLE articlestructure;
DROP TABLE store;
DROP TABLE shipment;
DROP TABLE article;
DROP TABLE staff;
DROP TABLE customer;
DROP TABLE supplier;

------------------------------------
-- Create tables:
------------------------------------

CREATE TABLE supplier (
     sid         INTEGER    Constraint PK_supplier PRIMARY KEY,
     name        CHAR(30)   NOT NULL,
     street      CHAR(30),
     zip         INTEGER,
     place       CHAR(25),
     closed      CHAR (1)       
);

CREATE TABLE customer (
     cid         INTEGER    Constraint PK_customer PRIMARY KEY,
     name        CHAR(30)   NOT NULL,
     street      CHAR(30),
     zip         INTEGER,
     place       CHAR(20),
     closed      CHAR (1)       
);

CREATE TABLE staff (
     staffid     INTEGER    Constraint PK_staff PRIMARY KEY,
     name        CHAR(30)   NOT NULL,
     street      CHAR(30),
     zip         INTEGER,
     place       CHAR(20),
     datebirth   DATE       NOT NULL,
     status      CHAR(6),
     superior    INTEGER    Constraint FK_staff REFERENCES staff ON DELETE SET NULL,
     salary      NUMERIC(8,2),
     mark        CHAR(1),
     job         CHAR(18)
);


CREATE TABLE article (
     aid         INTEGER    Constraint PK_article PRIMARY KEY,
     name        CHAR(35),
     net         NUMERIC(7,2),
     tax         NUMERIC(7,2),
     price       NUMERIC(7,2),
     color       CHAR(10),
     description CHAR(15),
     measure     CHAR(2)    NOT NULL,
     made        CHAR(1)    NOT NULL
);

CREATE TABLE store (
     aid         INTEGER    Constraint PK_store PRIMARY KEY,
     place       CHAR(6),
     stock       SMALLINT   NOT NULL,
     minimum     SMALLINT,
     reserved    SMALLINT,
     ordered     SMALLINT,
     Constraint FK_store_article FOREIGN KEY (aid) REFERENCES article ON DELETE CASCADE
);

CREATE TABLE shipment (
     aid         INTEGER    Constraint FK_article  REFERENCES article ON DELETE CASCADE,
     sid         INTEGER    Constraint FK_supplier REFERENCES supplier ON DELETE CASCADE,
     delivrytime SMALLINT,
     netprice    NUMERIC(7,2),
     ordered     SMALLINT,
     Constraint PK_shipment PRIMARY KEY (aid, sid)
);
     
CREATE TABLE articlestructure (
     artid       INTEGER    Constraint FK_articles REFERENCES article ON DELETE CASCADE,
     compid      INTEGER    Constraint FK_component REFERENCES article,
     artcount    SMALLINT,
     measure     CHAR(2),
     Constraint PK_articlestructur PRIMARY KEY (artid, compid)	
);

-- Now these tables will be filled with data

INSERT INTO supplier
  VALUES ( 1, 'Schmidtner GmbH'       , 'Dr. Gesslerstr 59'        ,  93051, 'Regensburg ', '0' );
INSERT INTO supplier
  VALUES ( 2, 'Rauch GmbH'            , 'Burgallee 23'             ,  90402, 'Nuernberg ' , '0' );
INSERT INTO supplier
  VALUES ( 3, 'Shimano GmbH'          , 'Yokohamastreet 122'       ,   NULL, 'Tokyo'      , '0' );
INSERT INTO supplier
  VALUES ( 4, 'Suntour LTD'           , 'Meltonstreet 65'          ,   NULL, 'London'     , '0' );
INSERT INTO supplier
  VALUES ( 5, 'MSM GmbH'              , 'St-Rotteneckstr 13'       ,  93047, 'Regensburg' , '0' );

INSERT INTO customer
  VALUES ( 1, 'Biker Shop'            , 'Obere Regenstr 4'         ,  93059, 'Regensburg' , '0' );
INSERT INTO customer
  VALUES ( 2, 'Bicycle Centre'        , 'Kirschweg 20'             ,  44267, 'Dortmund'   , '0' );
INSERT INTO customer
  VALUES ( 3, 'Maier Ingrid'          , 'Universitaetsstr 33'      ,  93055, 'Regensburg' , '1' );
INSERT INTO customer
  VALUES ( 4, 'Rafa - Seger KG'       , 'Liebigstr 10'             ,  10247, 'Berlin'     , '0' );
INSERT INTO customer
  VALUES ( 5, 'Biker Corner'          , 'Lessingstr 37'            ,  22087, 'Hamburg'    , '0' );
INSERT INTO customer
  VALUES ( 6, 'Bicycle Hammer'        , 'Schindlerplatz 7'         ,  81739, 'Munich'     , '0' );
INSERT INTO customer
  VALUES ( 101, 'Bike Miller'         , 'Ringstr 7'               ,  30457, 'Hannover' , '0' );
INSERT INTO customer
  VALUES ( 102, 'Hans Meier GmbH'     , 'Dammtorstr 11'           ,  20354, 'Hamburg' , '0' );
INSERT INTO customer
  VALUES ( 103, 'Anton Kurz KG'       , 'Freiheit 133'            ,  45127, 'Essen' , '0' );
INSERT INTO customer
  VALUES ( 104, 'Biketime Floris'     , 'Kriegsstr 54'            ,  76135, 'Karlsruhe' , '0' );
INSERT INTO customer
  VALUES ( 105, 'Schneider Bikes'     , 'Handelsstr 6'            ,  04356, 'Leipzig' , '0' );
INSERT INTO customer
  VALUES ( 106, 'Michael Kurz und Co' , 'Gruene Str 2'            ,  01067, 'Dresden' , '0' );
INSERT INTO customer
  VALUES ( 107, 'Winfried Fuerst'     , 'Tempelhofer Ufer 17'     ,  10961, 'Berlin' , '0' );
INSERT INTO customer
  VALUES ( 108, 'Karl Fuchs KG'       , 'Doberaner Str 1'         ,  18057, 'Rostock' , '0' );
INSERT INTO customer
  VALUES ( 109, 'Bikes Anton'         , 'Albertstr 32'            ,  79104, 'Freiburg' , '0' );
INSERT INTO customer
  VALUES ( 110, 'Henry Faller a. Co'  , 'Havelstr 16'             ,  64295, 'Darmstadt' , '0' );
INSERT INTO customer
  VALUES ( 111, 'Kurt Reich'          , 'Schneckenhofstr 8'       ,  60596, 'Frankfurt' , '0' );
INSERT INTO customer
  VALUES ( 112, 'Bike Langer'         , 'Stapenhorststr 13'       ,  33615, 'Bielefeld' , '0' );
INSERT INTO customer
  VALUES ( 113, 'Zweirad Schwamm'     , 'Zeppelinstr 3'           ,  44791, 'Bochum' , '0' );
INSERT INTO customer
  VALUES ( 114, 'Bike und Rad'        , 'Lindenstr 15'            ,  54292, 'Trier' , '0' );
INSERT INTO customer
  VALUES ( 115, 'Freizeit Bikes'      , 'Giteramtsstr 4'          ,  69115, 'Heidelberg' , '0' );
INSERT INTO customer
  VALUES ( 116, 'Grimm Bikes'         , 'Juri-Gagarin-Ring 12'    ,  99084, 'Erfurt' , '0' );
INSERT INTO customer
  VALUES ( 117, 'Fahrrad Hans u. Co'  , 'Theodor-Heuss-Allee 9'   ,  28215, 'Bremen' , '0' );
INSERT INTO customer
  VALUES ( 118, 'Gerd Kelly'          , 'Windmuehlenstr 44'       ,  55131, 'Mainz' , '0' );
INSERT INTO customer
  VALUES ( 119, 'Michael Opel KG'     , 'Schillerstr 66'          ,  34117, 'Kassel' , '0' );
INSERT INTO customer
  VALUES ( 120, 'Heinz Will GmbH'     , 'Universitaetsstr 34'     ,  44227, 'Dortmund' , '0' );
INSERT INTO customer
  VALUES ( 201, 'Bikes a. Drives Ltd' , 'Marketstreet 4'          ,  NULL , 'Manchester' , '0' );
INSERT INTO customer
  VALUES ( 202, 'Vélo Detroux'        , 'Rue de Lille 1'          ,  NULL , 'Paris' , '0' );
INSERT INTO customer
  VALUES ( 203, 'Biciclo Luici'       , 'Piazza Castello 6'       ,  NULL , 'Milano' , '0' );
INSERT INTO customer
  VALUES ( 204, 'Fred Miller'         , 'Portugal street'         ,  NULL, 'London' , '0' );
INSERT INTO customer
  VALUES ( 205, 'Sven Gustavson'      , 'Odengatan 11'            ,  NULL , 'Stockholm' , '0' );

INSERT INTO staff
  VALUES ( 1, 'Mary Foster'     , 'Ebertstr 28'      , 93051, 'Regensburg', DATE '1979-07-05', 'marr', NULL, 4800.00 , '2' , 'Manager'    );
INSERT INTO staff
  VALUES ( 2, 'Anne Kraus'      , 'Kramgasse 5'      , 93047, 'Regensburg', DATE '1975-07-09', 'sngl' , 1   , 2300.00 , '3' , 'Agent'  );
INSERT INTO staff
  VALUES ( 4, 'Heinz Rolle'     , 'In der Au 5'      , 90455, 'Nuernberg' , DATE '1957-10-12', 'sngl' , 1   , 3300.00 , '3' , 'Secretary'  );
INSERT INTO staff
  VALUES ( 5, 'Johanna Koster'  , 'Wachtelstr 7'     , 90427, 'Nuernberg' , DATE '1984-02-07', 'divr' , 1   , 2100.00 , '5' , 'Agent'  );
INSERT INTO staff
  VALUES ( 6, 'Marianne Lambert', 'Fraunhofer Str 3' , 92224, 'Landshut'  , DATE '1974-05-22', 'marr', NULL, 4100.00 , '1' , 'Master'    );
INSERT INTO staff
  VALUES ( 3, 'Ursula Rank'     , 'Dreieichstr 12'   , 60594, 'Frankfurt' , DATE '1967-09-04', 'marr', 6   , 2700.00 , '1' , 'Clerc' );
INSERT INTO staff
  VALUES ( 7, 'Thomas Noster'   , 'Mahlergasse 10'   , 93047, 'Regensburg', DATE '1972-09-17', 'marr', 6   , 2500.00 , '5' , 'Labourer'   );
INSERT INTO staff
  VALUES ( 8, 'Renate Wolters'  , 'Lessingstr 9'     , 86159, 'Augsburg'  , DATE '1979-07-14', 'sngl' , 1   , 3300.00 , '4' , 'Clerc'  );
INSERT INTO staff
  VALUES ( 9, 'Ernst Patch'     , 'Olgastr 99'       , 70180, 'Stuttgart' , DATE '1992-03-29', 'sngl' , 6   , 800.00  , NULL, 'Apprentice'      );

INSERT INTO article
  VALUES ( 100001, 'Man City Bike'                  , 588.24, 111.76, 700.00, 'blue',    '26 inch', 'P' , 'E');
INSERT INTO article
  VALUES ( 100002, 'Woman City Bike'                , 546.22, 103.78, 650.00, 'red',     '26 inch', 'P' , 'E');
INSERT INTO article
  VALUES ( 200001, 'Man City Frame sprayed'         , 336.13,  63.87, 400.00, 'blue',    NULL     , 'P' , 'I');
INSERT INTO article
  VALUES ( 200002, 'Woman City Frame sprayed'       , 336.13,  63.87, 400.00, 'red',     NULL     , 'P' , 'I'); 
INSERT INTO article
  VALUES ( 300001, 'Man City Frame welded'          , 310.92,  59.08, 370.00, NULL,      NULL     , 'P' , 'I');
INSERT INTO article
  VALUES ( 300002, 'Woman City Frame welded'        , 310.92,  59.08, 370.00, NULL,      NULL     , 'P' , 'I');
INSERT INTO article
  VALUES ( 400001, 'Wheel'                          ,  58.82,  11.18,  70.00, NULL,      '26 inch', 'P' , 'I');
INSERT INTO article
  VALUES ( 500001, 'Pipe 25CrMo4 9mm'               ,   6.30,   1.20,   7.50, NULL,      '9mm'    , 'CM', 'F'); 
INSERT INTO article
  VALUES ( 500002, 'Saddle'                         ,  42.02,   7.98,  50.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500003, 'Group Deore LX'                 ,   5.88,   1.12,   7.00, NULL,      'LX'     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500004, 'Group Deore XT'                 ,   5.04,   0.96,   6.00, NULL,      'XT'     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500005, 'Group XC-LTD'                   ,   6.72,   1.28,   8.00, NULL,      'XC-LTD' , 'P' , 'F');
INSERT INTO article
  VALUES ( 500006, 'Rim'                            ,  33.61,   6.39,  40.00, NULL,      '26 inch', 'P' , 'F');
INSERT INTO article
  VALUES ( 500007, 'Set of tyres'                   ,  16.81,   3.19,  20.00, NULL,      '26 inch', 'P' , 'F');
INSERT INTO article
  VALUES ( 500008, 'Handlebars'                     ,  78.99,  15.01,  94.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500009, 'Saddle pillar'                  ,   4.62,   0.88,   5.50, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500010, 'Pedal'                          ,  33.61,   6.39,  40.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500011, 'Pipe 34CrMo4 2.1mm'             ,   3.36,   0.64,   4.00, NULL,      '2,1mm'  , 'CM', 'F');
INSERT INTO article
  VALUES ( 500012, 'Pipe 34CrMo3 2.4mm'             ,   3.61,   0.69,   4.30, NULL,      '2,4mm'  , 'CM', 'F');
INSERT INTO article
  VALUES ( 500013, 'Pedal bearing'                  ,  25.21,   4.79,  30.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500014, 'Shaft'                          ,  10.08,   1.92,  12.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500015, 'Tube'                           ,   6.72,   1.28,   8.00, NULL,      '26 inch', 'P' , 'F');
INSERT INTO article
  VALUES ( 100003, 'Man City Bike'                   , 588.24, 111.76, 700.00, 'black',   '26 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100004, 'Woman City Bike'                 , 546.22, 103.78, 650.00, 'black',   '26 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100005, 'Man City Bike'                   , 605.04, 114.96, 720.00, 'blue',    '28 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100006, 'Woman City Bike'                 , 563.03, 106.97, 670.00, 'red',     '28 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100007, 'Man City Bike'                   , 605.04, 114.96, 720.00, 'black',   '28 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100008, 'Woman City Bike'                 , 563.03, 106.97, 670.00, 'black',   '28 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100011, 'Man Trekking Bike'               , 630.25, 119.75, 750.00, 'blue',    '26 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100012, 'Woman Trekking Bike'             , 588.24, 111.76, 700.00, 'red',     '26 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100013, 'Man Trekking Bike'               , 630.25, 119.75, 750.00, 'black',   '26 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100014, 'Woman Trekking Bike'             , 588.24, 111.76, 700.00, 'black',   '26 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100015, 'Man Trekking Bike'               , 647.06, 122.94, 770.00, 'blue',    '28 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100016, 'Woman Trekking Bike'             , 605.04, 114.96, 720.00, 'red',     '28 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100017, 'Man Trekking Bike'               , 647.06, 122.94, 770.00, 'black',   '28 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100018, 'Woman Trekking Bike'             , 605.04, 114.96, 720.00, 'black',   '28 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100021, 'Mountainbike'                    , 588.24, 111.76, 700.00, 'black',   '26 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100022, 'Mountainbike'                    , 588.24, 111.76, 700.00, 'blue',    '26 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100023, 'Mountainbike'                    , 588.24, 111.76, 700.00, 'red',     '26 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100031, 'Juvenile bike'                   , 336.13,  63.87, 400.00, 'blue',    '24 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 100032, 'Juvenile bike'                   , 336.13,  63.87, 400.00, 'red',     '24 inch', 'P' , 'E' );
INSERT INTO article
  VALUES ( 200003, 'Man City Frame sprayed'          , 336.13,  63.87, 400.00, 'black',   NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 200004, 'Woman City Frame sprayed'        , 336.13,  63.87, 400.00, 'black',   NULL     , 'P' , 'I' );    
INSERT INTO article
  VALUES ( 200011, 'Man Trekking Frame sprayed'      , 352.94,  67.06, 420.00, 'blue',    NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 200012, 'Woman Trekking Frame sprayed'    , 352.94,  67.06, 420.00, 'red',     NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 200013, 'Man Trekking Frame sprayed'      , 352.94,  67.06, 420.00, 'black',   NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 200014, 'Woman Trekking Frame sprayed'    , 352.94,  67.06, 420.00, 'black',   NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 200021, 'Mountainbike Frame sprayed'      , 319.33,  60.67, 380.00, 'black',   NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 200022, 'Mountainbike Frame sprayed'      , 319.33,  60.67, 380.00, 'blue',    NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 200023, 'Mountainbike Frame sprayed'      , 319.33,  60.67, 380.00, 'red',     NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 200031, 'Juvenile bike Frame sprayed'     , 184.87,  35.13, 220.00, 'blue',    NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 200032, 'Juvenile bike Frame sprayed'     , 184.87,  35.13, 220.00, 'red',     NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 300011, 'Man Trekking Frame welded'       , 327.73,  62.27, 390.00, NULL,      NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 300012, 'Woman Trekking Frame welded'     , 327.73,  62.27, 390.00, NULL,      NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 300021, 'Mountainbike Frame welded'       , 294.12,  55.88, 350.00, NULL,      NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 300031, 'Juvenile bike Frame welded'      , 168.07,  31.93, 200.00, NULL,      NULL     , 'P' , 'I' );
INSERT INTO article
  VALUES ( 400002, 'Wheel'                           ,  63.03,  11.97,  75.00, NULL,      '28 inch', 'P' , 'I' );
INSERT INTO article
  VALUES ( 400003, 'Wheel'                           ,  50.42,   9.58,  60.00, NULL,      '24 inch', 'P' , 'I' );
INSERT INTO article
  VALUES ( 500028, 'Handlebar special'               ,  84.03,  15.97, 100.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500102, 'Saddle for women'                ,  42.02,   7.98,  50.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500103, 'Saddle for men'                  ,  42.02,   7.98,  50.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500104, 'Saddle comfort'                  ,  50.42,   9.58,  60.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500105, 'Saddle sport'                    ,  58.82,  11.18,  70.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500106, 'Saddle for children'             ,  25.21,   4.79,  30.00, NULL,      NULL     , 'P' , 'F');
INSERT INTO article
  VALUES ( 500201, 'Rim'                             ,  33.61,   6.39,  40.00, NULL,      '28 inch', 'P' , 'F');
INSERT INTO article
  VALUES ( 500202, 'Set of tyres'                    ,  16.81,   3.19,  20.00, NULL,      '28 inch', 'P' , 'F');
INSERT INTO article
  VALUES ( 500203, 'Rim'                             ,  29.41,   5.59,  35.00, NULL,      '24 inch', 'P' , 'F');
INSERT INTO article
  VALUES ( 500204, 'Set of tyres'                    ,  12.61,   2.39,  15.00, NULL,      '24 inch', 'P' , 'F');
INSERT INTO article
  VALUES ( 500301, 'Tube'                            ,   6.72,   1.28,   8.00, NULL,      '28 inch', 'P' , 'F');
INSERT INTO article 
  VALUES ( 500302, 'Tube'                            ,   6.72,   1.28,   8.00, NULL,      '24 inch', 'P' , 'F');

INSERT INTO store                      
  VALUES ( 100001, '001002',    3,    0,    2,    0 );         
INSERT INTO store
  VALUES ( 100002, '001001',    6,    0,    3,    0 );
INSERT INTO store
  VALUES ( 200001, NULL    ,    0,    0,    0,    0 );
INSERT INTO store
  VALUES ( 200002, '004004',    2,    0,    0,    0 );
INSERT INTO store
  VALUES ( 300001, NULL    ,    0,    0,    0,    0 );
INSERT INTO store
  VALUES ( 300002, '002001',    7,    0,    2,    0 );
INSERT INTO store
  VALUES ( 500001, '003005', 8050, 6000,  184,    0 );
INSERT INTO store
  VALUES ( 500002, '002002',   19,   20,    2,   10 );
INSERT INTO store
  VALUES ( 500003, '001003',   15,   10,    0,    0 );
INSERT INTO store
  VALUES ( 500004, '004001',   18,   10,    0,    0 );
INSERT INTO store
  VALUES ( 500005, '003002',    2,    0,    0,    0 );
INSERT INTO store
  VALUES ( 400001, '005001',    1,    0,    0,    0 );
INSERT INTO store
  VALUES ( 500006, '003004',   21,   20,    0,    0 );
INSERT INTO store
  VALUES ( 500007, '002003',   62,   40,    0,    0 );
INSERT INTO store
  VALUES ( 500008, '003003',   39,   20,    1,    0 );
INSERT INTO store
  VALUES ( 500009, '002007',   23,   20,    0,    0 );
INSERT INTO store
  VALUES ( 500010, '001006',   27,   20,    1,    0 );
INSERT INTO store
  VALUES ( 500011, '001007', 3250, 3000,  161,    0 );
INSERT INTO store
  VALUES ( 500012, '004002',  720,  600,   20,    0 );
INSERT INTO store
  VALUES ( 500013, '005002',   20,   20,    2,    0 );
INSERT INTO store
  VALUES ( 500014, '005003',   27,   20,    1,    0 );
INSERT INTO store
  VALUES ( 500015, '002004',   55,   40,    0,    0 );
INSERT INTO store                      
  VALUES ( 100003, '001003',    4,    0,    0,    1 );         
INSERT INTO store
  VALUES ( 100004, '001004',    1,    0,    0,    1 );
INSERT INTO store                      
  VALUES ( 100005, '001009',    2,    0,    0,    0 );         
INSERT INTO store
  VALUES ( 100006, '001011',    1,    0,    0,    0 );
INSERT INTO store                      
  VALUES ( 100007, '001006',    5,    0,    0,    0 );         
INSERT INTO store
  VALUES ( 100008, '001007',    3,    0,    0,    1 );
INSERT INTO store                      
  VALUES ( 100011, '001014',    2,    0,    0,    1 );         
INSERT INTO store                      
  VALUES ( 100013, '001012',    1,    0,    0,    1 );         
INSERT INTO store
  VALUES ( 100014, '001008',    1,    0,    0,    1 );
INSERT INTO store                      
  VALUES ( 100015, '001005',    2,    0,    0,    0 );         
INSERT INTO store
  VALUES ( 100016, '001015',    2,    0,    0,    0 );
INSERT INTO store                      
  VALUES ( 100017, '001016',    3,    0,    0,    0 );         
INSERT INTO store
  VALUES ( 100018, '001019',    2,    0,    0,    0 );
INSERT INTO store                      
  VALUES ( 100021, '001025',    2,    0,    0,    0 );         
INSERT INTO store                      
  VALUES ( 100023, '001022',    1,    0,    0,    1 );         
INSERT INTO store                      
  VALUES ( 100031, '001023',    4,    0,    0,    0 );         
INSERT INTO store
  VALUES ( 100032, '001021',    1,    0,    0,    1 );
INSERT INTO store
  VALUES ( 200004, '004006',    5,    0,    0,    0 );
INSERT INTO store
  VALUES ( 200011, '004009',    2,    0,    0,    0 );
INSERT INTO store
  VALUES ( 200012, NULL    ,    0,    0,    0,    0 );
INSERT INTO store
  VALUES ( 200014, '004008',    3,    0,    0,    0 );
INSERT INTO store
  VALUES ( 200021, NULL    ,    0,    0,    0,    0 );
INSERT INTO store
  VALUES ( 200022, '004012',    3,    0,    0,    0 );
INSERT INTO store
  VALUES ( 200023, '004011',    2,    0,    0,    0 );
INSERT INTO store
  VALUES ( 200031, '004015',    4,    0,    0,    0 );
INSERT INTO store
  VALUES ( 300011, '002005',    5,    0,    0,    0 );
INSERT INTO store
  VALUES ( 300012, NULL    ,    0,    0,    0,    0 );
INSERT INTO store
  VALUES ( 300021, '002009',    3,    0,    0,    0 );
INSERT INTO store
  VALUES ( 300031, '002008' ,    1,    0,    0,    1 );
INSERT INTO store
  VALUES ( 400002, '005008',    2,    0,    0,    2 );
INSERT INTO store
  VALUES ( 400003, '005007',    3,    0,    0,    0 );
INSERT INTO store
  VALUES ( 500103, NULL    ,    0,    0,    0,    0 );
INSERT INTO store
  VALUES ( 500104, '005011',    5,    0,    0,    0 );
INSERT INTO store
  VALUES ( 500105, '005012',    2,    0,    0,    0 );
INSERT INTO store
  VALUES ( 500106, '005010',    1,    0,    0,    1 );
INSERT INTO store
  VALUES ( 500201, '003009',   11,    0,    0,    0 );
INSERT INTO store
  VALUES ( 500202, '002013',   22,    0,    0,    0 );
INSERT INTO store
  VALUES ( 500203, '003009',   23,    0,    0,    0 );
INSERT INTO store
  VALUES ( 500301, '002017',   31,    0,    0,    0 );
INSERT INTO store
  VALUES ( 500302, NULL    ,    0,    0,    0,   20 );

INSERT INTO articlestructure
  VALUES ( 100001, 200001,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100001, 500002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100001, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100001, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100001, 500008,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100001, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100001, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100002, 200002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100002, 500002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100002, 500004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100002, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100002, 500008,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100002, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100002, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200001, 300001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200002, 300002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300001, 500001, 180 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300001, 500011, 161 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300001, 500012,  20 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300001, 500013,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300001, 500014,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300002, 500001, 360 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300002, 500011, 106 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300002, 500012,  20 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300002, 500013,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300002, 500014,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 400001, 500007,   2 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 400001, 500006,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 400001, 500015,   2 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100003, 200003,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100003, 500002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100003, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100003, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100003, 500008,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100003, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100003, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100004, 200004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100004, 500002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100004, 500004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100004, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100004, 500008,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100004, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100004, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100005, 200001,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100005, 500002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100005, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100005, 400002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100005, 500008,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100005, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100005, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100006, 200002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100006, 500002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100006, 500004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100006, 400002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100006, 500008,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100006, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100006, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100007, 200003,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100007, 500002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100007, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100007, 400002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100007, 500008,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100007, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100007, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100008, 200004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100008, 500002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100008, 500004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100008, 400002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100008, 500008,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100008, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100008, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100011, 200011,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100011, 500103,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100011, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100011, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100011, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100011, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100011, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100012, 200012,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100012, 500102,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100012, 500004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100012, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100012, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100012, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100012, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100013, 200013,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100013, 500103,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100013, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100013, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100013, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100013, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100013, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100014, 200014,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100014, 500102,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100014, 500004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100014, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100014, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100014, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100014, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100015, 200011,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100015, 500103,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100015, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100015, 400002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100015, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100015, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100015, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100016, 200012,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100016, 500102,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100016, 500004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100016, 400002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100016, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100016, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100016, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100017, 200013,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100017, 500103,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100017, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100017, 400002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100017, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100017, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100017, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100018, 200014,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100018, 500102,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100018, 500004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100018, 400002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100018, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100018, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100018, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100021, 200021,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100021, 500105,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100021, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100021, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100021, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100021, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100021, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100022, 200022,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100022, 500105,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100022, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100022, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100022, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100022, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100022, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100023, 200023,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100023, 500105,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100023, 500003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100023, 400001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100023, 500028,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100023, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100023, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100031, 200031,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100031, 500106,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100031, 500004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100031, 400003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100031, 500008,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100031, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100031, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100032, 200032,   1 , 'P'  );      
INSERT INTO articlestructure
  VALUES ( 100032, 500106,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100032, 500004,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100032, 400003,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100032, 500008,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100032, 500009,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 100032, 500010,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200003, 300001,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200004, 300002,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200011, 300011,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200012, 300012,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200013, 300011,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200014, 300012,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200021, 300021,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200022, 300021,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200023, 300021,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200031, 300031,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 200032, 300031,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300011, 500001, 200 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300011, 500011, 182 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300011, 500012,  20 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300011, 500013,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300011, 500014,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300012, 500001, 380 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300012, 500011, 126 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300012, 500012,  20 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300012, 500013,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300012, 500014,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300021, 500001, 350 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300021, 500011,  95 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300021, 500012,  20 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300021, 500013,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300021, 500014,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300031, 500001, 300 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300031, 500011,  80 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300031, 500012,  16 , 'CM' );
INSERT INTO articlestructure
  VALUES ( 300031, 500013,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 300031, 500014,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 400002, 500202,   2 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 400002, 500201,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 400002, 500301,   2 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 400003, 500204,   2 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 400003, 500203,   1 , 'P'  );
INSERT INTO articlestructure
  VALUES ( 400003, 500302,   2 , 'P'  );

INSERT INTO shipment
  VALUES ( 500001, 5, 1,   5.50, 0);
INSERT INTO shipment
  VALUES ( 500002, 2, 4,  36.60, 10);
INSERT INTO shipment
  VALUES ( 500002, 1, 5,  35.10, 0);
INSERT INTO shipment
  VALUES ( 500003, 3, 6,   5.60, 0);
INSERT INTO shipment
  VALUES ( 500003, 4, 5,   5.45, 0);
INSERT INTO shipment
  VALUES ( 500004, 3, 2,   4.70, 0);
INSERT INTO shipment
  VALUES ( 500004, 4, 3,   4.50, 0);
INSERT INTO shipment
  VALUES ( 500005, 4, 5,   5.70, 0);
INSERT INTO shipment
  VALUES ( 500006, 1, 1,  26.00, 0);
INSERT INTO shipment
  VALUES ( 500007, 1, 2,  15.50, 0);
INSERT INTO shipment
  VALUES ( 500008, 1, 4,  73.00, 0);
INSERT INTO shipment
  VALUES ( 500009, 1, 2,   4.00, 0);
INSERT INTO shipment
  VALUES ( 500009, 2, 1,   4.10, 0);
INSERT INTO shipment
  VALUES ( 500010, 1, 3,  29.90, 0);
INSERT INTO shipment
  VALUES ( 500011, 5, 1,   2.60, 0);
INSERT INTO shipment
  VALUES ( 500012, 5, 1,   3.20, 0);
INSERT INTO shipment
  VALUES ( 500013, 1, 4,  21.00, 0);
INSERT INTO shipment
  VALUES ( 500014, 1, 5,   9.00, 0);
INSERT INTO shipment
  VALUES ( 500015, 1, 1,   6.00, 0);
INSERT INTO shipment
  VALUES ( 500028, 1, 3,  89.00, 2);
INSERT INTO shipment
  VALUES ( 500102, 2, 2,  36.60, 0);
INSERT INTO shipment
  VALUES ( 500102, 1, 5,  35.50, 0);
INSERT INTO shipment
  VALUES ( 500103, 2, 2,  36.60, 0);
INSERT INTO shipment
  VALUES ( 500103, 1, 5,  35.50, 0);
INSERT INTO shipment
  VALUES ( 500104, 2, 2,  45.00, 0);
INSERT INTO shipment
  VALUES ( 500105, 1, 3,  52.30, 0);
INSERT INTO shipment
  VALUES ( 500106, 2, 2,  20.00, 0);
INSERT INTO shipment
  VALUES ( 500106, 1, 4,  19.10, 0);
INSERT INTO shipment
  VALUES ( 500201, 1, 1,  26.00, 0);
INSERT INTO shipment
  VALUES ( 500203, 1, 1,  26.00, 0);
INSERT INTO shipment
  VALUES ( 500202, 1, 2,  15.50, 0);
INSERT INTO shipment
  VALUES ( 500204, 1, 2,  15.50, 0);
INSERT INTO shipment
  VALUES ( 500301, 1, 1,   6.00, 0);
INSERT INTO shipment
  VALUES ( 500302, 1, 1,   6.00, 0);

COMMIT;

COPY FROM &User/&Password@//fbim.othr.de:1522/ora12c CREATE Orders USING SELECT * FROM SCHICKERDW.ORDERS;

COPY FROM &User/&Password@//fbim.othr.de:1522/ora12c CREATE Orderposition USING SELECT * FROM SCHICKERDW.ORDERPOSITION;

ALTER TABLE ORDERS
 ADD Constraint PK_order PRIMARY KEY (Ordid);
ALTER TABLE ORDERS
 ADD Constraint FK_order_customer FOREIGN KEY (Custid) REFERENCES customer;
ALTER TABLE ORDERS
 ADD Constraint FK_order_staff FOREIGN KEY (Staffid) REFERENCES staff ON DELETE SET NULL;
 
ALTER TABLE ORDERPOSITION
 ADD Constraint PK_orderposition PRIMARY KEY (Posid);
ALTER TABLE ORDERPOSITION
 ADD Constraint FK_order_order FOREIGN KEY (Ordid) REFERENCES orders ON DELETE CASCADE;
ALTER TABLE ORDERPOSITION
 ADD Constraint FK_order_article FOREIGN KEY (Artid) REFERENCES article;
ALTER TABLE ORDERPOSITION
 ADD Constraint AK_orderposition UNIQUE (ordid, artid);

CREATE TABLE articlereservation (
     posid       INTEGER    Constraint FK_article_order REFERENCES orderposition,
     artid       INTEGER    Constraint FK_article_article REFERENCES article,
     artcount    SMALLINT,
     Constraint PK_articlereservation PRIMARY KEY (posid, artid)
);


SET TERMOUT ON
SET FEEDBACK ON

PROMPT Example Database BIKE installed
