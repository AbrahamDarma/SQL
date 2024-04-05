/*

UPDATE TABLE IN CLONED TABLE

*/


DROP TABLE IF EXISTS drugs_cleaned

--CLONE TABLE--
SELECT *
INTO drugs_cleaned
FROM drug_consumption

--ALTER TABLE--
ALTER TABLE drugs_cleaned ALTER COLUMN Gender VARCHAR(50)
ALTER TABLE drugs_cleaned ALTER COLUMN Education VARCHAR(50) 
ALTER TABLE drugs_cleaned ALTER COLUMN Country VARCHAR(50) 
ALTER TABLE drugs_cleaned ALTER COLUMN Ethnicity VARCHAR(50) 

--UPDATE Gender--
UPDATE drugs_cleaned
SET Gender =
CASE
	WHEN Gender = '-0.48246' THEN 'F'
	WHEN Gender = '0.48246' THEN 'M'
END
FROM drugs_cleaned

-- UPDATE Education--
UPDATE drugs_cleaned
SET Education =
CASE
	WHEN Education = '-0.05921' THEN 'Professional Certificate/Diploma'
	WHEN Education = '-0.61113' THEN 'Some College, No Certificate Or Degree'
	WHEN Education = '-1.22751' THEN 'Left School at 18 years'
	WHEN Education = '-1.43719' THEN 'Left School at 17 years'
	WHEN Education = '-1.7379' THEN 'Left School at 16 years'
	WHEN Education = '-2.43591' THEN 'Left School Before 16 years'
	WHEN Education = '0.45468' THEN 'University Degree'
	WHEN Education = '1.16365' THEN 'Masters Degree'
	WHEN Education = '1.98437' THEN 'Doctorate Degree'
END
FROM drugs_cleaned

--UPDATE Country--
UPDATE drugs_cleaned
SET Country =
CASE
	WHEN Country = '-0.09765' THEN 'Australia'
	WHEN Country = '-0.28519' THEN 'Other'
	WHEN Country = '-0.46841' THEN 'New Zealand'
	WHEN Country = '-0.57009' THEN 'USA'
	WHEN Country = '0.21128' THEN 'Republic of Ireland'
	WHEN Country = '0.24923' THEN 'Canada'
	WHEN Country = '0.96082' THEN 'UK'
END
FROM drugs_cleaned

--UPDATE Ethnicity--
UPDATE drugs_cleaned
SET Ethnicity =
CASE
	WHEN Ethnicity = '-0.22166' THEN 'Mixed-White/Black'
	WHEN Ethnicity = '-0.31685' THEN 'White'
	WHEN Ethnicity = '-0.50212' THEN 'Asian'
	WHEN Ethnicity = '-1.10702' THEN 'Black'
	WHEN Ethnicity = '0.1144' THEN 'Other'
	WHEN Ethnicity = '0.126' THEN 'Mixed-White/Asian'
	WHEN Ethnicity = '1.90725' THEN 'Mixed-Black/Asian'
END
FROM drugs_cleaned

--CLEANED TABLE EXPLORATION--
SELECT TOP 50 Gender, Education, Country, Ethnicity, 
	CASE
		WHEN LSD = 'CL0' THEN 'Never Used'
		WHEN LSD = 'CL1' THEN 'Used over a Decade Ago'
		WHEN LSD = 'CL2' THEN 'Used in Last Decade'
		WHEN LSD = 'CL3' THEN 'Used in Last Year'
		WHEN LSD = 'CL4' THEN 'Used in Last Month'
		WHEN LSD = 'CL5' THEN 'Used in Last Week'
		WHEN LSD = 'CL6' THEN 'Used in Last Day'
	END as Usage
FROM drugs_cleaned;

SELECT DISTINCT LSD, COUNT(*) OVER(PARTITION BY LSD) as Users
FROM drugs_cleaned
ORDER BY LSD
