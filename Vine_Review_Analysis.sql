-- 1. Create table where total votes >= 20.
SELECT *
INTO vine_helpful
FROM vine_table
WHERE total_votes >= 20;

-- 2. Create table where helpful votes are >= 50%.
SELECT *
INTO vine_helpful_filtered
FROM vine_helpful
WHERE CAST(helpful_votes AS FLOAT) / CAST(total_votes AS FLOAT) >= 0.5;

-- 3. Create table of helpful filtered Vine (paid) reviews
SELECT *
INTO vine_helpful_filtered_vine
FROM vine_helpful_filtered
WHERE vine = 'Y';

-- 4. Create table of helpful filtered non-Vine (unpaid) reviews.
SELECT *
INTO vine_helpful_filtered_non_vine
FROM vine_helpful_filtered
WHERE vine = 'N';

-- 5. Determine the total number of reviews, the number of 5-star reviews,
--    and the percentage of 5-star reviews for the two types of review (paid vs unpaid).
-- Paid, total
SELECT COUNT(review_id) AS total_paid_reviews
FROM vine_helpful_filtered_vine;

-- Paid, 5-star
SELECT COUNT(review_id) AS total_paid_5_star_reviews
FROM vine_helpful_filtered_vine five_star
WHERE star_rating = 5;

-- Paid, percentage of 5-star reviews
SELECT ROUND(CAST((SELECT COUNT(review_id)
                   FROM vine_helpful_filtered_vine five_star
                   WHERE star_rating = 5) AS NUMERIC) /
             CAST(COUNT(review_id) AS NUMERIC) * 100, 2) AS percent_paid_five_star
FROM vine_helpful_filtered_vine;

-- Unpaid, total
SELECT COUNT(review_id) AS total_unpaid_reviews
FROM vine_helpful_filtered_non_vine;

-- Unpaid, 5-star
SELECT COUNT(review_id) AS total_unpaid_5_star_reviews
FROM vine_helpful_filtered_non_vine five_star
WHERE star_rating = 5;

-- Unpaid, percentage of 5-star reviews
SELECT ROUND(CAST((SELECT COUNT(review_id)
                   FROM vine_helpful_filtered_non_vine five_star
                   WHERE star_rating = 5) AS NUMERIC) /
             CAST(COUNT(review_id) AS NUMERIC) * 100, 2) AS percent_unpaid_five_star
FROM vine_helpful_filtered_non_vine;