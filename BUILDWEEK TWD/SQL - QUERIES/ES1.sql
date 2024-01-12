SELECT MONTH(t.DataTransazione) as MESE, 
SUM(p.Prezzo * t.QuantitaAcquistata) as TOTALE_VENDITE 
FROM BuildWeek.prodotti_dataset p
JOIN BuildWeek.transazioni_dataset t ON t.ProdottoID = p.ProdottoID
GROUP BY MESE
ORDER BY MESE;