DROP TABLE dproduct;
DROP TABLE ddate;
DROP TABLE dcustomer;
DROP TABLE facttable;
DROP TABLE zipcodes;
DROP sequence seq_dproduct;
DROP sequence seq_fact;
DROP sequence seq_dcustomer;
DROP sequence seq_ddate;

CREATE TABLE dproduct
  (
    psid      NUMBER CONSTRAINT psid_dproduct PRIMARY KEY,
    ArtId     NUMBER,
    Name      VARCHAR2(255),
    ProdgrID  NUMBER,
    Prodgroup VARCHAR(255),
    Color     VARCHAR2(255),
    Price     NUMBER
  );
  
CREATE TABLE ddate
  (
    dsid          NUMBER CONSTRAINT dsid_dproduct PRIMARY KEY,
    SalesDate     DATE,
    DAY           VARCHAR2(255),
    Week          VARCHAR2(255),
    WeekInYear    VARCHAR2(255),
    MONTH         VARCHAR2(255),
    MonthInYear   VARCHAR2(255),
    Monthname     VARCHAR2(255),
    Quarter       VARCHAR2(255),
    QuarterInYear VARCHAR2(255),
    YEAR          VARCHAR2(255)
  );
  
CREATE TABLE dcustomer
  (
    csid    NUMBER CONSTRAINT csid_dproduct PRIMARY KEY,
    CustId  NUMBER,
    Name    VARCHAR2(255),
    PLACE   VARCHAR2(255),
    STREET  VARCHAR2(255),
    ZIP     VARCHAR2(5),
    State   VARCHAR2(255),
    Country VARCHAR2(255)
  );
  
CREATE TABLE facttable
  (
    fsid NUMBER CONSTRAINT fsid_dproduct PRIMARY KEY,
    csid NUMBER,
    dsid NUMBER,
    psid NUMBER,
    price NUMBER,
    quantity NUMBER
  );
  
