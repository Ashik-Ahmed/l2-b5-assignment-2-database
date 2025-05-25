
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

---

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

---

✅ **সারসংক্ষেপ:**  
Primary Key ও Foreign Key ব্যবহার করে আমরা PostgreSQL-এ ডাটাবেজের ভেতরে ইউনিকনেস নিশ্চিত করি এবং টেবিলগুলোর মধ্যে সম্পর্ক স্থাপন করি, যা ডেটার গঠন ও সুরক্ষা নিশ্চিত করে।
