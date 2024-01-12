with VenditeTot as (SELECT MONTH(t.DataTransazione) as Mese, SUM(p.Prezzo * t.QuantitaAcquistata) as VenditaMens
FROM BuildWeek.transazioni_dataset t
JOIN BuildWeek.prodotti_dataset p ON p.ProdottoID = t.ProdottoID
GROUP BY Mese
ORDER BY Mese)

SELECT Mese,VenditaMens FROM VenditeTot 
WHERE VenditaMens = (SELECT MAX(VenditaMens) FROM VenditeTot) 