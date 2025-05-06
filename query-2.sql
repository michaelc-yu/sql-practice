

-- 26. Filtering: list all products whose name ends with the letter 's' and whose name is more than 5 characters long
SELECT * FROM product
WHERE name LIKE '%s'
AND LENGTH(name) > 5;

-- 27. Filtering: list all products where the second letter of the product name is 'i'
SELECT * FROM product
WHERE SUBSTR(name, 2, 1) = 'i';

-- 28. List all products whose names consist of exactly two words (aka exactly one space in name)
SELECT * FROM product
WHERE LENGTH(name) - LENGTH(REPLACE(name, ' ', '')) = 1;

-- 29. Find all categories that have multiple products with the same name
SELECT category_id, name, COUNT(*) FROM product
GROUP BY category_id, name
HAVING COUNT(*) > 1;

-- 30. For each product, show the product name, its category name, and a label based on how many characters the name has
SELECT
  p.name AS product_name,
  pc.name AS category_name,
  CASE
    WHEN LENGTH(p.name) <= 5 THEN 'Short'
    WHEN LENGTH(p.name) <= 10 THEN 'Medium'
    ELSE 'Long'
  END AS name_length_category
FROM product p
JOIN product_category pc
  ON p.category_id = pc.id

