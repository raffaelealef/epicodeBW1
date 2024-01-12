with tab as(SELECT MONTH(DataRegistrazione) AS Mese, COUNT(*) AS Registrati
FROM BuildWeek.clienti_dataset
GROUP BY Mese
ORDER BY Mese)

SELECT AVG(Registrati) as MediaMensRegistrati FROM tab