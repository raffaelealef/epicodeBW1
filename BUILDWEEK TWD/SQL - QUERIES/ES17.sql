SELECT c.NomeCliente, c.ClienteID FROM BuildWeek.transazioni_dataset t 
RIGHT JOIN BuildWeek.clienti_dataset c ON c.ClienteID = t.ClienteID
WHERE c.ClienteID IS NULL OR t.ClienteID IS NULL