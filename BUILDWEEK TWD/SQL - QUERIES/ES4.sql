SELECT p.Categoria, AVG(p.Prezzo * t.QuantitaAcquistata) as PrezzoMedio 
FROM BuildWeek.prodotti_dataset p
JOIN BuildWeek.transazioni_dataset t ON t.ProdottoID = p.ProdottoID
GROUP BY p.Categoria;



