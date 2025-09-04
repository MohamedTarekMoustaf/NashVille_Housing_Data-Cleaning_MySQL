# NashVille_Housing_Data-Cleaning_MySQL
Here’s a professional README.md you can upload to GitHub for your SQL project:

# Nashville Housing Data Cleaning (SQL Project)

## 📌 Project Overview
This project focuses on cleaning and transforming raw Nashville housing data using **SQL**.  
The dataset contains real estate property sales information, which required standardization, deduplication, and restructuring to improve usability for analysis.

The SQL script in this repository walks through a series of data cleaning steps that are essential for preparing the dataset for accurate analysis and reporting.

---

## 🛠️ Tools & Technologies
- **SQL** (MySQL / compatible RDBMS)
- Dataset: Nashville Housing Property Sales Records

---

## 🧹 Data Cleaning Steps
The following transformations were performed:

1. **Standardize Date Format**  
   - Converted inconsistent `SaleDate` values into a proper SQL `DATE` format.

2. **Populate Missing Property Address Data**  
   - Used self-joins to fill missing `PropertyAddress` values based on matching `ParcelID`.

3. **Split Address into Components**  
   - Broke down `PropertyAddress` into `Street` and `City`.  
   - Extracted `OwnerAddress` into `Street`, `City`, and `State`.

4. **Normalize Categorical Values**  
   - Converted `SoldAsVacant` column values:  
     - `"Y"` → `"Yes"`  
     - `"N"` → `"No"`

5. **Remove Duplicates**  
   - Applied `ROW_NUMBER()` window function to identify and remove duplicate records.

6. **Drop Unused Columns**  
   - Removed unnecessary columns such as `TaxDistrict`, `OwnerAddress`, and `PropertyAddress` to streamline the dataset.

---

## 📂 Repository Structure


├── Nashville_Housing_Data_Cleaning.sql # SQL script with all cleaning steps
├── README.md # Project documentation


---

## 🚀 How to Use
1. Clone this repository:
   ```bash
   git clone https://github.com/your-username/nashville-housing-data-cleaning.git


Import your Nashville housing dataset into your SQL environment.

Run the Nashville_Housing_Data_Cleaning.sql script step by step.

Verify transformations by running the provided SELECT statements.

📈 Outcomes

A clean and standardized dataset ready for analysis and visualization.

Improved data quality through standardization, normalization, and deduplication.
