

-- 1. SELECT all columns from product_category
SELECT * FROM product_category;

-- 2. SELECT only name from product
SELECT name FROM product;

-- 3. SELECT all products in category_id 1
SELECT * FROM product WHERE category_id = 1;

-- 4. ORDER products by name alphabetically
SELECT * FROM product ORDER BY name;

-- 5. COUNT total number of products
SELECT COUNT(*) FROM product;

-- 6. COUNT of products per category_id
SELECT category_id, COUNT(*) FROM product GROUP BY category_id;

-- 7. Get the product with the highest id
SELECT name, id FROM product ORDER BY id DESC LIMIT 1;

-- 8. Products where name contains 'Apple'
SELECT * FROM product WHERE name LIKE '%Apple%';

-- 9. Products where name starts with 'P'
SELECT * FROM product WHERE name LIKE 'P%';

-- 10. Case-insensitive match for name containing 'apple'
SELECT * FROM product WHERE LOWER(name) LIKE '%apple%';

-- 11. Categories with more than 1 product
SELECT category_id, COUNT(*) FROM product
GROUP BY category_id
HAVING COUNT(*) > 1;

-- 12. Products in category 1 but not named 'Milk'
SELECT * FROM product
WHERE category_id = 1 AND name NOT LIKE '%Milk%';

-- 13. Products with category_id 1 or 2 using IN
SELECT * FROM product WHERE category_id IN (1, 2);

-- 14. Products with id between 1 and 2 (inclusive)
SELECT * FROM product WHERE id BETWEEN 1 AND 2;

-- 15. Subquery: Products in the 'Food' category
SELECT * FROM product
WHERE category_id = (
  SELECT id FROM product_category WHERE name = 'Food'
);

-- 16. Subquery with IN: Products in categories whose name contains 'o'
SELECT * FROM product
WHERE category_id IN (
  SELECT id FROM product_category
  WHERE LOWER(name) LIKE '%o%'
);

-- 17. Subquery inside SELECT: product count per category
SELECT
  name,
  (SELECT COUNT(*) FROM product WHERE category_id = pc.id) AS product_count
FROM product_category pc;

-- 18. INNER JOIN: Show each product with its category name
SELECT
  p.name AS product_name,
  pc.name AS category_name
FROM product p
JOIN product_category pc
  ON p.category_id = pc.id;

-- 19. INNER JOIN + WHERE: Only products in the 'Food' category
SELECT
  p.name AS product_name,
  pc.name AS category_name
FROM product p
JOIN product_category pc
  ON p.category_id = pc.id
WHERE pc.name = 'Food';

-- 20. LEFT JOIN: Show all categories, even if they have no products
SELECT
  pc.name AS category_name,
  p.name AS product_name
FROM product_category pc
LEFT JOIN product p
  ON pc.id = p.category_id;

-- 21. Subquery in JOIN: filtering categories whose names contain 'o'
SELECT *
FROM product p
JOIN (
  SELECT * FROM product_category
  WHERE LOWER(name) LIKE '%o%'
) pc_filtered
ON p.category_id = pc_filtered.id;

-- 22. Subquery with Aggregation + JOIN: return the name of the top category along with the product count
SELECT
  pc.name AS category_name,
  most_popular.product_count
FROM (
  SELECT category_id, COUNT(*) AS product_count
  FROM product
  GROUP BY category_id
  ORDER BY COUNT(*) DESC
  LIMIT 1
) most_popular
JOIN product_category pc
  ON most_popular.category_id = pc.id;

-- 23. Filtered JOIN via Subquery: show all product and category names only for categories that have more than one product
SELECT
  p.name AS product_name,
  pc.name AS category_name
FROM product p
JOIN product_category pc
  ON p.category_id = pc.id
WHERE pc.id IN 
(SELECT category_id
FROM product
GROUP BY category_id
HAVING COUNT(*) > 1);

-- 24. JOIN + Subquery inside SELECT: list each product name along with its category name and the totla number of products in that category
SELECT
  p.name AS product_name,
  pc.name AS category_name,
  (SELECT COUNT(*) FROM product WHERE category_id = p.category_id) AS num_products_in_category
FROM product p
JOIN product_category pc
  ON p.category_id = pc.id;




