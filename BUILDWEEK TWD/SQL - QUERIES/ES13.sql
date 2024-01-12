SELECT NomeProdotto, QuantitaDisponibile 
FROM BuildWeek.prodotti_dataset
WHERE QuantitaDisponibile < (SELECT AVG(QuantitaDisponibile) FROM BuildWeek.prodotti_dataset)

