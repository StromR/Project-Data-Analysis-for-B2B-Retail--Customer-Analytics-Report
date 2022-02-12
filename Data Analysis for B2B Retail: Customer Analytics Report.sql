-- Check the Tables

SELECT * FROM orders_1 LIMIT 5;

/* Output
+-------------+------------+--------------+-------------+---------+------------+-------------+----------+-----------+
| orderNumber | orderDate  | requiredDate | shippedDate | status  | customerID | productCode | quantity | priceeach |
+-------------+------------+--------------+-------------+---------+------------+-------------+----------+-----------+
|       10234 | 2004-03-30 | 2004-04-05   | 2004-04-02  | Shipped |        412 | S72_1253    |       40 |     45690 |
|       10234 | 2004-03-30 | 2004-04-05   | 2004-04-02  | Shipped |        412 | S700_2047   |       29 |     83280 |
|       10234 | 2004-03-30 | 2004-04-05   | 2004-04-02  | Shipped |        412 | S24_3816    |       31 |     78830 |
|       10234 | 2004-03-30 | 2004-04-05   | 2004-04-02  | Shipped |        412 | S24_3420    |       25 |     65090 |
|       10234 | 2004-03-30 | 2004-04-05   | 2004-04-02  | Shipped |        412 | S24_2841    |       44 |     67140 |
+-------------+------------+--------------+-------------+---------+------------+-------------+----------+-----------+
*/

SELECT * FROM orders_2 LIMIT 5;
/* Output
+-------------+------------+--------------+-------------+---------+------------+-------------+----------+-----------+
| orderNumber | orderDate  | requiredDate | shippedDate | status  | customerID | productCode | quantity | priceeach |
+-------------+------------+--------------+-------------+---------+------------+-------------+----------+-----------+
|       10235 | 2004-04-02 | 2004-04-12   | 2004-04-06  | Shipped |        260 | S18_2581    |       24 |     81950 |
|       10235 | 2004-04-02 | 2004-04-12   | 2004-04-06  | Shipped |        260 | S24_1785    |       23 |     89720 |
|       10235 | 2004-04-02 | 2004-04-12   | 2004-04-06  | Shipped |        260 | S24_3949    |       33 |     55270 |
|       10235 | 2004-04-02 | 2004-04-12   | 2004-04-06  | Shipped |        260 | S24_4278    |       40 |     63030 |
|       10235 | 2004-04-02 | 2004-04-12   | 2004-04-06  | Shipped |        260 | S32_1374    |       41 |     90900 |
+-------------+------------+--------------+-------------+---------+------------+-------------+----------+-----------+
*/

SELECT * FROM customer LIMIT 5;
/* Output
+------------+----------------------------+-----------------+------------------+-----------+-----------+------------+
| customerID | customerName               | contactLastName | contactFirstName | city      | country   | createDate |
+------------+----------------------------+-----------------+------------------+-----------+-----------+------------+
|        103 | Atelier graphique          | Schmitt         | Carine           | Nantes    | France    | 2004-02-05 |
|        112 | Signal Gift Stores         | King            | Jean             | Las Vegas | USA       | 2004-02-05 |
|        114 | Australian Collectors, Co. | Ferguson        | Peter            | Melbourne | Australia | 2004-02-20 |
|        119 | La Rochelle Gifts          | Labrune         | Janine           | Nantes    | France    | 2004-02-05 |
|        121 | Baane Mini Imports         | Bergulfsen      | Jonas            | Stavern   | Norway    | 2004-02-05 |
+------------+----------------------------+-----------------+------------------+-----------+-----------+------------+
*/


-- Total Penjualan (sales) and Revenue From Q1 and Q2

SELECT 
	SUM(quantity) AS total_penjualan,
	SUM(quantity * priceEach) AS revenue
FROM orders_1
WHERE status = 'Shipped';
/* Output
+-----------------+-----------+
| total_penjualan | revenue   |
+-----------------+-----------+
|            8694 | 799579310 |
+-----------------+-----------+
*/

SELECT
	SUM(quantity) AS total_penjualan,
	SUM(quantity * priceEach) AS revenue
FROM orders_2
WHERE status = 'Shipped';
/* Output
+-----------------+-----------+
| total_penjualan | revenue   |
+-----------------+-----------+
|            6717 | 607548320 |
+-----------------+-----------+
*/


-- Calculate the percentage of all sales from Q1 and Q2
SELECT
	quarter,
	SUM(quantity) AS total_penjualan,
	SUM(quantity * priceEach) AS revenue
FROM 
(SELECT 1 AS quarter, orderNumber, status, quantity, priceEach FROM orders_1 
 UNION
SELECT 2 AS quarter, orderNumber, status, quantity, priceEach FROM orders_2)
AS table_1 WHERE status = 'Shipped'
GROUP BY quarter;

/* Output
+---------+-----------------+-----------+
| quarter | total_penjualan | revenue   |
+---------+-----------------+-----------+
|       1 |            8694 | 799579310 |
|       2 |            6717 | 607548320 |
+---------+-----------------+-----------+
*/



-- Does the total customer of xyz.com growing?
SELECT
	QUARTER(createDate) AS quarter,
	COUNT(DISTINCT(customerID)) AS total_customers
FROM
(SELECT
	customerID,
	createDate,
	QUARTER(createDate) AS quarter
FROM customer 
WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30') AS table_b
GROUP BY QUARTER(createDate);

/*
+---------+-----------------+
| quarter | total_customers |
+---------+-----------------+
|       1 |              43 |
|       2 |              35 |
+---------+-----------------+
*/



-- How many customers made transaction?
SELECT
	quarter,
	COUNT(DISTINCT(customerID)) AS total_customers
FROM
(SELECT
	customerID,
	createDate,
	QUARTER(createDate) AS quarter
FROM customer
WHERE createDate BETWEEN '2004-01-01' AND '2004-06-30') AS tabel_b
WHERE customerID IN(
SELECT
	DISTINCT(customerID)
FROM orders_1 
UNION
SELECT 
	DISTINCT(customerID)
FROM orders_2) 
GROUP BY quarter;
 
/* Output
+---------+-----------------+
| quarter | total_customers |
+---------+-----------------+
|       1 |              25 |
|       2 |              19 |
+---------+-----------------+
*/



-- The most popular product category in Q2
SELECT 
	*
FROM
	(SELECT
		categoryID,
		COUNT(DISTINCT(orderNumber)) AS total_order,
		SUM(quantity) AS total_penjualan
	FROM
		(SELECT
			productCode, 
			orderNumber,
			quantity,
			status,
			LEFT(productCode,3) AS categoryID
		FROM orders_2
		WHERE status = 'Shipped') AS tabel_c
	GROUP BY categoryID) AS A
ORDER BY total_order DESC;

/* Output
+------------+-------------+-----------------+
| categoryID | total_order | total_penjualan |
+------------+-------------+-----------------+
| S18        |          25 |            2264 |
| S24        |          21 |            1826 |
| S32        |          11 |             616 |
| S12        |          10 |             491 |
| S50        |           8 |             292 |
| S10        |           8 |             492 |
| S70        |           7 |             675 |
| S72        |           2 |              61 |
+------------+-------------+-----------------+
*/



-- How many customers remain active after the first transaction? (in percentage)
SELECT
	'1' AS quarter,
	COUNT(DISTINCT(customerID)) * 100/25 AS Q2
FROM orders_1
WHERE customerID IN(
		SELECT
			DISTINCT(customerID)
		FROM orders_2);

/* Output
+---------+---------+
| quarter | Q2      |
+---------+---------+
| 1       | 24.0000 |
+---------+---------+
*/
