# PostgreSQL Guide in Bengali

## 1. What is PostgreSQL?

**PostgreSQL** একটি অত্যন্ত পাওয়ারফুল এবং ওপেনসোর্স অবজেক্ট রিলেশনাল ডাটাবেজ ম্যানেজমেন্ট সিস্টেম। ওপেনসোর্স হওয়ার কারণে এর সোর্স কোড উন্মুক্ত এবং সহজেই নিজের চাহিদা অনুযায়ী এই ডেটাবেজ কে পরিবর্তন করা সম্ভব। এটি ACID কমপ্লায়েন্ট, এবং এটির উন্নত ফিচার যেমন JSON সাপোর্ট, জিওগ্রাফিক ডাটা হ্যান্ডলিং (PostGIS), কাস্টম ডাটা টাইপ, এবং এক্সটেনসিবিলিটি এর জন্য এটি অন্যান্য RDBMS থেকে এগিয়ে।

এছাড়াও, এটি মাল্টি-ভার্সন কনকারেন্সি কন্ট্রোল (MVCC) এবং পারফরম্যান্স অপ্টিমাইজেশনের জন্য বিখ্যাত।

---

## 2. What is the purpose of a database schema in PostgreSQL?

**PostgreSQL-এ ডাটাবেস স্কিমা**-এর মূল উদ্দেশ্য হল ডাটাবেস অবজেক্টগুলো (যেমন টেবিল, ভিউ, ফাংশন, ইন্ডেক্স) কে লজিক্যাল গ্রুপে সংগঠিত করা। এটি নিম্নলিখিত কাজে সাহায্য করে:

- **সংগঠন (Organization)** – একাধিক ইউজার বা অ্যাপ্লিকেশন একই ডাটাবেসে কাজ করার সময় তাদের অবজেক্টগুলো আলাদা রাখতে স্কিমা ব্যবহার করা হয়।
- **অ্যাক্সেস কন্ট্রোল (Access Control)** – স্কিমা লেভেলে পারমিশন সেট করে ডাটা সিকিউরিটি ম্যানেজ করা যায়।
- **নেমস্পেস ম্যানেজমেন্ট (Namespace Management)** – একই নামের টেবিল বা অবজেক্ট ভিন্ন স্কিমায় রাখা সম্ভব, যা নামের কনফ্লিক্ট রোধ করে।
- **মাল্টি-টেন্যান্সি (Multi-tenancy)** – একটি ডাটাবেসে একাধিক স্কিমা ব্যবহার করে আলাদা টেন্যান্টের ডাটা ম্যানেজ করা যায়।

**উদাহরণস্বরূপ**, `public` হল ডিফল্ট স্কিমা, কিন্তু আমরা `sales`, `hr` ইত্যাদি আলাদা স্কিমা তৈরি করে ডাটাকে ক্যাটাগরাইজ করতে পারি।

### বিশেষ সুবিধা:
PostgreSQL-এ স্কিমা ব্যবহার করে আমরা ডাটাবেস ডিজাইনে বেশি **ফ্লেক্সিবিলিটি** এবং **সিকিউরিটি** পাই, যা অনেক RDBMS-এ এতটা সুবিধাজনক নয়।

---

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.

# 📘 PostgreSQL: Primary Key ও Foreign Key

## 🔑 Primary Key (প্রাইমারি কী)

**সংজ্ঞা:**  
একটি টেবিলের প্রতিটি row-কে ইউনিকলি আইডেন্টিফাই করার জন্য Primary Key ব্যবহার করা হয়।

**বৈশিষ্ট্য:**

- এটি **ইউনিক (Unique)** এবং **নাল (NULL)** হতে পারে না।
- একটি টেবিলে একটি মাত্র **Primary Key** থাকতে পারে (কিন্তু একাধিক কলাম মিলে **Composite Primary Key** হতে পারে)。
- এটি **অটোমেটিকালি ইনডেক্সড** হয়, যা ডাটা রিট্রিভালকে দ্রুততর করে।

