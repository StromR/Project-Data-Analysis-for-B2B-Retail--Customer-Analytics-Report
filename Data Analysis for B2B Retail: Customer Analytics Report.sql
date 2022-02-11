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

