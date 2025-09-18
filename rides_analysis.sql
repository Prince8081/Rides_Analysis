create database ride_analysis;
use ride_analysis;

select * from rides_data limit 10 ;

                          --  1. Basic KPIs --

    -- Total Rides --

SELECT 
    COUNT(*) AS total_rides
FROM
    rides_data;
    
    
   -- Completed vs Cancelled Rides --
   
SELECT 
    ride_status , COUNT(*) AS total_rides
FROM
    rides_data
GROUP BY 1;


-- Total Revenue (only completed rides) --

SELECT 
    round(SUM(total_fare),2) AS total_revenue
FROM
    rides_data
WHERE
    ride_status = 'completed';
    

-- Average Fare per Ride --

SELECT 
    round(AVG(total_fare),2) AS avg_fare
FROM
    rides_data
WHERE
    ride_status = 'completed';
    
    
			--  2. Service Type Analysis --
SELECT 
    services,
    COUNT(*) AS total_rides,
    ROUND(SUM(total_fare), 2) AS total_revenue,
    ROUND(AVG(total_fare), 2) AS avg_fare,
    ROUND(AVG(distance), 2) AS avg_distance,
    SUM(CASE
        WHEN ride_status = 'cancelled' THEN 1
        ELSE 0
    END) AS cancelled_rides
FROM
    rides_data
GROUP BY 1
ORDER BY total_revenue DESC;


          -- 3. Payment Method Insights --
          
SELECT 
    payment_method,
    COUNT(*) AS total_orders,
    ROUND(SUM(total_fare), 2) AS total_revenue
FROM
    rides_data
GROUP BY 1
ORDER BY total_revenue DESC;


             -- 4. Top Routes --

SELECT 
    source,
    destination,
    COUNT(*) AS rides,
    ROUND(AVG(total_fare), 2) AS avg_fare,
    ROUND(AVG(distance), 2) AS avg_distance,
    ROUND(AVG(duration), 2) AS avg_duration
FROM
    rides_data
WHERE
    ride_status = 'completed'
GROUP BY 1 , 2
ORDER BY rides DESC
LIMIT 10;



   -- 5. Cancellation Rate --

SELECT 
    (SUM(CASE
        WHEN ride_status = 'cancelled' THEN 1
        ELSE 0
    END) / COUNT(*)) * 100 as cancellation_rate_percent
FROM
    rides_data;
    
    
    



