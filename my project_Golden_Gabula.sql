SHOW DATABASES;
USE retail_sales;
select database();

SELECT COUNT(*) 
FROM retail_transactions;

SELECT COUNT(*) AS Total_Records
FROM retail_transactions;
SHOW TABLE STATUS WHERE NAME = 'retail_transactions';
describe retail_transactions;

SELECT Transaction Date
FROM retail_transactions;

describe retail_transactions;

select * from retail_transactions LIMIT 10;

select 1;

SELECT Transaction Date
FROM retail_transactions
LIMIT 5;

USE retail_sales;

SELECT Transaction Date
FROM retail_transactions
LIMIT 5;

USE retail_sales;


SELECT Transaction_Date
FROM retail_transactions
LIMIT 5;

describe retail_transactions;

USE retail_sales;

SELECT 'Transaction Date'
FROM retail_transactions
LIMIT 5;

USE retail_sales;

SELECT *
FROM retail_transactions
LIMIT 10;

SELECT COUNT(*) AS Total_Transactions
FROM retail_transactions;

SELECT
    COUNT(*) - COUNT(`Transaction Date`) AS Missing_Dates,
    COUNT(*) - COUNT(`Sales Type`) AS Missing_Sales_Type,
    COUNT(*) - COUNT(`Is Return`) AS Missing_Return_Status,
    COUNT(*) - COUNT(`Supplier`) AS Missing_Supplier,
    COUNT(*) - COUNT(`Product No`) AS Missing_Product_No,
    COUNT(*) - COUNT(`Product Description`) AS Missing_Description
FROM retail_transactions;

SELECT
    SUM(CASE WHEN TRIM(`Transaction Date`) = '' THEN 1 ELSE 0 END) AS Blank_Dates,
    SUM(CASE WHEN TRIM(`Sales Type`) = '' THEN 1 ELSE 0 END) AS Blank_Sales_Type,
    SUM(CASE WHEN TRIM(`Supplier`) = '' THEN 1 ELSE 0 END) AS Blank_Supplier,
    SUM(CASE WHEN TRIM(`Product No`) = '' THEN 1 ELSE 0 END) AS Blank_Product_No,
    SUM(CASE WHEN TRIM(`Product Description`) = '' THEN 1 ELSE 0 END) AS Blank_Descriptions
FROM retail_transactions;

DESCRIBE retail_transactions;

SELECT
    `Transaction Date`,
    `Sales Type`,
    `Is Return`,
    `Reason of Return`,
    `Supplier`,
    `Product No`,
    `Product Description`,
    `Product Division`,
    `Product Category`,
    `Product Subcategory`,
    `Product Segment`,
    `Store`,
    `Sales Channel`,
    `Qty Sold`,
    `Sales Amount`,
    `Cogs`,
    `Number of Transactions`,
    COUNT(*) AS Duplicate_Count
FROM retail_transactions
GROUP BY
    `Transaction Date`,
    `Sales Type`,
    `Is Return`,
    `Reason of Return`,
    `Supplier`,
    `Product No`,
    `Product Description`,
    `Product Division`,
    `Product Category`,
    `Product Subcategory`,
    `Product Segment`,
    `Store`,
    `Sales Channel`,
    `Qty Sold`,
    `Sales Amount`,
    `Cogs`,
    `Number of Transactions`
HAVING COUNT(*) > 1
LIMIT 20;

SELECT
    SUM(CASE WHEN `Qty Sold` < 0 THEN 1 ELSE 0 END) AS Negative_Quantities,
    SUM(CASE WHEN `Sales Amount` < 0 THEN 1 ELSE 0 END) AS Negative_Sales,
    SUM(CASE WHEN `Cogs` < 0 THEN 1 ELSE 0 END) AS Negative_Cogs
FROM retail_transactions;

