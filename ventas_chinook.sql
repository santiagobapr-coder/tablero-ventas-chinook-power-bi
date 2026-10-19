-- Tabla de datos para el tablero de Power BI: una fila por línea de factura.
-- Motor: SQLite (base Chinook). El resultado se exportó a ventas_chinook.csv.
SELECT il.InvoiceLineId                       AS LineaId,
       i.InvoiceId                            AS FacturaId,
       date(i.InvoiceDate)                    AS Fecha,
       c.CustomerId                           AS ClienteId,
       c.FirstName || ' ' || c.LastName       AS Cliente,
       i.BillingCountry                       AS Pais,
       e.FirstName || ' ' || e.LastName       AS Representante,
       t.Name                                 AS Cancion,
       ar.Name                                AS Artista,
       al.Title                               AS Album,
       g.Name                                 AS Genero,
       m.Name                                 AS Formato,
       il.UnitPrice                           AS PrecioUnitario,
       il.Quantity                            AS Cantidad,
       ROUND(il.UnitPrice * il.Quantity, 2)   AS Ingreso
FROM InvoiceLine il
JOIN Invoice   i  ON i.InvoiceId   = il.InvoiceId
JOIN Customer  c  ON c.CustomerId  = i.CustomerId
LEFT JOIN Employee e ON e.EmployeeId = c.SupportRepId
JOIN Track     t  ON t.TrackId     = il.TrackId
JOIN Album     al ON al.AlbumId    = t.AlbumId
JOIN Artist    ar ON ar.ArtistId   = al.ArtistId
LEFT JOIN Genre g ON g.GenreId     = t.GenreId
JOIN MediaType m  ON m.MediaTypeId = t.MediaTypeId
ORDER BY il.InvoiceLineId;
