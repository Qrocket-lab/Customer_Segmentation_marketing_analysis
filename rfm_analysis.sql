CREATE TABLE superstore_orders (
    row_id SERIAL PRIMARY KEY,
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(20),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(20),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(10),
    region VARCHAR(20),
    product_id VARCHAR(20),
    category VARCHAR(50),
    subcategory VARCHAR(50),
    product_name TEXT,
    sales NUMERIC(10,2),
    quantity INTEGER,
    discount NUMERIC(5,2),
    profit NUMERIC(10,2)
);

------------------------------------------------------------------------
-- Mencari nilai RFM
-- Step 1: Ambil tanggal referensi (yaitu sehari setelah order terakhir)
WITH reference_date AS (
    SELECT MAX(order_date) + INTERVAL '1 day' AS ref_date
    FROM superstore_orders
),
-- Step 2: Hitung nilai RFM untuk setiap customer
rfm_calculation AS (
    SELECT
        s.customer_id,
        s.customer_name,
        EXTRACT(DAY FROM ((SELECT ref_date FROM reference_date) - MAX(s.order_date))) AS recency,
        COUNT(DISTINCT s.order_id) AS frequency,
        SUM(s.sales) AS monetary
    FROM superstore_orders s
    GROUP BY s.customer_id, s.customer_name
),
-- Step 3: Berikan skor RFM
rfm_scores AS (
    SELECT
        *,
        CASE
            WHEN recency <= 30 THEN 4
            WHEN recency <= 90 THEN 3
            WHEN recency <= 180 THEN 2
            ELSE 1
        END AS recency_score,
        CASE
            WHEN frequency >= 15 THEN 4
            WHEN frequency >= 10 THEN 3
            WHEN frequency >= 5 THEN 2
            ELSE 1
        END AS frequency_score,
        CASE
            WHEN monetary >= 5000 THEN 4
            WHEN monetary >= 2000 THEN 3
            WHEN monetary >= 1000 THEN 2
            ELSE 1
        END AS monetary_score
    FROM rfm_calculation
)
-- Step 4: Simpan hasil ke tabel sementara
SELECT *
INTO temp_rfm_scores
FROM rfm_scores;

-- Step 5: Buat tabel permanen dari tabel sementara
CREATE TABLE rfm_scores_final AS
SELECT *
FROM temp_rfm_scores;

-- Step 6: Ambil hasil akhir dari tabel permanen
SELECT *
FROM rfm_scores_final
ORDER BY customer_id;

--- Menggabungkan data dari temp rfm score dan data dari superstore
-- Step 5: Buat tabel baru dengan kolom tambahan
CREATE TABLE rfm_scores_visual AS
SELECT
    t.*,
    s.segment,
    s.country,
    s.city,
    s.state,
    s.region
FROM
    temp_rfm_scores t
JOIN
    superstore_orders s ON t.customer_id = s.customer_id
GROUP BY
    t.customer_id, t.customer_name, t.recency, t.frequency, t.monetary, t.recency_score, t.frequency_score, t.monetary_score,
    s.segment, s.country, s.city, s.state, s.region;
   
  
---menggabungkan semua data di superstore dan hasil query rfm


CREATE TABLE rfm_scores_final AS
SELECT
    t.*,
    s.order_id,
    s.order_date,
    s.ship_date,
    s.ship_mode,
    s.segment,
    s.country,
    s.city,
    s.state,
    s.postal_code,
    s.region,
    s.product_id,
    s.category,
    s.subcategory,
    s.product_name,
    s.sales,
    s.quantity,
    s.discount,
    s.profit
FROM
    temp_rfm_scores t
JOIN
    superstore_orders s ON t.customer_id = s.customer_id;