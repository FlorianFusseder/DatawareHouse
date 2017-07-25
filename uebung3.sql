--10
select coalesce(sum(facttable.QUANTITY), 0) as sold, tempdate.day, tempdate.monthinyear, artid
from  (select * from ddate where ddate.monthinyear = '11-2014') tempdate 
      cross join 
      (select * from dproduct where prodgrid = 100)
      left outer join facttable using (dsid, psid) 
group by tempdate.day, tempdate.monthinyear, artid
order by tempdate.day, artid;

--13    
Create dimension Date_Dim
Level day is ddate.Salesdate
level week is ddate.week
level month is ddate.month
level quarter is ddate.quarter
level year is ddate.year
Hierarchy calendar_rollup
(day child of week child of month child of quarter child of year);

select * from user_dimensions;

--15
select 
  csid, 
  c.name, 
  monthinyear, 
  PRODGROUP, 
  to_char(coalesce(sum(f.price * f.quantity), 0), '99G999D99') as Volume,
  to_char(coalesce(100*Ratio_to_Report(sum(f.price * f.quantity)) over (partition by(dproduct.PRODGROUP)), 0), '99D99') || '%' as Percent
from facttable f
join dproduct using(psid)
right join (select * from ddate where monthinyear = '02-2014') using (dsid)
partition by(prodgroup, monthinyear)
right join (select * from dcustomer where state = 'Bayern') c using(csid)
group by csid, c.name, monthinyear, PRODGROUP
order by prodgroup, csid;

--16
select c.name, sum(price * quantity) as SalesVolume, rank() over( order by sum(price * quantity) desc ) as rrank
from facttable f
join dcustomer c using (csid)
group by c.name
order by c.name;

--17
SELECT *
FROM
(SELECT C.Custid, C.Name, d.month, D.Monthinyear,
        Coalesce(Sum(F.Price*F.Quantity),0) As "Sales 2014",
        LAG(Sum(F.PRICE*F.QUANTITY),1,0) OVER (ORDER BY Custid,Month) As "Sales 2013",
        LAG(Sum(F.PRICE*F.QUANTITY),2,0) OVER (ORDER BY Custid,Month) As "Sales 2012",
        LAG(Sum(F.PRICE*F.QUANTITY),3,0) OVER (ORDER BY Custid,Month) AS "Sales 2011"
 FROM   Facttable F RIGHT OUTER JOIN DCustomer C USING(CSid) 
                  PARTITION BY (Custid, Name)
                  RIGHT OUTER JOIN (SELECT * 
                                     FROM  DDate 
                                     WHERE Year BETWEEN 2011 AND 2014
                                       AND Month = '01')        D     USING(DSid)
 GROUP BY C.Custid, C.Name, D.Month, D.monthinYear
)
Where monthinyear = '01-2014'
Order By Name;

--18
select * 
from(
select salesdate, 
sum(f.price*f.quantity) as dailySale,
sum(sum(f.price*f.quantity)) over(order by salesdate rows between 1 preceding and 1 following) as threeDay,
to_char(avg(sum(f.price*f.quantity)) over(order by salesdate rows between 1 preceding and 1 following), '99G999D99') as threeAverage
from facttable f
right join (select * from ddate where salesdate between '30-DEC-2013' and '02-FEB-2014') using(dsid)
group by salesdate
order by salesdate
)
where salesdate between '31-DEC-2013' and '01-FEB-2014';

--21
select  Coalesce(To_Char(Day),'--Sum:') AS Day, 
        Coalesce(To_Char(Month),'--Sum:') AS Month, 
        Coalesce(To_Char(Year),'--Sum:') AS Year, 
        Sum(Quantity*Price) AS Salesvolume
from facttable
right join (select * from dcustomer where state = 'Bayern') using(csid)
right join ddate d using(dsid)
where year = '2014'
--group by rollup(year, month, day);
group by grouping sets((day, month, year),(month, year),(year),());
