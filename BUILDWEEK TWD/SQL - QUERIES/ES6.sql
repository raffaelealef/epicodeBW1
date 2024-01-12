SELECT c.NomeCliente AS Cliente, SUM(p.Prezzo * t.QuantitaAcquistata) as ValoreTotale
FROM BuildWeek.clienti_dataset c
JOIN BuildWeek.transazioni_dataset t ON c.ClienteID = t.ClienteID
JOIN BuildWeek.prodotti_dataset p ON p.ProdottoID = t.ProdottoID
GROUP BY Cliente
ORDER BY ValoreTotale DESC
LIMIT 1;