CREATE sequence seq_dproduct start with 1 increment BY 1 nocache nocycle;
CREATE sequence seq_fact start with 1 increment BY 1 nocache nocycle;
CREATE sequence seq_dcustomer start with 1 increment BY 1 nocache nocycle;
CREATE sequence seq_ddate start with 1 increment BY 1 nocache nocycle;

  INSERT INTO dproduct( PSID, ARTID, Name, Color, price)
  SELECT seq_dproduct.nextval, aid, name, color, price FROM article;
  
  UPDATE DPRODUCT d
  SET d.PRODGRID = 100,
    d.PRODGROUP  = Q'[Man's bicycles]'
  WHERE name LIKE '%Man%';
  
  UPDATE DPRODUCT d
  SET d.PRODGRID = 110,
    d.PRODGROUP  = Q'[Womans's bicycles]'
  WHERE name LIKE '%Woman%';
  
  UPDATE DPRODUCT d
  SET d.PRODGRID = 120,
    d.PRODGROUP  = Q'[Juvenile bicycles]'
  WHERE name LIKE '%Juvenile%';
  
  UPDATE DPRODUCT d
  SET d.PRODGRID   = 130,
    d.PRODGROUP    = Q'[Mountainbikes]'
  WHERE trim(name) = 'Mountainbike';
  UPDATE DPRODUCT d
  SET d.PRODGRID = 140,
    d.PRODGROUP  = 'Equipment'
  WHERE artid    > 500000;
  
  UPDATE DPRODUCT d
  SET d.PRODGRID = 150,
    d.PRODGROUP  = 'Intermediate Products'
  WHERE artid    > 200000
  AND d.ARTID    < 500000;
  

  INSERT INTO DCUSTOMER(CSID, CUSTID, NAME, STREET, PLACE, ZIP)
  SELECT seq_dcustomer.nextval,
    c.CID,
    c.NAME,
    c.STREET,
    c.PLACE,
    TO_CHAR(c.ZIP)
  FROM customer c;
  
  -- Wegen den 4 stelligen zip codes muss bei noch null forne angehängt werden
  UPDATE dcustomer SET zip= '0' || zip WHERE LENGTH(zip) = 4;
  
  CREATE TABLE zipcodes
    (
      code       VARCHAR2(2) PRIMARY KEY,
      postalName VARCHAR(255)
    );
    
  INSERT INTO zipcodes VALUES
    ('01', 'Sachsen'
    );
  INSERT INTO zipcodes VALUES
    ('02', 'Sachsen'
    );
  INSERT INTO zipcodes VALUES
    ('03', 'Brandenburg'
    );
  INSERT INTO zipcodes VALUES
    ('04', 'Sachsen'
    );
  INSERT INTO zipcodes VALUES
    ('06', 'Sachsen-Anhalt'
    );
  INSERT INTO zipcodes VALUES
    ('07', 'Thüringen'
    );
  INSERT INTO zipcodes VALUES
    ('08', 'Sachsen'
    );
  INSERT INTO zipcodes VALUES
    ('09', 'Sachsen'
    );
  INSERT INTO zipcodes VALUES
    ('10', 'Berlin'
    );
  INSERT INTO zipcodes VALUES
    ('12', 'Berlin'
    );
  INSERT INTO zipcodes VALUES
    ('13', 'Berlin'
    );
  INSERT INTO zipcodes VALUES
    ('14', 'Brandenburg'
    );
  INSERT INTO zipcodes VALUES
    ('15', 'Brandenburg'
    );
  INSERT INTO zipcodes VALUES
    ('16', 'Brandenburg'
    );
  INSERT INTO zipcodes VALUES
    ('17', 'Mecklenburg-Vorpommern'
    );
  INSERT INTO zipcodes VALUES
    ('18', 'Mecklenburg-Vorpommern'
    );
  INSERT INTO zipcodes VALUES
    ('19', 'Mecklenburg-Vorpommern'
    );
  INSERT INTO zipcodes VALUES
    ('20', 'Hamburg'
    );
  INSERT INTO zipcodes VALUES
    ('21', 'Niedersachsen'
    );
  INSERT INTO zipcodes VALUES
    ('22', 'Hamburg'
    );
  INSERT INTO zipcodes VALUES
    ('23', 'Schleswig-Holstein'
    );
  INSERT INTO zipcodes VALUES
    ('24', 'Schleswig-Holstein'
    );
  INSERT INTO zipcodes VALUES
    ('25', 'Schleswig-Holstein'
    );
  INSERT INTO zipcodes VALUES
    ('26', 'Niedersachsen'
    );
  INSERT INTO zipcodes VALUES
    ('27', 'Niedersachsen'
    );
  INSERT INTO zipcodes VALUES
    ('28', 'Bremen'
    );
  INSERT INTO zipcodes VALUES
    ('29', 'Niedersachsen'
    );
  INSERT INTO zipcodes VALUES
    ('30', 'Niedersachsen'
    );
  INSERT INTO zipcodes VALUES
    ('31', 'Niedersachsen'
    );
  INSERT INTO zipcodes VALUES
    ('32', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('33', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('34', 'Hessen'
    );
  INSERT INTO zipcodes VALUES
    ('35', 'Hessen'
    );
  INSERT INTO zipcodes VALUES
    ('36', 'Hessen'
    );
  INSERT INTO zipcodes VALUES
    ('37', 'Niedersachsen'
    );
  INSERT INTO zipcodes VALUES
    ('38', 'Niedersachsen'
    );
  INSERT INTO zipcodes VALUES
    ('39', 'Sachsen-Anhalt'
    );
  INSERT INTO zipcodes VALUES
    ('40', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('41', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('42', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('44', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('45', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('46', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('47', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('48', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('49', 'Niedersachsen'
    );
  INSERT INTO zipcodes VALUES
    ('50', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('51', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('52', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('53', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('54', 'Rheinland-Pfalz'
    );
  INSERT INTO zipcodes VALUES
    ('55', 'Rheinland-Pfalz'
    );
  INSERT INTO zipcodes VALUES
    ('56', 'Rheinland-Pfalz'
    );
  INSERT INTO zipcodes VALUES
    ('57', 'Rheinland-Pfalz'
    );
  INSERT INTO zipcodes VALUES
    ('58', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('59', 'Nordrhein-Westfalen'
    );
  INSERT INTO zipcodes VALUES
    ('60', 'Hessen'
    );
  INSERT INTO zipcodes VALUES
    ('61', 'Hessen'
    );
  INSERT INTO zipcodes VALUES
    ('63', 'Hessen'
    );
  INSERT INTO zipcodes VALUES
    ('64', 'Hessen'
    );
  INSERT INTO zipcodes VALUES
    ('65', 'Hessen'
    );
  INSERT INTO zipcodes VALUES
    ('66', 'Saarland'
    );
  INSERT INTO zipcodes VALUES
    ('67', 'Rheinland-Pfalz'
    );
  INSERT INTO zipcodes VALUES
    ('68', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('69', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('70', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('71', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('72', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('73', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('74', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('75', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('76', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('77', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('78', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('79', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('80', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('81', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('82', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('83', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('84', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('85', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('86', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('87', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('88', 'Baden-Württemberg'
    );
  INSERT INTO zipcodes VALUES
    ('89', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('90', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('91', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('92', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('93', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('94', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('95', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('96', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('97', 'Bayern'
    );
  INSERT INTO zipcodes VALUES
    ('98', 'Thüringen'
    );
  INSERT INTO zipcodes VALUES
    ('99', 'Thüringen'
    );
    
  UPDATE dcustomer c
  SET c.STATE =
    (SELECT z.POSTALNAME
    FROM ZIPCODES z
    WHERE SUBSTR(TO_CHAR(c.zip), 1,2) = TO_CHAR(z.code)
    );
    
  UPDATE dcustomer c
  SET c.Country =
    CASE
      WHEN c.zip IS NOT NULL
      THEN 'Germany'
      ELSE 'Foreign Country'
    END;
    
  DECLARE
    startDate DATE := to_date('1990-01-01', 'YYYY-MM-DD');
    endDate   DATE := to_date('2020-12-31', 'YYYY-MM-DD');
  BEGIN
    WHILE startDate != endDate
    LOOP
      INSERT
      INTO ddate VALUES
        (
          seq_ddate.nextval,
          startDate,
          TO_CHAR(startdate, 'DD'),
          TO_CHAR(startdate, 'WW'),
          TO_CHAR(startdate, 'WW-YYYY'),
          TO_CHAR(startdate, 'MM'),
          TO_CHAR(startdate, 'MM-YYYY'),
          TO_CHAR(startdate, 'MON'),
          TO_CHAR(startdate, 'Q'),
          TO_CHAR(startdate, 'Q-YYYY'),
          TO_CHAR(startdate, 'YYYY')
        );
      startdate := startdate + 1;
    END LOOP;
  END;
  /
              
  insert into facttable
  select seq_fact.nextval, CSID, DSID, PSID, (Totalprice/ Quantity), Quantity
  from Orders natural join Orderposition
              join ddate on ddate.SALESDATE = orders.ORDERDATE
              join dcustomer using (CUSTID)
              join dproduct using (ARTID);
           
-- 8a Example 1: How many men bicycles were sold in Hessen per month in 2011?
select * from facttable;
select sum(quantity), ddate.monthinyear
from facttable join dproduct using (psid)
              join ddate using (dsid)
              join dcustomer using (csid)
where dproduct.PRODGRID = 100 
    and year = 2011
    and state = 'Hessen'
group by ddate.MONTHINYEAR
order by ddate.MONTHINYEAR;
    
-- 8b Example 2: How was the sales volume per quarter and federal state in 2010?
select to_char(sum(quantity * facttable.PRICE), '999990D99') as gesamtVerkauf, ddate.QUARTERINYEAR, coalesce(dcustomer.STATE, 'Ausland') as state
from facttable join ddate using (dsid)
              join dcustomer using (csid)
where year = 2010
group by ddate.QUARTERINYEAR, dcustomer.STATE
order by gesamtVerkauf asc;

-- We want to know how many man’s bicycles were sold daily in November 2014. We are interested in all sales days and all man’s bicycles in all combinations (cross join)!
-- Take into account: the original relation DDate covers the sales days only! Days, where noth-ing has been sold, are not included. We are interested in a list of all days,
-- so please use the relation DDate from exercise 8.
select coalesce(sum(facttable.QUANTITY), 0) as sold, tempdate.day, tempdate.monthinyear, artid
from  facttable 
      right join (select * from dproduct where prodgrid = 100) using (psid)
      PARTITION BY  (artid)
      right join (select * from ddate where ddate.monthinyear = '11-2014') tempdate using (dsid) 
group by tempdate.day, tempdate.monthinyear, artid
order by tempdate.day, artid;