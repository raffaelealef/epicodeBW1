use BuildWeek;

-- 1. Quali prodotti vendono meglio in determinati periodi dell’anno?
with tab as(
select MONTH(t.DataTransazione) as mese, p.NomeProdotto, SUM(p.Prezzo * t.QuantitaAcquistata) as Transazione
from prodotti_dataset p
join transazioni_dataset t on t.ProdottoID = p.ProdottoID
group by mese, p.NomeProdotto
order by mese
)
select * from tab;

-- 2. Selezione i primi 3 clienti che hanno il prezzo medio di acquisto più alto in ogni categoria di prodotto.
with tab as (
select c.NomeCliente, p.Categoria, AVG(p.Prezzo * t.QuantitaAcquistata) as MediaSpesaTot,
ROW_NUMBER() OVER (PARTITION BY p.Categoria ORDER BY AVG(p.Prezzo * t.QuantitaAcquistata) DESC) AS Top
from prodotti_dataset p
join transazioni_dataset t on t.ProdottoID = p.ProdottoID
join clienti_dataset c on c.ClienteID = t.ClienteID
group by c.NomeCliente, p.Categoria)

select NomeCliente, Categoria, MediaSpesaTot from tab where Top<=3;

-- 3. Numero di prodotti con una quantità disponibile inferiore alla media.
select count(*) from prodotti_dataset
where QuantitaDisponibile < (SELECT AVG(QuantitaDisponibile) from prodotti_dataset);

-- 4. Media delle recensioni dei clienti il cui tempo di elaborazione dell'ordine è inferiore a 300gg 
with tab as(SELECT t.ClienteID, s.MetodoSpedizione, 
DATEDIFF(s.DataSpedizione, t.DataTransazione) as TempoElab
from BuildWeek.spedizioni_dataset s
join BuildWeek.transazioni_dataset t
on s.IDSpedizione = t.IDSpedizione
order by t.ClienteID
)

select t.ClienteID, avg(Rating) as MediaRecensioni, avg(t.TempoElab) as TempoElab from tab t 
join ratings_dataset r on r.CustomerID = t.ClienteID
where t.TempoElab < 300
group by t.ClienteID;

-- 5. Valutazione del tempo in anni in cui viene gestita una spedizione con visualizzazione di "Più di un anno" o "Meno di un anno" in una colonna calcolata.
SELECT t.IDTransazione, 
DATEDIFF(s.DataSpedizione, t.DataTransazione) as TempoElab,
IF(DATEDIFF(s.DataSpedizione, t.DataTransazione) > 365, "Piu di un anno", "Meno di un anno")
from BuildWeek.spedizioni_dataset s
join BuildWeek.transazioni_dataset t
on s.IDSpedizione = t.IDSpedizione
order by t.IDTransazione;

-- 6. Totale delle disponibilità in magazzino dei prodotti divisi per categoria
select Categoria, SUM(QuantitaDisponibile) from prodotti_dataset
group by Categoria;

-- 7 Si vuole stampare Nome del cliente, Importo transazione (prezzo * quantità),Nome Prodotto e Rating MEDIO del prodotto. Aggiungere colonna OUTPUT che avrà i seguenti valori:
-- SE la transazione supera il valore medio di tutte le transazioni dell’anno stampare “Sopra La Media” altrimenti “Sotto la media”
with tab1 AS (
select c.NomeCliente, (p.Prezzo * t.QuantitaAcquistata) as Transazione,
p.NomeProdotto, 
(SELECT avg(Rating) from BuildWeek.ratings_dataset 
WHERE ProductID = p.ProdottoID) as MediaRating
from BuildWeek.transazioni_dataset t
join BuildWeek.prodotti_dataset p on t.prodottoID = p.ProdottoID
join BuildWeek.clienti_dataset c on t.ClienteID = c.ClienteID
)

SELECT *,
CASE 
when (
((Transazione - (SELECT avg(Transazione) from tab1))/(SELECT avg(Transazione) from tab1)
) * 100 > 0) THEN "Sopra La Media"
ELSE "Sotto La Media"
END AS OUTPUT
FROM tab1;

-- 8. Trovare tutti i clienti che si sono registrati nel mese con più profitto
with tab as(
select MONTH(t.DataTransazione) as mese, SUM(p.Prezzo * t.QuantitaAcquistata) as SommaTrans
from BuildWeek.transazioni_dataset t
join BuildWeek.prodotti_dataset p on t.prodottoID = p.ProdottoID
group by mese
order by SommaTrans DESC
limit 1 
)

select NomeCliente, DataRegistrazione from clienti_dataset 
where MONTH(DataRegistrazione) = (select mese from tab);

-- 9. Trovare i prodotti con il rating più alto, insieme al nome del cliente che ha dato il rating più alto a ciascun prodotto. 
select CustomerID, ProductID, MAX(Rating) from ratings_dataset
group by CustomerID, ProductID





