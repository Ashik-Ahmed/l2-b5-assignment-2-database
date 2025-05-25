## 1. What is PostgreSQL?

**PostgreSQL** একটি অত্যন্ত পাওয়ারফুল এবং ওপেনসোর্স অবজেক্ট রিলেশনাল ডাটাবেজ ম্যানেজমেন্ট সিস্টেম। ওপেনসোর্স হওয়ার কারণে এর সোর্স কোড উন্মুক্ত এবং সহজেই নিজের চাহিদা অনুযায়ী এই ডেটাবেজ ডাটাবেজ ম্যানেজমেন্ট সিস্টেম কে পরিবর্তন করা সম্ভব। এটি ACID কমপ্লায়েন্ট, এবং এটির উন্নত ফিচার যেমন JSON সাপোর্ট, জিওগ্রাফিক ডাটা হ্যান্ডলিং (PostGIS), কাস্টম ডাটা টাইপ, এবং এক্সটেনসিবিলিটি এর জন্য এটি অন্যান্য RDBMS থেকে এগিয়ে।

এছাড়াও, এটি মাল্টি-ভার্সন কনকারেন্সি কন্ট্রোল (MVCC) এবং পারফরম্যান্স অপ্টিমাইজেশনের জন্য বিখ্যাত।

---

## 2. What is the purpose of a database schema in PostgreSQL?

**PostgreSQL-এ ডাটাবেস স্কিমা**-এর মূল উদ্দেশ্য হল ডাটাবেস অবজেক্টগুলো (যেমন টেবিল, ভিউ, ফাংশন, ইন্ডেক্স) কে লজিক্যাল গ্রুপে সংগঠিত করা। এটি নিম্নলিখিত কাজে সাহায্য করে:

- **Organization** – একাধিক ইউজার বা অ্যাপ্লিকেশন একই ডাটাবেসে কাজ করার সময় তাদের অবজেক্টগুলো আলাদা রাখতে স্কিমা ব্যবহার করা হয়।
- **Access Control** – স্কিমা লেভেলে পারমিশন সেট করে ডাটা সিকিউরিটি ম্যানেজ করা যায়।
- **Namespace Management** – একই নামের টেবিল বা অবজেক্ট ভিন্ন স্কিমায় রাখা সম্ভব, যা নামের কনফ্লিক্ট রোধ করে।
- **Multi-tenancy** – একটি ডাটাবেসে একাধিক স্কিমা ব্যবহার করে আলাদা টেন্যান্টের ডাটা ম্যানেজ করা যায়।

**উদাহরণস্বরূপ**, `public` হল ডিফল্ট স্কিমা, কিন্তু আমরা `sales`, `hr` ইত্যাদি আলাদা স্কিমা তৈরি করে ডাটাকে ক্যাটাগরাইজ করতে পারি।

### বিশেষ সুবিধা:
PostgreSQL-এ স্কিমা ব্যবহার করে আমরা ডাটাবেস ডিজাইনে বেশি **ফ্লেক্সিবিলিটি** এবং **সিকিউরিটি** পাই, যা অনেক RDBMS-এ এতটা সুবিধাজনক নয়।

---

## 3. Explain the Primary Key and Foreign Key concepts in PostgreSQL.


## 🔑 Primary Key
  
একটি টেবিলের প্রতিটি row-কে ইউনিকলি আইডেন্টিফাই করার জন্য Primary Key ব্যবহার করা হয়।

**বৈশিষ্ট্য:**

- এটি **ইউনিক (Unique)** হবে এবং **নাল (NULL)** হতে পারবে না।
- একটি টেবিলে একটি মাত্র **Primary Key** থাকতে পারে (কিন্তু একাধিক কলাম মিলে **Composite Primary Key** হতে পারে)।
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


## 🔗 Foreign Key

এটি একটি টেবিলের কলাম (বা কলামের গ্রুপ) যা অন্য টেবিলের Primary Key-কে রেফার করে। এটি রিলেশনাল ডাটাবেসে টেবিলগুলোর মধ্যে **সম্পর্ক (Relationship)** স্থাপন করে।

