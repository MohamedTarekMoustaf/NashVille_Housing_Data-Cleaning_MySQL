-- ******************Display the first 1000 records in the "Nashville Housing" Table***************
SELECT * FROM `nashville housing data for data cleaning` LIMIT 1000;

-- ***********************************Standardize Date Format*****************************************
UPDATE `nashville housing data for data cleaning`
SET SaleDate = STR_TO_DATE(SaleDate, '%M %d, %Y');
ALTER TABLE `nashville housing data for data cleaning`
MODIFY COLUMN SaleDate DATE;

-- ********************************* Populate property address data *******************************
SELECT ï»¿UniqueID, ParcelID, PropertyAddress FROM `nashville housing data for data cleaning`
ORDER BY ParcelID;
-- UPDATE records with empty cells in "PropertyAddress" column from other rows while ParcelID is the same
UPDATE `nashville housing data for data cleaning` AS T1
JOIN `nashville housing data for data cleaning` AS T2
ON T1.ParcelID = T2.ParcelID 
SET T1.PropertyAddress = T2.PropertyAddress
WHERE (T1.PropertyAddress IS NULL OR T1.PropertyAddress ='') AND T1.ï»¿UniqueID <> T2.ï»¿UniqueID;

-- ******************Breaking out address into individual columns (Address, State)********************
SELECT SUBSTRING_INDEX(PropertyAddress,',',1) AS Address,
SUBSTRING_INDEX(PropertyAddress,',',-1) AS City FROM `nashville housing data for data cleaning`;
-- Adding two columns for street address and city
ALTER TABLE `nashville housing data for data cleaning`
ADD AddressPropertyStreet text;
ALTER TABLE `nashville housing data for data cleaning`
ADD AddressPropertyCity text;
-- INSERT VALUES INTO THE TWO NEW ADDED COLUMNS
UPDATE `nashville housing data for data cleaning` 
SET AddressPropertyStreet = SUBSTRING_INDEX(PropertyAddress,',',1), 
AddressPropertyCity =SUBSTRING_INDEX(PropertyAddress,',',-1);
SELECT AddressPropertyStreet, AddressPropertyCity FROM `nashville housing data for data cleaning`;

-- ************* Breaking out address into individual columns (Street, City, State) *******************
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress,',',2),',',-1) AS OwnerCity
FROM `nashville housing data for data cleaning`;
ALTER TABLE `nashville housing data for data cleaning`
ADD COLUMN OwnerAddressStreet text;
ALTER TABLE `nashville housing data for data cleaning`
ADD COLUMN OwnerAddressCity text;
ALTER TABLE `nashville housing data for data cleaning`
ADD COLUMN OwnerAddressState text;
UPDATE `nashville housing data for data cleaning`
SET OwnerAddressStreet =  SUBSTRING_INDEX(OwnerAddress,',',1);
UPDATE `nashville housing data for data cleaning`
SET OwnerAddressCity =  SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress,',',2),',',-1);
UPDATE `nashville housing data for data cleaning`
SET OwnerAddressState =  SUBSTRING_INDEX(OwnerAddress,',',-1);
SELECT OwnerAddressStreet, OwnerAddressCity, OwnerAddressState 
FROM `nashville housing data for data cleaning`;

-- ************************ Convert Y --> Yes and N --> No in SoldAsVacant ****************************
SELECT DISTINCT SoldAsVacant FROM `nashville housing data for data cleaning`;
UPDATE `nashville housing data for data cleaning`
SET SoldAsVacant = REPLACE(SoldAsVacant,"Y","Yes")
WHERE SoldAsVacant ='Y';
UPDATE `nashville housing data for data cleaning`
SET SoldAsVacant = REPLACE(SoldAsVacant,"N","No")
WHERE SoldAsVacant ='N';
SELECT DISTINCT SoldAsVacant FROM `nashville housing data for data cleaning`;
-- Method2 Using CASE
UPDATE `nashville housing data for data cleaning`
SET SoldAsVacant = 
CASE
 WHEN SoldAsVacant ='Y' THEN "Yes"
 WHEN SoldAsVacant ='N' THEN "No"
 ELSE SoldAsVacant
END;

-- *************************************** Remove Duplicates ******************************************
-- MEthod1: Using Subquery
SELECT * FROM (SELECT *, ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, 
SaleDate, SalePrice, LegalReference ORDER BY ï»¿UniqueID) AS row_num 
FROM `nashville housing data for data cleaning`) AS T1
WHERE row_num >1
ORDER BY PropertyAddress;
-- Method2: USING CTE
WITH ROW_NUM AS (SELECT *, ROW_NUMBER() OVER (PARTITION BY ParcelID, PropertyAddress, 
SaleDate, SalePrice, LegalReference ORDER BY ï»¿UniqueID) AS row_num 
FROM `nashville housing data for data cleaning`)
SELECT * FROM ROW_NUM
WHERE row_num >1
ORDER BY PropertyAddress;

-- ******************************* Removing Unused Columns *****************************************
SELECT TaxDistrict FROM `nashville housing data for data cleaning`;
ALTER TABLE `nashville housing data for data cleaning`
DROP COLUMN OwnerAddress;
ALTER TABLE `nashville housing data for data cleaning`
DROP COLUMN PropertyAddress;
ALTER TABLE `nashville housing data for data cleaning`
DROP COLUMN TaxDistrict;

