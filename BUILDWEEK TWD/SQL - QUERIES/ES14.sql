SELECT c.NomeCliente, SUM(t.QuantitaAcquistata) as Quantita, SUM(p.Prezzo * t.QuantitaAcquistata) as SpesaTot 
FROM BuildWeek.transazioni_dataset t
JOIN BuildWeek.clienti_dataset c ON c.ClienteID = t.ClienteID
JOIN BuildWeek.prodotti_dataset p ON p.ProdottoID = t.ProdottoID
GROUP BY c.NomeCliente;
 