**বৈশিষ্ট্য:**

- এটি **ডাটা ইন্টিগ্রিটি (Data Integrity)** বজায় রাখে, অর্থাৎ ভুল ডাটা ইনসার্ট হতে দেয় না।
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
- `CHAR` ফিক্সড-লেংথ টেক্সট স্টোর করে, কিন্তু `VARCHAR` ভ্যারিয়েবল-লেংথ টেক্সট স্টোর করে।  
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

### কখন কোনটি ব্যবহার করা উচিত:
- যদি ডাটা সবসময় ফিক্সড লেংথের হয় (যেমন: দেশের কোড, টেলিফোন নম্বরের নির্দিষ্ট ফরম্যাট), তবে `CHAR` ব্যবহার করবো
- অন্যান্য ক্ষেত্রে `VARCHAR` বা `TEXT` ব্যবহার করাই ভালো

---

## 5. What is the purpose of the WHERE clause in a SELECT statement?

**WHERE ক্লজ** ডাটাবেস কোয়েরিতে একটি শর্ত (condition) যোগ করতে ব্যবহৃত হয়, যা শুধুমাত্র সেইসব রেকর্ড/রো রিটার্ন করে যেগুলো নির্দিষ্ট শর্ত পূরণ করে।

### মূল কাজ:
- ডাটা ফিল্টারিং করার জন্য
- শুধু প্রয়োজনীয় রেকর্ড দেখানোর জন্য
- নির্দিষ্ট শর্ত মেনে চলা ডাটা বাছাই করার জন্য

### উদাহরণ:
```sql
SELECT * FROM employees 
WHERE salary > 50000;
```
এই কোয়েরিটি শুধুমাত্র সেইসব কর্মচারীদের ডাটা দেখাবে যাদের বেতন ৫০,০০০ টাকার বেশি।

### বিশেষ বৈশিষ্ট্য:
- একাধিক শর্ত যোগ করা যায় (`AND`, `OR` ব্যবহার করে)
- তুলনা অপারেটর ব্যবহার করা যায় (>, <, =, != ইত্যাদি)
- প্যাটার্ন ম্যাচিং করা যায় (`LIKE` অপারেটর দিয়ে)
- `NULL` ভ্যালু চেক করা যায় (`IS NULL` / `IS NOT NULL`)

PostgreSQL-এ WHERE ক্লজ অত্যন্ত শক্তিশালী এবং এটি জয়েন, সাবকোয়েরি ও অন্যান্য এডভান্সড অপারেশনের সাথেও ব্যবহার করা যায়।

---


## 6. What are the LIMIT and OFFSET clauses used for?

### ✅ LIMIT
- শুধুমাত্র নির্দিষ্ট সংখ্যক রো রিটার্ন করে
- বড় টেবিল থেকে সামান্য ডাটা ফেচ করতে ব্যবহার করা যায়
- পেজিনেশনে কার্যকরী

```sql
SELECT * FROM products 
LIMIT 10;
```
(প্রথম ১০টি প্রোডাক্ট রেকর্ড দেখাবে)


### ✅ OFFSET
- নির্দিষ্ট সংখ্যক রো স্কিপ করে
- কোয়েরি ফলাফলের শুরুর পয়েন্ট পরিবর্তন করতে ব্যবহৃত হয়।
- LIMIT-এর সাথে ব্যবহার করে পেজিনেশন তৈরি করা যায়

```sql
SELECT * FROM products 
LIMIT 10 OFFSET 20;
```
(২১তম থেকে ৩০তম রেকর্ড দেখাবে - প্রথম ২০টি স্কিপ করবে)


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
- একাধিক কলাম একসাথে আপডেট করা যায়
- `WHERE` দিয়ে নির্দিষ্ট রো নির্বাচন
- একাধিক রো একই সাথে মডিফাই করা সম্ভব
- সাবকোয়েরি ও JOIN সাপোর্ট

### উদাহরণ:

