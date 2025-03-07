SELECT *
FROM WA_Marketing_Campaign

SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN MarketID IS NULL THEN 1 ELSE 0 END) AS missing_marketID,
    SUM(CASE WHEN MarketSize IS NULL THEN 1 ELSE 0 END) AS missing_marketSize,
    SUM(CASE WHEN LocationID IS NULL THEN 1 ELSE 0 END) AS missing_locationID,
    SUM(CASE WHEN AgeOfStore IS NULL THEN 1 ELSE 0 END) AS missing_ageOfStore,
    SUM(CASE WHEN Promotion IS NULL THEN 1 ELSE 0 END) AS missing_promotion,
    SUM(CASE WHEN SalesInThousands IS NULL THEN 1 ELSE 0 END) AS missing_sales
FROM WA_Marketing_Campaign;

SELECT 
    Promotion, 
    ROUND(AVG(SalesInThousands), 2) AS AvgSales, 
    ROUND(SUM(SalesInThousands), 2) AS TotalSales,
    COUNT(*) AS NumStores
FROM WA_Marketing_Campaign
GROUP BY Promotion
ORDER BY AvgSales DESC;

SELECT 
    Week, 
    Promotion, 
    ROUND(AVG(SalesInThousands), 2) AS AvgSales
FROM WA_Marketing_Campaign
GROUP BY Week, Promotion
ORDER BY Week, AvgSales DESC;

SELECT 
    MarketSize, 
    Promotion, 
    ROUND(AVG(SalesInThousands), 2) AS AvgSales
FROM WA_Marketing_Campaign
GROUP BY MarketSize, Promotion
ORDER BY MarketSize, AvgSales DESC;

SELECT 
    CASE 
        WHEN AgeOfStore < 5 THEN 'New (0-5 yrs)'
        WHEN AgeOfStore BETWEEN 5 AND 10 THEN 'Mid (5-10 yrs)'
        ELSE 'Old (10+ yrs)'
    END AS StoreAgeGroup,
    Promotion, 
    ROUND(AVG(SalesInThousands), 2) AS AvgSales
FROM WA_Marketing_Campaign
GROUP BY 
    CASE 
        WHEN AgeOfStore < 5 THEN 'New (0-5 yrs)'
        WHEN AgeOfStore BETWEEN 5 AND 10 THEN 'Mid (5-10 yrs)'
        ELSE 'Old (10+ yrs)'
    END, 
    Promotion
ORDER BY StoreAgeGroup, AvgSales DESC;

SELECT 
    MarketSize, 
    Promotion, 
    ROUND(AVG(SalesInThousands), 2) AS AvgSales,
    RANK() OVER (PARTITION BY MarketSize ORDER BY AVG(SalesInThousands) DESC) AS Rank
FROM WA_Marketing_Campaign
GROUP BY MarketSize, Promotion;