**উদাহরণ:**

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE
);
```

এখানে `student_id` হলো Primary Key, যা প্রতিটি স্টুডেন্টকে আলাদাভাবে চিহ্নিত করে।


## 🔗 Foreign Key (ফরেন কী)

**সংজ্ঞা:**  
এটি একটি টেবিলের কলাম (বা কলামের গ্রুপ) যা অন্য টেবিলের Primary Key-কে রেফার করে। এটি রিলেশনাল ডাটাবেসে টেবিলগুলোর মধ্যে **সম্পর্ক (Relationship)** স্থাপন করে।

**বৈশিষ্ট্য:**

- এটি **ডাটা ইন্টিগ্রিটি (Data Integrity)** বজায় রাখে, অর্থাৎ অবৈধ ডাটা ইনসার্ট হতে দেয় না।
- এটি **CASCADE UPDATE/DELETE** সাপোর্ট করে, মানে Primary Key-তে পরিবর্তন হলে Foreign Key-তেও অটোমেটিকালি পরিবর্তন হয়।

**উদাহরণ:**

```sql
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    student_id INT REFERENCES students(student_id)
);
```

এখানে `student_id` হলো Foreign Key, যা `students` টেবিলের `student_id`-কে রেফার করে।


✅ **সারসংক্ষেপ:**  
Primary Key ও Foreign Key ব্যবহার করে আমরা PostgreSQL-এ ডাটাবেজের ভেতরে ইউনিকনেস নিশ্চিত করি এবং টেবিলগুলোর মধ্যে সম্পর্ক স্থাপন করি, যা ডেটার গঠন ও সুরক্ষা নিশ্চিত করে।

---


## 4. What is the difference between the VARCHAR and CHAR data types?

**VARCHAR এবং CHAR ডাটা টাইপের পার্থক্য**  
- `CHAR` ফিক্সড-লেংথ টেক্সট স্টোর করে, যখন `VARCHAR` ভ্যারিয়েবল-লেংথ টেক্সট স্টোর করে।  
- `CHAR` সবসময় ডিফাইন করা সাইজ নেয়, `VARCHAR` শুধু প্রয়োজনীয় সাইজ নেয়।

### উদাহরণ:
```sql
CREATE TABLE example (
    fixed_code CHAR(5),        -- সবসময় ৫ ক্যারেক্টার (Hi → 'Hi   ')
    variable_desc VARCHAR(100) -- শুধু প্রয়োজনীয় ক্যারেক্টার নেয় (Hello → 'Hello')
);
```

### PostgreSQL-এ বিশেষ বিবেচনা:
- `CHAR(n)` → ছোট টেক্সট দিলে স্পেস দিয়ে পূরণ করা হয়  
- `VARCHAR(n)` → n হলো সর্বোচ্চ সীমা, শুধু প্রয়োজনীয় জায়গা নেয়  
- সাধারণত `VARCHAR` বা `TEXT` বেশি ব্যবহার করা হয়

### সিদ্ধান্ত নেওয়ার টিপস:
- ফিক্সড-লেংথ → `CHAR`  
- অন্যান্য ক্ষেত্রে → `VARCHAR` বা `TEXT`

---

## 5. What is the purpose of the WHERE clause in a SELECT statement?

**WHERE ক্লজ** ডাটাবেস কোয়েরিতে শর্ত যোগ করে যাতে শুধুমাত্র নির্দিষ্ট রেকর্ড ফেরত আসে।

### মূল কাজ:
- ডাটা ফিল্টারিং
- প্রয়োজনীয় রেকর্ড নির্বাচন
- শর্ত অনুযায়ী রো রিটার্ন

### উদাহরণ:
```sql
SELECT * FROM employees 
WHERE salary > 50000;
```

### বিশেষ বৈশিষ্ট্য:
- `AND`, `OR` দিয়ে একাধিক শর্ত
- তুলনা অপারেটর (>, <, =, !=)
- প্যাটার্ন ম্যাচিং (`LIKE`)
- `NULL` চেক (`IS NULL` / `IS NOT NULL`)

---

## 6. What are the LIMIT and OFFSET clauses used for?

### ✅ LIMIT
- রেকর্ড সংখ্যা সীমিত করে
- পেজিনেশনে কার্যকরী

```sql
SELECT * FROM products 
LIMIT 10;
```

### ✅ OFFSET
- নির্দিষ্ট সংখ্যক রো স্কিপ করে

```sql
SELECT * FROM products 
LIMIT 10 OFFSET 20;
```

### পেজিনেশন উদাহরণ:
```sql
-- পেজ ১: ১-১০ রেকর্ড
SELECT * FROM products LIMIT 10 OFFSET 0;

