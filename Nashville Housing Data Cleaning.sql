/*

Data Cleaning
Credits to AlexTheAnalyst

*/


--Standardize Date Format--
SELECT SaleDate
FROM nash

ALTER TABLE nash
ALTER COLUMN SaleDate Date

--Property Adress Data NULL--
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM nash a
JOIN nash b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM nash a
JOIN nash b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

--Property Address--
SELECT PropertyAddress
FROM nash

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) AS Address
FROM nash

ALTER TABLE nash
ADD PropertySplitAddress NVARCHAR(MAX)

UPDATE nash
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE nash
ADD PropertySplitCity NVARCHAR(MAX)

UPDATE nash
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))

SELECT*
FROM nash

--Owner Address---
SELECT
PARSENAME(REPLACE(OwnerAddress,',','.'), 3),
PARSENAME(REPLACE(OwnerAddress,',','.'), 2),
PARSENAME(REPLACE(OwnerAddress,',','.'), 1)
FROM nash

ALTER TABLE nash
ADD OwnerSplitAddress NVARCHAR(MAX)

UPDATE nash
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress,',','.'), 3)

ALTER TABLE nash
ADD OwnerSplitCity NVARCHAR(MAX)

UPDATE nash
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress,',','.'), 2)

ALTER TABLE nash
ADD OwnerSplitState NVARCHAR(MAX)

UPDATE nash
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress,',','.'), 1)

-- Change Y and N to Yes and No in 'Sold as Vacant'--
SELECT DISTINCT SoldAsVacant, COUNT(SoldAsVacant)
FROM nash
GROUP BY SoldAsVacant
ORDER BY COUNT(SoldAsVacant)

SELECT SoldAsVacant,
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END
FROM nash

UPDATE nash
SET SoldAsVacant = 
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END
FROM nash

--Remove Duplicate--
WITH rowCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY [ParcelID], [PropertyAddress], [SalePrice], [SaleDate], [LegalReference]
	ORDER BY [UniqueID ]) as row_num
FROM nash
)
DELETE
FROM rowCTE
WHERE row_num > 1

--Delete Unused Column--
SELECT *
FROM nash

ALTER TABLE nash
DROP COLUMN [OwnerAddress], [TaxDistrict], [PropertyAddress]