SELECT
    `Is Return`,
    COUNT(*) AS Total_Records,
    SUM(CASE WHEN `Qty Sold` < 0 THEN 1 ELSE 0 END) AS Negative_Quantity,
    SUM(CASE WHEN `Sales Amount` < 0 THEN 1 ELSE 0 END) AS Negative_Sales,
    SUM(CASE WHEN Cogs < 0 THEN 1 ELSE 0 END) AS Negative_Cogs
FROM retail_transactions
GROUP BY `Is Return`;

SELECT
    COALESCE(
        NULLIF(TRIM(`Reason of Return`), ''),
        'Not specified'
    ) AS Return_Reason,

    COUNT(*) AS Returned_Transactions,

    ROUND(SUM(ABS(`Sales Amount`)), 2) AS Returned_Sales_Value

FROM retail_transactions

WHERE `Is Return` = 1

GROUP BY Return_Reason

ORDER BY Returned_Transactions DESC;

SELECT
    COUNT(*) AS Total_Returns,

    SUM(
        CASE
            WHEN `Reason of Return` IS NULL
            THEN 1 ELSE 0
        END
    ) AS Null_Reasons,

    SUM(
        CASE
            WHEN TRIM(COALESCE(`Reason of Return`, '')) = ''
            THEN 1 ELSE 0
        END
    ) AS Missing_Reasons

FROM retail_transactions
WHERE `Is Return` = 1;

SELECT
    COUNT(*) - COUNT(`Product Division`) AS Missing_Division,
    COUNT(*) - COUNT(`Product Category`) AS Missing_Category,
    COUNT(*) - COUNT(`Product Subcategory`) AS Missing_Subcategory,
    COUNT(*) - COUNT(`Product Segment`) AS Missing_Segment,
    COUNT(*) - COUNT(`Store`) AS Missing_Store,
    COUNT(*) - COUNT(`Sales Channel`) AS Missing_Channel,
    COUNT(*) - COUNT(`Qty Sold`) AS Missing_Quantity,
    COUNT(*) - COUNT(`Sales Amount`) AS Missing_Sales,
    COUNT(*) - COUNT(`Cogs`) AS Missing_COGS,
    COUNT(*) - COUNT(`Number of Transactions`) AS Missing_Transactions
FROM retail_transactions;


SELECT
    SUM(CASE WHEN TRIM(`Product Division`) = '' THEN 1 ELSE 0 END) AS Blank_Division,
    SUM(CASE WHEN TRIM(`Product Category`) = '' THEN 1 ELSE 0 END) AS Blank_Category,
    SUM(CASE WHEN TRIM(`Product Subcategory`) = '' THEN 1 ELSE 0 END) AS Blank_Subcategory,
    SUM(CASE WHEN TRIM(`Product Segment`) = '' THEN 1 ELSE 0 END) AS Blank_Segment,
    SUM(CASE WHEN TRIM(`Store`) = '' THEN 1 ELSE 0 END) AS Blank_Store,
    SUM(CASE WHEN TRIM(`Sales Channel`) = '' THEN 1 ELSE 0 END) AS Blank_Channel
FROM retail_transactions;

SELECT
    ROUND(SUM(`Sales Amount`), 2) AS Total_Sales,
    ROUND(SUM(`Cogs`), 2) AS Total_COGS,
    ROUND(SUM(`Sales Amount`) - SUM(Cogs), 2) AS Gross_Profit,
    ROUND(
        (SUM(`Sales Amount`) - SUM(Cogs))
        / NULLIF(SUM(`Sales Amount`), 0) * 100,
        2
    ) AS Gross_Profit_Margin
FROM retail_transactions
WHERE `Is Return` = 0;

SELECT
    `Sales Channel`,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(`Sales Amount`), 2) AS Total_Sales,
    ROUND(SUM(`Sales Amount` - `Cogs`), 2) AS Gross_Profit
FROM retail_transactions
WHERE `Is Return` = 0
GROUP BY `Sales Channel`
ORDER BY Total_Sales DESC;

