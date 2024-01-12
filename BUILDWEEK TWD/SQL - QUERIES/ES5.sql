SELECT p.Categoria, SUM(t.QuantitaAcquistata) as Quantita
FROM BuildWeek.prodotti_dataset p 
JOIN BuildWeek.transazioni_dataset t ON p.ProdottoID = t.ProdottoID
GROUP BY p.Categoria
ORDER BY Quantita DESC
LIMIT 1;
 