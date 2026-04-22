WITH transaction_summary AS (
    SELECT
        o.Date                                           AS order_date,
        pc.CategoryName                                  AS category_name,
        p.ProdName                                       AS product_name,
        p.Price                                          AS product_price,
        o.Quantity                                       AS order_qty,
        ROUND(CAST(p.Price AS NUMERIC) * o.Quantity, 2)  AS total_sales,
        SPLIT(c.CustomerEmail, '#')[OFFSET(0)]           AS cust_email,
        c.CustomerCity                                   AS cust_city

    FROM       `rakamin-493213.UserChurn.Orders`          o
    INNER JOIN `rakamin-493213.UserChurn.Products`        p  ON p.ProdNumber = o.ProdNumber
    INNER JOIN `rakamin-493213.UserChurn.ProductCategory` pc ON pc.CategoryID = p.Category
    INNER JOIN `rakamin-493213.UserChurn.Customers`       c  ON c.CustomerID  = o.CustomerID
)

SELECT *
FROM   transaction_summary
ORDER BY order_date ASC, order_qty ASC;