-- পেজ ২: ১১-২০ রেকর্ড
SELECT * FROM products LIMIT 10 OFFSET 10;
```

---

## 7. How can you modify data using UPDATE statements?

**UPDATE** ব্যবহার করে বিদ্যমান ডেটা পরিবর্তন করা হয়।

### বৈশিষ্ট্য:
- একাধিক কলাম একসাথে আপডেট
- `WHERE` দিয়ে নির্দিষ্ট রো নির্বাচন
- সাবকোয়েরি ও JOIN সাপোর্ট

### উদাহরণ:
```sql
UPDATE employees
SET salary = 60000
WHERE employee_id = 101;

UPDATE products
SET price = 1200, stock = stock - 1
WHERE product_id = 5;

UPDATE customers
SET membership_status = 'Premium'
WHERE total_purchases > 100000;
```

### সতর্কতা:
- `WHERE` না দিলে সব রো আপডেট হবে

---

## 8. What is the significance of the JOIN operation, and how does it work in PostgreSQL?

**JOIN** একাধিক টেবিল যুক্ত করে ডেটা বিশ্লেষণে সহায়তা করে।

### JOIN ধরন ও উদাহরণ:

#### ✅ INNER JOIN
```sql
SELECT orders.order_id, customers.name
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;
```

#### ✅ LEFT JOIN
```sql
SELECT students.name, departments.dept_name
FROM students
LEFT JOIN departments ON students.dept_id = departments.id;
```

#### ✅ RIGHT JOIN
```sql
SELECT products.name, categories.category_name
FROM products
RIGHT JOIN categories ON products.category_id = categories.id;
```

#### ✅ FULL JOIN
```sql
SELECT employees.name, projects.project_name
FROM employees
FULL JOIN projects ON employees.project_id = projects.id;
```

#### ✅ Multiple JOIN
```sql
SELECT o.order_id, c.name, p.product_name
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
WHERE o.order_date > '2023-01-01';
```

### PostgreSQL JOIN Execution Methods:
- Nested Loop Join
- Hash Join
- Merge Join

---

## 9. Explain the GROUP BY clause and its role in aggregation operations.

**GROUP BY** ডেটা গ্রুপ করে প্রতিটি গ্রুপে সারসংক্ষেপ তৈরি করে।

### অ্যাগ্রিগেশন ফাংশন:
| ফাংশন | কাজ              |
|--------|-------------------|
| COUNT() | রেকর্ড সংখ্যা    |
| SUM()   | মানের যোগফল     |
| AVG()   | গড় মান           |
| MAX()   | সর্বোচ্চ মান     |
| MIN()   | সর্বনিম্ন মান     |

### উদাহরণ:
```sql
SELECT department, COUNT(*) as employee_count, AVG(salary) as avg_salary
FROM employees
GROUP BY department;
```

### HAVING vs WHERE:
- `WHERE` → গ্রুপিং এর আগে ফিল্টার
- `HAVING` → গ্রুপিং এর পরে ফিল্টার

```sql
SELECT department, AVG(salary)
FROM employees
WHERE join_date > '2020-01-01'
GROUP BY department
HAVING AVG(salary) > 50000;
```

### উন্নত গ্রুপিং:
```sql
SELECT product_category, region, SUM(sales) as total_sales
FROM sales_data
GROUP BY GROUPING SETS (
    (product_category, region),
    (product_category),
    (region),
    ()
);
```

---

## 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?

### ✅ COUNT()
```sql
SELECT COUNT(*) FROM employees;
SELECT COUNT(*) FROM orders WHERE status = 'Delivered';
SELECT COUNT(DISTINCT department) FROM employees;
```

### ✅ SUM()
```sql
SELECT SUM(salary) FROM employees;
SELECT SUM(amount) FROM transactions WHERE transaction_date > '2023-01-01';
SELECT SUM(quantity), SUM(price) FROM order_items;
```

### ✅ AVG()
```sql
SELECT AVG(rating) FROM product_reviews;
SELECT department, AVG(salary) FROM employees GROUP BY department;
SELECT ROUND(AVG(price), 2) FROM products;
```

### ✅ একসাথে ব্যবহার:
```sql
SELECT 
    COUNT(*) as total_orders,
    SUM(amount) as total_revenue,
    AVG(amount) as average_order_value
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31';
```

### ✅ FILTER clause:
```sql
SELECT 
    COUNT(*) FILTER (WHERE status = 'Completed') as completed_orders,
    COUNT(*) FILTER (WHERE status = 'Pending') as pending_orders
FROM orders;
```
