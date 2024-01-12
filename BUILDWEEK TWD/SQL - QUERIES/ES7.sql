SELECT (count(*) / (SELECT count(*) FROM BuildWeek.spedizioni_dataset))*100 AS Percentuale
FROM BuildWeek.spedizioni_dataset
WHERE StatusConsegna = "Consegna Riuscita"








