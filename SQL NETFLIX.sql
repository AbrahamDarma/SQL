/*
Netflix Userbase Data Exploration
*/

-- Netflix Average Monthly Revenue and Average Age by Country
SELECT nu.Country, 
	ROUND(AVG(nu.Age), 0) avg_age, 
	ROUND(AVG(nu.[Monthly Revenue]), 2) avg_mothly_revenue
FROM Netflix..NetflixUserbase nu
GROUP BY nu.Country
ORDER BY avg_mothly_revenue DESC;

-- 10 Longest Subscribed ID AND THE THEIR COUNTRY
SELECT TOP(10) 
	nu.[User ID], 
	nu.Country,
	DATEDIFF(month, CONVERT(DATE, nu.[Join Date]), 
			CONVERT(DATE, nu.[Last Payment Date])
			) month_subsribed
FROM Netflix..NetflixUserbase nu
GROUP BY nu.[User ID],nu.Country, nu.[Last Payment Date], nu.[Join Date]
ORDER BY month_subsribed DESC;

--Average Subsribction Month by Country
SELECT nu.Country,
	AVG(DATEDIFF(month, CONVERT(DATE, nu.[Join Date]), 
				CONVERT(DATE, nu.[Last Payment Date])
				)
		) user_avg_subs_month
FROM Netflix..NetflixUserbase nu
GROUP BY nu.Country
ORDER BY user_avg_subs_month DESC;

--Total Revenue and User per Subscription Type
SELECT nu.[Subscription Type], 
	SUM(nu.[Monthly Revenue]) total_revenue,
	COUNT(nu.[User ID]) count_user
FROM Netflix..NetflixUserbase nu
GROUP BY nu.[Subscription Type]
ORDER BY total_revenue DESC;