with tab as(SELECT CustomerID, count(*) cont FROM BuildWeek.ratings_dataset
group by CustomerID)


select CustomerId, cont from tab where cont = (select max(cont) from tab)
group by CustomerID;

with tab1 As(
SELECT s.MetodoSpedizione, 
DATEDIFF(s.DataSpedizione, t.DataTransazione) as DifferenzaDate
from BuildWeek.spedizioni_dataset s
join BuildWeek.transazioni_dataset t
on s.IDSpedizione = t.IDSpedizione
)

SELECT 
MetodoSpedizione, AVG(DifferenzaDate)
from tab1
group by MetodoSpedizione
