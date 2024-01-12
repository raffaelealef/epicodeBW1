SELECT c.NomeCliente AS Cliente, SUM(t.QuantitaAcquistata) as Quantita
FROM BuildWeek.clienti_dataset c
JOIN BuildWeek.transazioni_dataset t ON c.ClienteID = t.ClienteID
GROUP BY Cliente
ORDER BY Quantita DESC
LIMIT 1;

