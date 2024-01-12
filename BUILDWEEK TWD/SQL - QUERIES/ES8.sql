SELECT p.NomeProdotto, AVG(r.Rating) as MediaRecensioni FROM BuildWeek.prodotti_dataset p
JOIN BuildWeek.ratings_dataset r ON r.ProductID = p.ProdottoID
GROUP BY p.NomeProdotto
HAVING MediaRecensioni >= (SELECT MAX(Rating) FROM BuildWeek.ratings_dataset)
ORDER BY MediaRecensioni DESC