SELECT
    `Sales Channel`,
    `Is Return`,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(`Sales Amount`), 2) AS Total_Sales
FROM retail_transactions
GROUP BY
    `Sales Channel`,
    `Is Return`
ORDER BY
    `Sales Channel`,
    `Is Return`;
    
    SELECT
    `Product Division`,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(`Qty Sold`), 2) AS Total_Quantity,
    ROUND(SUM(`Sales Amount`), 2) AS Total_Sales,
    ROUND(SUM(`Sales Amount` - `Cogs`), 2) AS Gross_Profit
FROM retail_transactions
WHERE `Is Return` = 0
GROUP BY `Product Division`
ORDER BY Total_Sales DESC;

SELECT
    `Product Category`,
    COUNT(*) AS Total_Records,
    ROUND(SUM(`Qty Sold`), 2) AS Total_Quantity,
    ROUND(SUM(`Sales Amount`), 2) AS Total_Sales,
    ROUND(SUM(`Sales Amount` - `Cogs`), 2) AS Gross_Profit
FROM retail_transactions
WHERE `Is Return` = 0
GROUP BY `Product Category`
ORDER BY Total_Sales DESC;

SELECT
    `Store`,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(`Qty Sold`), 2) AS Total_Quantity,
    ROUND(SUM(`Sales Amount`), 2) AS Total_Sales,
    ROUND(SUM(`Sales Amount` - `Cogs`), 2) AS Gross_Profit
FROM retail_transactions
WHERE `Is Return` = 0
GROUP BY `Store`
ORDER BY Total_Sales DESC
LIMIT 10;

DESCRIBE retail_transactions;

SELECT
    `Sales Channel`,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(`Qty Sold`), 0) AS Total_Quantity,
    ROUND(SUM(`Sales Amount`), 2) AS Total_Sales,
    ROUND(SUM(`Sales Amount` - `Cogs`), 2) AS Gross_Profit

FROM retail_transactions

WHERE `Is Return` = 0

GROUP BY `Sales Channel`

ORDER BY Total_Sales DESC;

SELECT
    `Sales Channel`,
    COUNT(*) AS Total_Records
FROM `retail_transactions`
GROUP BY `Sales Channel`
ORDER BY Total_Records DESC;

SELECT
    `Is Return`,
    COUNT(*) AS Total_Records
FROM retail_transactions
GROUP BY `Is Return`
ORDER BY `Is Return`;

SELECT
    `Reason of Return`,
    COUNT(*) AS Total_Returns
FROM retail_transactions
WHERE `Is Return` = 1
GROUP BY `Reason of Return`
ORDER BY Total_Returns DESC;

SELECT
    COUNT(*) AS Total_Returns,

    SUM(
        CASE
            WHEN `Reason of Return` IS NULL
            THEN 1 ELSE 0
        END
    ) AS Null_Reasons,

    SUM(
        CASE
            WHEN TRIM(`Reason of Return`) = ''
            THEN 1 ELSE 0
        END
    ) AS Empty_Reasons

FROM retail_transactions

WHERE `Is Return` = 1;

SELECT
    `Product Category`,
    COUNT(*) AS Total_Returns,
    ROUND(SUM(`Qty Sold`), 0) AS Returned_Quantity

FROM retail_transactions

WHERE `Is Return` = 1

GROUP BY `Product Category`

ORDER BY Total_Returns DESC;

SELECT
    `Product Category`,
    COUNT(*) AS Total_Returns,
    ROUND(SUM(`Qty Sold`), 0) AS Returned_Quantity

FROM retail_transactions

WHERE `Is Return` = 1

GROUP BY `Product Category`

ORDER BY Total_Returns DESC;

SELECT
    `Product Category`,
    COUNT(*) AS Total_Returns,

    ROUND(
        SUM(ABS(`Qty Sold`)), 0
    ) AS Units_Returned,

    ROUND(
        SUM(ABS(`Sales Amount`)), 2
    ) AS Return_Value

