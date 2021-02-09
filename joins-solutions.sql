-- 1. Get all customers and their addresses
SELECT "id", "first_name", "last_name", "street", "city", "state", "zip", "address_type"
FROM "customers" AS c
JOIN "addresses" AS a
ON c."id" = a."customer_id";

-- 2. Get all orders and their line items
SELECT * FROM "orders" AS o
JOIN "line_items" AS li ON o."id" = li."order_id";

-- 3. Which warehouses have cheetos
SELECT * FROM "warehouse" AS w
JOIN "warehouse_product" AS wp ON w."id" = wp."warehouse_id"
JOIN "products" AS p ON p."id" = wp."product_id"
WHERE p."id" = 5;

-- 4. Which warehouses have diet pepsi?
SELECT * FROM "warehouse" AS w
JOIN "warehouse_product" AS wp ON w."id" = wp."warehouse_id"
JOIN "products" AS p ON p."id" = wp."product_id"
WHERE p."id" = 6;

-- 5. Get the number of orders for each customer
SELECT c."id", c."first_name", c."last_name", count(c."id") FROM "customers" AS c
JOIN "addresses" AS a ON c."id" = a."customer_id"
JOIN "orders" AS o ON a."id" = o."address_id"
GROUP BY c."id" ORDER BY c."id";

-- 6. How many customers do we have
SELECT COUNT(*) FROM "customers";

-- 7. How many products do we have
SELECT COUNT(*) FROM "products";

-- 8. What is the total available on-hand quantity of diet pepsi?
SELECT SUM(wp."on_hand") FROM "warehouse" AS w
JOIN "warehouse_product" AS wp ON w."id" = wp."warehouse_id"
JOIN "products" AS p ON p."id" = wp."product_id"
WHERE p."id" = 6;

-- 9. How much was the total cost for each order
SELECT o."id", SUM(li."quantity" * p."unit_price") FROM "orders" as o
JOIN "line_items" as li on o."id" = li."order_id"
JOIN "products" as p on p."id" = li."product_id"
GROUP BY o."id" ORDER BY o."id"

-- 10. How much has each customer spent in total
SELECT c."id", SUM(li."quantity" * p."unit_price") FROM "customers" as c
JOIN "addresses" as a on c."id" = a."customer_id"
JOIN "orders" as o on a."id" = o."address_id"
JOIN "line_items" as li on o."id" = li."order_id"
JOIN "products" as p on p."id" = li."product_id"
GROUP BY c."id" ORDER BY c."id";
