SELECT p.NomeProdotto as Prodotto, SUM(t.QuantitaAcquistata) AS Quantita
FROM BuildWeek.prodotti_dataset p
JOIN BuildWeek.transazioni_dataset t ON p.ProdottoID = t.ProdottoID
GROUP BY Prodotto
ORDER BY Quantita DESC
LIMIT 3;