#### সাধারণ আপডেট:
```sql
UPDATE employees
SET salary = 60000
WHERE employee_id = 101;
```
(কর্মচারী নং ১০১-এর বেতন ৬০,০০০ টাকায় আপডেট করবে)

#### একাধিক কলাম আপডেট:
```sql
UPDATE products
SET price = 1200, stock = stock - 1
WHERE product_id = 5;
```
(প্রোডাক্ট আইডি ৫-এর দাম ১২০০ টাকা সেট করবে এবং স্টক ১ কমিয়ে দিবে)

#### শর্তসহ আপডেট:
```sql
UPDATE customers
SET membership_status = 'Premium'
WHERE total_purchases > 100000;
```
(যেসব কাস্টমার ১,০০,০০০ টাকার বেশি কেনাকাটা করেছেন, তাদের মেম্বারশিপ স্ট্যাটাস প্রিমিয়ামে আপডেট করবে)

### সতর্কতা:
- `WHERE` না দিলে সব রো আপডেট হবে

PostgreSQL-এ UPDATE খুবই শক্তিশালী - আমরা সাবকোয়েরি, জয়েন এবং অন্যান্য এডভান্সড ফিচারও এর সাথে ব্যবহার করতে পারি।

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
কাজ: শুধুমাত্র ম্যাচিং রেকর্ড দেখাবে

#### ✅ LEFT JOIN
```sql
SELECT students.name, departments.dept_name
FROM students
LEFT JOIN departments ON students.dept_id = departments.id;
```
কাজ: বাম টেবিলের সব রেকর্ড + ডান টেবিলের ম্যাচিং রেকর্ড

#### ✅ RIGHT JOIN
```sql
SELECT products.name, categories.category_name
FROM products
RIGHT JOIN categories ON products.category_id = categories.id;
```
কাজ: ডান টেবিলের সব রেকর্ড + বাম টেবিলের ম্যাচিং রেকর্ড

#### ✅ FULL JOIN
```sql
SELECT employees.name, projects.project_name
FROM employees
FULL JOIN projects ON employees.project_id = projects.id;
```
কাজ: উভয় টেবিলের সব রেকর্ড (ম্যাচ হোক বা না হোক)

#### ✅ Multiple JOIN
```sql
SELECT o.order_id, c.name, p.product_name
FROM orders o
JOIN customers c ON o.customer_id = c.id
JOIN products p ON o.product_id = p.id
WHERE o.order_date > '2023-01-01';
```

PostgreSQL-এর JOIN অপারেশন ডাটা রিলেশনশিপ এক্সপ্লোর করার জন্য অপরিহার্য একটি টুল, যা সঠিকভাবে ব্যবহার করলে জটিল কোয়েরিকেও সহজে সমাধান করা সম্ভব।

---


## 9. Explain the GROUP BY clause and its role in aggregation operations.

**GROUP BY** ডেটা গ্রুপ করে প্রতিটি গ্রুপে সারসংক্ষেপ তৈরি করে। এটি মূলত:

- ডাটাকে লজিক্যাল গ্রুপে সংগঠিত করে
- প্রতিটি গ্রুপের জন্য অ্যাগ্রিগেট (সমষ্টিগত) মান গণনা করে
- বিশ্লেষণমূলক রিপোর্ট তৈরিতে সহায়তা করে

### অ্যাগ্রিগেশন ফাংশন:
| ফাংশন  | কাজ               |
|---------|-------------------|
| COUNT() | রেকর্ড সংখ্যা গণনা   |
| SUM()   | মানের যোগফল নির্ণয় |
| AVG()   | গড় মান নির্ণয়       |
| MAX()   | সর্বোচ্চ মান নির্ণয়    |
| MIN()   | সর্বনিম্ন মান নির্ণয়    |

### উদাহরণ:
```sql
SELECT department, COUNT(*) as employee_count, AVG(salary) as avg_salary
FROM employees
GROUP BY department;
```
(প্রতিটি ডিপার্টমেন্টের কর্মচারী সংখ্যা এবং গড় বেতন দেখাবে)

