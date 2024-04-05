/*

UPDATE TABLE IN TEMP TABLE

*/

DROP TABLE IF EXISTS #temp_drug

--CREATE TEMP TABLE--
CREATE TABLE #temp_drug(
	gender VARCHAR(50),
	education VARCHAR(50),
	country VARCHAR(50),
	ethnicity VARCHAR(50),
	drugs VARCHAR(50)
)

INSERT INTO #temp_drug (gender, education, country, ethnicity, drugs)
SELECT Gender, Education, Country, Ethnicity, Alcohol
FROM drug_consumption

--UPDATE gender--
UPDATE #temp_drug
SET gender =
CASE
	WHEN gender = '-0.48246' THEN 'F'
	WHEN gender = '0.48246' THEN 'M'
END
FROM #temp_drug

-- UPDATE education--
UPDATE #temp_drug
SET education =
CASE
	WHEN education = '-0.05921' THEN 'Professional Certificate/Diploma'
	WHEN education = '-0.61113' THEN 'Some College, No Certificate Or Degree'
	WHEN education = '-1.22751' THEN 'Left School at 18 years'
	WHEN education = '-1.43719' THEN 'Left School at 17 years'
	WHEN education = '-1.7379' THEN 'Left School at 16 years'
	WHEN education = '-2.43591' THEN 'Left School Before 16 years'
	WHEN education = '0.45468' THEN 'University Degree'
	WHEN education = '1.16365' THEN 'Masters Degree'
	WHEN education = '1.98437' THEN 'Doctorate Degree'
END
FROM #temp_drug

--UPDATE country--
UPDATE #temp_drug
SET country =
CASE
	WHEN country = '-0.09765' THEN 'Australia'
	WHEN country = '-0.28519' THEN 'Other'
	WHEN country = '-0.46841' THEN 'New Zealand'
	WHEN country = '-0.57009' THEN 'USA'
	WHEN country = '0.21128' THEN 'Republic of Ireland'
	WHEN country = '0.24923' THEN 'Canada'
	WHEN country = '0.96082' THEN 'UK'
END
FROM #temp_drug

--UPDATE ethnicity--
UPDATE #temp_drug
SET ethnicity =
CASE
	WHEN ethnicity = '-0.22166' THEN 'Mixed-White/Black'
	WHEN ethnicity = '-0.31685' THEN 'White'
	WHEN ethnicity = '-0.50212' THEN 'Asian'
	WHEN ethnicity = '-1.10702' THEN 'Black'
	WHEN ethnicity = '0.1144' THEN 'Other'
	WHEN ethnicity = '0.126' THEN 'Mixed-White/Asian'
	WHEN ethnicity = '1.90725' THEN 'Mixed-Black/Asian'
END
FROM #temp_drug

--UPDATE drugs--
UPDATE #temp_drug
SET drugs =
CASE
	WHEN drugs = 'CL0' THEN 'Never Used'
	WHEN drugs = 'CL1' THEN 'Used over a Decade Ago'
	WHEN drugs = 'CL2' THEN 'Used in Last Decade'
	WHEN drugs = 'CL3' THEN 'Used in Last Year'
	WHEN drugs = 'CL4' THEN 'Used in Last Month'
	WHEN drugs = 'CL5' THEN 'Used in Last Week'
	WHEN drugs = 'CL6' THEN 'Used in Last Day'
END
FROM #temp_drug

SELECT *
FROM #temp_drug

