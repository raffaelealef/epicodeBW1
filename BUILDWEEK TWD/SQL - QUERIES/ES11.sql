with tab as(
SELECT MetodoSpedizione, COUNT(*) AS Utilizzati
FROM BuildWeek.spedizioni_dataset 
GROUP BY MetodoSpedizione)

SELECT MetodoSpedizione, Utilizzati
FROM tab
WHERE Utilizzati = (SELECT MAX(Utilizzati) FROM tab)