FROM retail_transactions

WHERE `Is Return` = 1

GROUP BY `Product Category`

ORDER BY Return_Value DESC;


SELECT
    `Product Category`,

    COUNT(*) AS Total_Transactions,

    SUM(CASE
        WHEN `Is Return` = 1 THEN 1
        ELSE 0
    END) AS Total_Returns,

    ROUND(
        SUM(CASE
            WHEN `Is Return` = 1 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate_Percentage

FROM retail_transactions

GROUP BY `Product Category`

ORDER BY Return_Rate_Percentage DESC;

SELECT
   `Product Category`,

    COUNT(*) AS Total_Returns,

    ROUND(
        SUM(ABS(`Sales Amount`)), 2
    ) AS Total_Return_Value,

    ROUND(
        SUM(ABS(`Cogs`)), 2
    ) AS Total_Return_Cost

FROM retail_transactions

WHERE `Is Return` = 1

GROUP BY `Product Category`

ORDER BY Total_Return_Value DESC

LIMIT 10;

SELECT
    `Product Category`,

    COUNT(*) AS Total_Returns,

    ROUND(
        SUM(ABS(`Sales Amount`)), 2
    ) AS Return_Value,

    ROUND(
        SUM(ABS(`Cogs`)), 2
    ) AS Return_Cost,

    ROUND(
        SUM(ABS(`Sales Amount`))
        - SUM(ABS(`Cogs`)), 2
    ) AS Estimated_Gross_Profit

FROM retail_transactions

WHERE `Is Return` = 1

GROUP BY `Product Category`

ORDER BY Estimated_Gross_Profit DESC

LIMIT 10;


SELECT
    `Supplier`,

    COUNT(*) AS Total_Returns,

    ROUND(
        SUM(ABS(`Qty Sold`)), 0
    ) AS Units_Returned,

    ROUND(
        SUM(ABS(`Sales Amount`)), 2
    ) AS Return_Value

FROM retail_transactions

WHERE `Is Return` = 1

GROUP BY `Supplier`

ORDER BY Total_Returns DESC

LIMIT 10;


SELECT
    `Supplier`,

    COUNT(*) AS Total_Transactions,

    SUM(
        CASE
            WHEN `Is Return` = 1 THEN 1
            ELSE 0
        END
    ) AS Total_Returns,

    ROUND(
        SUM(
            CASE
                WHEN `Is Return` = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate_Percentage

FROM retail_transactions

GROUP BY `Supplier`

ORDER BY Return_Rate_Percentage DESC

LIMIT 10;


SELECT
    `Supplier`,

    COUNT(*) AS Total_Transactions,

    SUM(
        CASE
            WHEN `Is Return` = 1 THEN 1
            ELSE 0
        END
    ) AS Total_Returns,

    ROUND(
        SUM(
            CASE
                WHEN `Is Return` = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate_Percentage

FROM retail_transactions

GROUP BY `Supplier`

HAVING COUNT(*) >= 500

ORDER BY Return_Rate_Percentage DESC

LIMIT 10;

SELECT
    `Supplier`,

    COUNT(*) AS Total_Transactions,

    SUM(
        CASE
            WHEN `Is Return` = 1 THEN 1
            ELSE 0
        END
    ) AS Total_Returns,

    ROUND(
        SUM(
            CASE
                WHEN `Is Return` = 1
                THEN ABS(`Sales Amount`)
                ELSE 0
            END
        ), 2
    ) AS Return_Value

FROM retail_transactions

GROUP BY `Supplier`

HAVING COUNT(*) >= 500

ORDER BY Return_Value DESC

LIMIT 10;


SELECT
    `Supplier`,

    COUNT(*) AS Total_Transactions,

    SUM(
        CASE
            WHEN `Is Return` = 1 THEN 1
            ELSE 0
        END
    ) AS Total_Returns,

    ROUND(
        SUM(
            CASE
                WHEN `Is Return` = 1
                THEN ABS(`Sales Amount`)
                ELSE 0
            END
        ), 2
    ) AS Return_Value

FROM retail_transactions

GROUP BY `Supplier`

HAVING COUNT(*) >= 500

ORDER BY Return_Value DESC

LIMIT 10;

SELECT
    `Transaction Date`,
    COUNT(*) AS Total_Records

FROM retail_transactions

GROUP BY `Transaction Date`

ORDER BY `Transaction Date`

LIMIT 15;

SELECT

    DATE_FORMAT(
        STR_TO_DATE(`Transaction Date`, '%Y/%m/%d'),
        '%Y-%m'
    ) AS Sales_Month,

    COUNT(*) AS Total_Transactions,

    ROUND(
        SUM(`Sales Amount`), 2
    ) AS Monthly_Revenue,

    ROUND(
        SUM(`Sales Amount` - `Cogs`), 2
    ) AS Gross_Profit

FROM retail_transactions

WHERE `Is Return` = 0

GROUP BY Sales_Month

ORDER BY Sales_Month;


SELECT

    DATE_FORMAT(
        STR_TO_DATE(`Transaction Date`, '%Y/%m/%d'),
        '%Y-%m'
    ) AS Sales_Month,

    COUNT(*) AS Total_Transactions,

    ROUND(SUM(`Sales Amount`), 2)
        AS Monthly_Revenue,

    ROUND(
        SUM(`Sales Amount` - `Cogs`), 2
    ) AS Gross_Profit

FROM retail_transactions

WHERE `Is Return` = 0

GROUP BY Sales_Month

ORDER BY Monthly_Revenue DESC

LIMIT 5;

WITH Monthly_Sales AS (

    SELECT
        DATE_FORMAT(
            STR_TO_DATE(`Transaction Date`, '%Y/%m/%d'),
            '%Y-%m'
        ) AS Sales_Month,

        SUM(`Sales Amount`) AS Monthly_Revenue

    FROM retail_transactions

    WHERE `Is Return` = 0

    GROUP BY Sales_Month

),

Revenue_Comparison AS (

    SELECT
        Sales_Month,
        Monthly_Revenue,

        LAG(Monthly_Revenue) OVER (
            ORDER BY Sales_Month
        ) AS Previous_Month_Revenue

    FROM Monthly_Sales

)

SELECT
    Sales_Month,

    ROUND(Monthly_Revenue, 2) AS Monthly_Revenue,

    ROUND(Previous_Month_Revenue, 2)
        AS Previous_Month_Revenue,

    ROUND(
        (Monthly_Revenue - Previous_Month_Revenue)
        / NULLIF(Previous_Month_Revenue, 0) * 100,
        2
    ) AS Growth_Percentage

FROM Revenue_Comparison

ORDER BY Sales_Month;

 SELECT

    `Product No`,
    `Product Description`,

    ROUND(
        SUM(`Sales Amount`), 2
    ) AS Total_Revenue,

    ROUND(
        SUM(`Sales Amount` - `Cogs`), 2
    ) AS Gross_Profit,

    ROUND(
        (
            SUM(`Sales Amount` - `Cogs`)
            / NULLIF(SUM(`Sales Amount`), 0)
        ) * 100,
        2
    ) AS Profit_Margin_Percentage

FROM retail_transactions

WHERE `Is Return` = 0

GROUP BY
    `Product No`,
    `Product Description`

HAVING SUM(`Sales Amount`) > 0

ORDER BY Profit_Margin_Percentage DESC

LIMIT 10;

SELECT

    `Product No`,
    `Product Description`,

    ROUND(
        SUM(`Sales Amount`), 2
    ) AS Total_Revenue,

    ROUND(
        SUM(`Sales Amount` - `Cogs`), 2
    ) AS Gross_Profit,

    ROUND(
        SUM(`Sales Amount` - `Cogs`)
        / NULLIF(SUM(`Sales Amount`), 0) * 100,
        2
    ) AS Profit_Margin_Percentage

FROM retail_transactions

WHERE `Is Return` = 0

GROUP BY
    `Product No`,
    `Product Description`

HAVING SUM(`Sales Amount`) >= 5000

ORDER BY Profit_Margin_Percentage DESC

LIMIT 10;

WITH Product_Performance AS (

    SELECT
        `Product No`,
        `Product Description`,

        ROUND(SUM(`Sales Amount`), 2)
            AS Total_Revenue,

        ROUND(
            SUM(`Sales Amount` - `Cogs`), 2
        ) AS Gross_Profit

    FROM retail_transactions

    WHERE `Is Return` = 0

    GROUP BY
        `Product No`,
        `Product Description`

)

SELECT
    `Product No`,
    `Product Description`,
    Total_Revenue,
    Gross_Profit,

    RANK() OVER (
        ORDER BY Total_Revenue DESC
    ) AS Revenue_Rank

FROM Product_Performance

LIMIT 10;

WITH Product_Performance AS (

    SELECT
        `Product No`,
        `Product Description`,

        SUM(`Sales Amount`) AS Total_Revenue

    FROM retail_transactions

    WHERE `Is Return` = 0

    GROUP BY
        `Product No`,
        `Product Description`

)

SELECT
    `Product No`,
    `Product Description`,

    ROUND(Total_Revenue, 2) AS Total_Revenue,

    ROUND(
        Total_Revenue /
        NULLIF(SUM(Total_Revenue) OVER(), 0) * 100,
        2
    ) AS Revenue_Contribution_Percentage

FROM Product_Performance

ORDER BY Total_Revenue DESC

LIMIT 10;


WITH Product_Sales AS (

    SELECT
        `Product Division`,
        `Product No`,
        `Product Description`,

        ROUND(SUM(`Sales Amount`), 2)
            AS Total_Revenue

    FROM retail_transactions

    WHERE `Is Return` = 0

    GROUP BY
        `Product Division`,
        `Product No`,
        `Product Description`

),

Ranked_Products AS (

    SELECT
        *,

        ROW_NUMBER() OVER (
            PARTITION BY `Product Division`
            ORDER BY Total_Revenue DESC
        ) AS Division_Rank

    FROM Product_Sales

)

SELECT *

FROM Ranked_Products

WHERE Division_Rank <= 3

ORDER BY
    `Product Division`,
    Division_Rank;
    
WITH Monthly_Sales AS (

    SELECT
        DATE_FORMAT(
            STR_TO_DATE(`Transaction Date`, '%Y/%m/%d'),
            '%Y-%m'
        ) AS Sales_Month,

        SUM(`Sales Amount`) AS Monthly_Revenue

    FROM retail_transactions

    WHERE `Is Return` = 0

    GROUP BY Sales_Month

)

SELECT
    Sales_Month,

    ROUND(Monthly_Revenue, 2) AS Monthly_Revenue,

    ROUND(
        SUM(Monthly_Revenue) OVER (
            ORDER BY Sales_Month
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ), 2
    ) AS Cumulative_Revenue

FROM Monthly_Sales

ORDER BY Sales_Month;

SELECT

    COUNT(*) AS Total_Records,

    SUM(
        CASE WHEN `Is Return` = 0
        THEN 1 ELSE 0 END
    ) AS Successful_Transactions,

    SUM(
        CASE WHEN `Is Return` = 1
        THEN 1 ELSE 0 END
    ) AS Returned_Transactions,

    ROUND(
        SUM(
            CASE WHEN `Is Return` = 0
            THEN `Sales Amount` ELSE 0 END
        ), 2
    ) AS Total_Revenue,

    ROUND(
        SUM(
            CASE WHEN `Is Return` = 0
            THEN `Sales Amount` - `Cogs`
            ELSE 0 END
        ), 2
    ) AS Total_Gross_Profit,

    ROUND(
        SUM(
            CASE WHEN `Is Return` = 1
            THEN 1 ELSE 0 END
        ) * 100.0 / COUNT(*),
        2
    ) AS Return_Rate_Percentage

FROM retail_transactions;


SELECT

    COUNT(*) AS Total_Transactions,

    ROUND(
        SUM(`Sales Amount`), 2
    ) AS Total_Revenue,

    ROUND(
        SUM(`Sales Amount`) / COUNT(*), 2
    ) AS Average_Transaction_Value

FROM retail_transactions

WHERE `Is Return` = 0;

SELECT

    COUNT(*) AS Total_Records,

    SUM(`Number of Transactions`)
        AS Actual_Transactions,

    ROUND(
        SUM(`Sales Amount`), 2
    ) AS Total_Revenue,

    ROUND(
        SUM(`Sales Amount`)
        / NULLIF(SUM(`Number of Transactions`), 0),
        2
    ) AS Average_Transaction_Value
    


FROM retail_transactions

WHERE `Is Return` = 0;

SELECT

    `Sales Channel`,

    COUNT(*) AS Total_Records,

    SUM(`Number of Transactions`)
        AS Actual_Transactions,

    ROUND(
        SUM(`Sales Amount`), 2
    ) AS Total_Revenue,

    ROUND(
        SUM(`Sales Amount` - `Cogs`), 2
    ) AS Gross_Profit

FROM retail_transactions

WHERE `Is Return` = 0

GROUP BY `Sales Channel`

ORDER BY Total_Revenue DESC;

SELECT

    `Sales Channel`,

    COUNT(*) AS Total_Records,

    SUM(
        CASE
            WHEN `Is Return` = 0 THEN 1
            ELSE 0
        END
    ) AS Successful_Records,





    SUM(
        CASE
            WHEN `Is Return` = 1 THEN 1
            ELSE 0
        END
    ) AS Returned_Records

FROM retail_transactions

GROUP BY `Sales Channel`

ORDER BY Total_Records DESC;

SELECT

    `Product Category`,

    COUNT(*) AS Total_Records,

    ROUND(
        SUM(`Sales Amount`), 2
    ) AS Total_Revenue,

    ROUND(
        SUM(`Sales Amount` - `Cogs`), 2
    ) AS Gross_Profit,

    ROUND(
        SUM(`Sales Amount` - `Cogs`)
        / NULLIF(SUM(`Sales Amount`), 0) * 100,
        2
    ) AS Profit_Margin_Percentage

FROM retail_transactions

WHERE `Is Return` = 0

GROUP BY `Product Category`

ORDER BY Total_Revenue DESC

LIMIT 10;


WITH Category_Sales AS (

    SELECT
        `Product Category`,

        SUM(`Sales Amount`) AS Total_Revenue

    FROM retail_transactions

    WHERE `Is Return` = 0

    GROUP BY `Product Category`

)

SELECT

    `Product Category`,

    ROUND(Total_Revenue, 2) AS Total_Revenue,

    ROUND(
        Total_Revenue /
        NULLIF(SUM(Total_Revenue) OVER(), 0) * 100,
        2
    ) AS Revenue_Contribution_Percentage

FROM Category_Sales

ORDER BY Total_Revenue DESC;

WITH Category_Sales AS (

    SELECT
        `Product Category`,
        SUM(`Sales Amount`) AS Total_Revenue

    FROM retail_transactions

    WHERE `Is Return` = 0

    GROUP BY `Product Category`

)

SELECT

    COUNT(*) AS Total_Categories,

    ROUND(
        SUM(Total_Revenue), 2
    ) AS Combined_Category_Revenue,

    ROUND(
        SUM(Total_Revenue) /
        (
            SELECT SUM(`Sales Amount`)
            FROM retail_transactions
            WHERE `Is Return` = 0
        ) * 100,
        2
    ) AS Contribution_Percentage

FROM Category_Sales;




    
    







    
    
   

   