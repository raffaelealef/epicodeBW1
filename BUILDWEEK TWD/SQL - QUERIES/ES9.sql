with TAB1 as (
SELECT MONTH(t.DataTransazione) as Mese, SUM(p.Prezzo * t.QuantitaAcquistata) as TotVendite
FROM BuildWeek.transazioni_dataset t
JOIN BuildWeek.prodotti_dataset p ON p.ProdottoID = t.ProdottoID
GROUP BY Mese
ORDER BY Mese)

SELECT TAB1.Mese, TAB1.TotVendite AS VenditeMeseCorr, TAB2.TotVendite AS VenditeMesePrec,
-COALESCE((((TAB2.TotVendite - TAB1.TotVendite)/TAB2.TotVendite)*100), 0) AS Variazione
FROM TAB1
LEFT JOIN TAB1 TAB2 ON TAB1.Mese = TAB2.Mese + 1;








