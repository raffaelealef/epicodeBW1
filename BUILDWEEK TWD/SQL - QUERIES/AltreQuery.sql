
-- quante transazioni fa in media un cliente
with tab as(select c.NomeCliente, count(t.DataTransazione) as cont from BuildWeek.transazioni_dataset t
JOIN BuildWeek.clienti_dataset c ON c.ClienteID = t.ClienteID
group By NomeCliente)

select avg(cont) from tab;
-- qual'è il valore della transazione media di un cliente
with tab1 as ( 
select c.NomeCliente,
SUM(p.Prezzo * t.QuantitaAcquistata) as TOTALE_VENDITE 
FROM BuildWeek.transazioni_dataset t
JOIN BuildWeek.prodotti_dataset p ON t.ProdottoID = p.ProdottoID
JOIN BuildWeek.clienti_dataset c ON c.ClienteID = t.ClienteID
group By c.NomeCliente
)

select  * from tab1 ORDER BY TOTALE_VENDITE;

with tab as(
select r.ProductID, p.Categoria, p.NomeProdotto, Count(r.Rating) as cont FROM BuildWeek.ratings_dataset r 
JOIN BuildWeek.prodotti_dataset p ON r.ProductID = p.ProdottoID
WHERE r.Rating = 5
GROUP BY r.ProductID)

select ProductID, NomeProdotto, Categoria, cont from tab WHERE cont = (SELECT max(cont) from tab);


select c.NomeCliente, count(*) as SOMMA_RECENSIONI FROM BuildWeek.ratings_dataset r
JOIN BuildWeek.clienti_dataset c on c.ClienteID = r.CustomerID
GROUP BY c.NomeCliente;



