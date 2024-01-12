SELECT (count(*) / (SELECT count(*) FROM BuildWeek.spedizioni_dataset))*100
FROM BuildWeek.spedizioni_dataset
WHERE StatusConsegna = "In Consegna"