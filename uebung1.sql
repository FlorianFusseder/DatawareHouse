DROP TABLE fact1;
DROP SEQUENCE fact1_seq;
CREATE SEQUENCE fact1_seq start with 1 increment BY 1;
  CREATE TABLE Fact1
    (
      FSID       NUMBER PRIMARY KEY,
      ArtId      INTEGER CONSTRAINT FK_Fact_A REFERENCES Article,
      CustId     INTEGER CONSTRAINT FK_Fact_C REFERENCES Customer,
      OrderId    INTEGER CONSTRAINT FK_Fact_O REFERENCES Orders,
      SalesDate  DATE,
      SalesMonth CHAR(2),
      SalesYear  CHAR(4),
      Price      NUMERIC(7,2),
      Quantity   SMALLINT
    ) ;
    
  INSERT
  INTO fact1 f
    (
      f.FSID,
      f.ARTID,
      f.CUSTID,
      f.ORDERID,
      f.SALESDATE,
      f.SALESYEAR,
      f.SALESMONTH,
      f.PRICE,
      f.QUANTITY
    )
  SELECT fact1_seq.nextval,
    op.ArtId,
    o.CustId,
    o.OrdId,
    o.OrderDate,
    TO_CHAR(o.orderdate, 'yyyy'),
    TO_CHAR(o.orderdate, 'mm'),
    (op.Totalprice / op.Quantity),
    op.Quantity
  FROM ORDERS o
  JOIN ORDERPOSITION op
  ON o.ORDID = op.ORDID;
  SELECT * FROM fact1;
  SELECT * FROM orders;
  SELECT * FROM orderposition;
  SELECT * FROM customer;
  SELECT name,
    SUM(FACT1.QUANTITY * FACT1.PRICE) AS sold
  FROM FACT1
  JOIN CUSTOMER
  ON (CUSTOMER.CID      =FACT1.CUSTID)
  WHERE FACT1.SALESYEAR = '2010'
  GROUP BY name
  ORDER BY sold DESC;
  --------------------------------------------------------------------------------
  DROP TABLE fact1_month;
  DROP sequence myseq;
  CREATE TABLE fact1_month
    (
      MID      INTEGER PRIMARY KEY,
      ARTID    INTEGER REFERENCES article,
      MONTH    CHAR(2),
      YEAR     CHAR(4),
      PRICE    NUMERIC(7,2),
      QUANTITY INTEGER
    );
CREATE sequence myseq start with 1 increment BY 1;
  INSERT INTO fact1_month
    (MID, ARTID, MONTH, YEAR, PRICE, QUANTITY
    )
  SELECT myseq.nextval,
    temp.*
  FROM
    (SELECT ARTID,
      SALESMONTH,
      SALesyear,
      SUM(price),
      SUM(quantity)
    FROM fact1
    GROUP BY artid,
      salesmonth,
      salesyear
    ) temp;
  --------------------------------------------------------------------------------
  CREATE VIEW VFACT1 AS
  SELECT * FROM FACT1;
  CREATE VIEW VFACT1_MONTH AS
  SELECT * FROM FACT1_MONTH;
  --------------------------------------------------------------------------------
  DROP materialized VIEW MFACT1;
  DROP materialized VIEW MFACT1_MONTH;
CREATE materialized VIEW MFACT1
AS
  SELECT * FROM FACT1;
CREATE materialized VIEW MFACT1 refresh COMPLETE start with sysdate + 2/24 NEXT ROUND(SYSDATE + 1) + 1/24
AS
  SELECT * FROM FACT1;
CREATE materialized VIEW MFACT1_MONTH refresh COMPLETE start with sysdate + 2/24 NEXT ROUND(SYSDATE + 1) + 1/24
AS
  SELECT * FROM FACT1_MONTH;