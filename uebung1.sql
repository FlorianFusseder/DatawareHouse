drop table fact1;

create SEQUENCE fact1_seq
start with 1
increment by 1;

CREATE TABLE Fact1 (
FSID NUMBER primary key, 
ArtId INTEGER Constraint FK_Fact_A REFERENCES Article,
CustId INTEGER Constraint FK_Fact_C REFERENCES Customer,
OrderId INTEGER Constraint FK_Fact_O REFERENCES Orders,
SalesDate DATE,
SalesMonth CHAR(2),
SalesYear CHAR(4),
Price NUMERIC(7,2),
Quantity SMALLINT ) ;


insert into fact1 f (f.FSID, f.ARTID, f.CUSTID, f.ORDERID, f.SALESDATE, f.SALESYEAR, f.SALESMONTH, f.PRICE, f.QUANTITY )
select fact1_seq.nextval, op.ArtId, o.CustId, o.OrdId, o.OrderDate, TO_CHAR(o.orderdate, 'yyyy'), TO_CHAR(o.orderdate, 'mm'), (op.Totalprice / op.Quantity), op.Quantity
from ORDERS o join ORDERPOSITION op
on o.ORDID = op.ORDID;

select * from fact1;