### GROUP BY-এর মূল বৈশিষ্ট্য
- গ্রুপিং কলাম: যে কলাম(গুলি) দ্বারা ডাটা গ্রুপ করা হবে
- অ্যাগ্রিগেশন: প্রতিটি গ্রুপের জন্য আলাদা হিসাব

### HAVING vs WHERE:
- `WHERE` → গ্রুপিং এর আগে ফিল্টার
- `HAVING` → গ্রুপিং এর পরে ফিল্টার

### উদাহরণ:
```sql
SELECT department, AVG(salary)
FROM employees
WHERE join_date > '2020-01-01'
GROUP BY department
HAVING AVG(salary) > 50000;
```
(২০২০ সালের পর যোগদানকারীদের মধ্যে, যেসব ডিপার্টমেন্টের গড় বেতন ৫০,০০০ টাকার বেশি)

### উদাহরণ:
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
GROUP BY ক্লজ ডাটা অ্যানালিসিসের ক্ষেত্রে অত্যন্ত শক্তিশালী একটি টুল, যা সঠিকভাবে ব্যবহার করলে জটিল ডাটা থেকেও অর্থপূর্ণ তথ্য উদ্ঘাটন করা সম্ভব।

---

## 10. How can you calculate aggregate functions like COUNT(), SUM(), and AVG() in PostgreSQL?


### PostgreSQL-এ অ্যাগ্রিগেট ফাংশন (COUNT, SUM, AVG) ব্যবহার পদ্ধতি

### ✅ COUNT()

#### উদ্দেশ্য: 
- রেকর্ড/রো সংখ্যা গণনা করা

#### উদাহরণ:
- টেবিলের মোট রো সংখ্যা
```sql
SELECT COUNT(*) FROM employees;
```

- নির্দিষ্ট শর্তে রো সংখ্যা
```sql
SELECT COUNT(*) FROM orders WHERE status = 'Delivered';
```

- unique মানের গণনা
```sql
SELECT COUNT(DISTINCT department) FROM employees;
```

### ✅ SUM()

#### উদ্দেশ্য: 
- সংখ্যাসূচক কলামের মোট যোগফল নির্ণয়

#### উদাহরণ:

- সম্পূর্ণ কলামের যোগফল
```sql
SELECT SUM(salary) FROM employees;
```

- শর্তসাপেক্ষ যোগফল
```sql
SELECT SUM(amount) FROM transactions WHERE transaction_date > '2023-01-01';
```

- একাধিক কলামে SUM
```sql
SELECT SUM(quantity), SUM(price) FROM order_items;
```

### ✅ AVG()

#### উদ্দেশ্য: 
- সংখ্যাসূচক মানের গড় নির্ণয়

#### উদাহরণ:

- সাধারণ গড়
```sql
SELECT AVG(rating) FROM product_reviews;
```

- গ্রুপের গড়
```sql
SELECT department, AVG(salary) FROM employees GROUP BY department;
```
- ROUND() এর সাথে ব্যবহার
```sql
SELECT ROUND(AVG(price), 2) FROM products;
```

### একসাথে ব্যবহার:
```sql
SELECT 
    COUNT(*) as total_orders,
    SUM(amount) as total_revenue,
    AVG(amount) as average_order_value
FROM orders
WHERE order_date BETWEEN '2023-01-01' AND '2023-12-31';
```

### বিশেষ টিপস:
- NULL মানগুলো অ্যাগ্রিগেশন ফাংশন দ্বারা উপেক্ষিত হয়
- DISTINCT কীওয়ার্ড দিয়ে unique মান গণনা করা যায়
- GROUP BY এর সাথে ব্যবহার করে গ্রুপভিত্তিক হিসাব করা যায়
- HAVING ক্লজ দিয়ে অ্যাগ্রিগেট ফলাফল ফিল্টার করা যায়

### FILTER clause:
```sql
SELECT 
    COUNT(*) FILTER (WHERE status = 'Completed') as completed_orders,
    COUNT(*) FILTER (WHERE status = 'Pending') as pending_orders
FROM orders;
```
