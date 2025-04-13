---Begin 
-- 

CREATE TABLE attribution (
    cookie VARCHAR(255),
    time TIMESTAMP,
    interaction VARCHAR(20),
    conversion SMALLINT, 
    conversion_value DECIMAL(10,2),
    channel VARCHAR(50)
);

SELECT
  channel,
  COUNT(*) AS total_interactions
FROM attribution
GROUP BY channel;

SELECT
  channel,
  COUNT(*) AS total_conversions
FROM attribution
WHERE conversion = 1
GROUP BY channel;


WITH interactions AS (
  SELECT channel, COUNT(*) AS total_interactions
  FROM attribution
  GROUP BY channel
),
conversions AS (
  SELECT channel, COUNT(*) AS total_conversions
  FROM attribution
  WHERE conversion = 1
  GROUP BY channel
)
SELECT
  i.channel,
  i.total_interactions,
  c.total_conversions,
  ROUND((c.total_conversions::decimal / i.total_interactions) * 100, 2) AS conversion_rate_percentage
FROM interactions i
JOIN conversions c ON i.channel = c.channel;


SELECT
  channel,
  SUM(conversion_value) AS total_conversion_value
FROM attribution
WHERE conversion = 1
GROUP BY channel;

SELECT
  channel,
  COUNT(*) AS total_conversions,
  SUM(conversion_value) AS total_value,
  ROUND(SUM(conversion_value) / COUNT(*), 2) AS avg_conversion_value
FROM attribution
WHERE conversion = 1
GROUP BY channel;

SELECT
  cookie,
  COUNT(*) AS total_sessions
FROM attribution
GROUP BY cookie;

SELECT
  cookie,
  MAX(conversion) AS did_convert -- 1 kalau pernah convert, 0 kalau tidak
FROM attribution
GROUP BY cookie;

SELECT
  a.cookie,
  COUNT(*) AS total_sessions,
  MAX(a.conversion) AS did_convert
FROM attribution a
GROUP BY a.cookie;

SELECT
  COUNT(DISTINCT cookie) AS total_cookies,
  COUNT(DISTINCT CASE WHEN conversion = 1 THEN cookie END) AS converted_cookies,
  ROUND(COUNT(DISTINCT CASE WHEN conversion = 1 THEN cookie END) / COUNT(DISTINCT cookie), 4) AS cookie_conversion_rate
FROM attribution;

--------------------------------------------------------
DROP TABLE IF EXISTS attribution_summary;

CREATE TABLE attribution_summary AS
SELECT
    channel,
    COUNT(*) AS total_interactions,
    COUNT(*) FILTER (WHERE interaction = 'conversion') AS total_conversions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE interaction = 'conversion') / COUNT(*), 2) AS conversion_rate,
    SUM(conversion_value) AS total_conversion_value
FROM attribution
GROUP BY channel;

-----------------------------------------------
DROP TABLE IF EXISTS customer_behavior_summary;

CREATE TABLE customer_behavior_summary AS
SELECT
    cookie,
    COUNT(*) AS total_sessions,
    COUNT(DISTINCT cookie) FILTER (WHERE interaction = 'conversion') AS total_conversions,
    ROUND(100.0 * COUNT(*) FILTER (WHERE interaction = 'conversion') / COUNT(*), 2) AS conversion_rate,
    SUM(conversion_value) AS total_conversion_value
FROM attribution
GROUP BY cookie;


SELECT COUNT(*) FROM customer_behavior_summary cbs;
