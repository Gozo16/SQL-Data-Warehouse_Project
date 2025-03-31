/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

if object_id('bronze.crm_cust_info','U') is not null
	drop Table bronze.crm_cust_info;
create table bronze.crm_cust_info(
	cst_id INT,
	cst_key NVARCHAR(50),
	cst_firstname NVARCHAR(50),
	cst_lastname NVARCHAR(50),
	cst_material_status NVARCHAR(50),
	cst_gndr NVARCHAR(50),
	cst_create_date DATE
);

if object_id('bronze.crm_prd_info','U') is not null
	drop Table bronze.crm_prd_info;
CREATE TABLE bronze.crm_prd_info(
	prd_id INT,
	prd_key NVARCHAR(50),
	prd_nm NVARCHAR(50),
	prd_cost INT,
	prd_line NVARCHAR(50),
	prd_start_dt DATETIME,
	prd_end_dt DATETIME,
);

if object_id('bronze.crm_sales_details','U') is not null
	drop Table bronze.crm_sales_details;
create table bronze.crm_sales_details(
	sls_ord_num NVARCHAR(50),
	sls_prd_key NVARCHAR(50),
	sls_cust_id INT,
	sls_order_dt INT,
	sls_ship_dt INT,
	sls_due_dt INT,
	sls_sales INT,
	sls_quantity INT,
	sls_price INT
);

if object_id('bronze.erp_loc_a101','U') is not null
	drop Table bronze.erp_loc_a101;
create table bronze.erp_loc_a101(
	cid NVARCHAR(50),
	cntry NVARCHAR(50)
);

if object_id('bronze.erp_cust_az12','U') is not null
	drop Table bronze.erp_cust_az12;
create table bronze.erp_cust_az12(
	cid NVARCHAR(50),
	bdate DATE,
	gen NVARCHAR(50)
);

if object_id('bronze.erp_px_cat_g1v2','U') is not null
	drop Table bronze.erp_px_cat_g1v2;
create table bronze.erp_px_cat_g1v2(
	id NVARCHAR(50),
	cat NVARCHAR(50),
	subcat NVARCHAR(50),
	maintenance NVARCHAR(50)
);
 
create or alter procedure bronze.load_bronze AS 
Begin
Truncate table bronze.crm_cust_info;
Bulk Insert bronze.crm_cust_info
from 'C:\DataWarehouse Project\Project Files\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
with (
	Firstrow= 2,
	Fieldterminator = ',',
	tablock 
);

select count(*) from bronze.crm_cust_info

Truncate table bronze.crm_prd_info;
Bulk Insert bronze.crm_prd_info
from 'C:\DataWarehouse Project\Project Files\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
with (
	Firstrow= 2,
	Fieldterminator = ',',
	tablock 
);

Truncate table bronze.crm_sales_details;
Bulk Insert bronze.crm_sales_details
from 'C:\DataWarehouse Project\Project Files\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
with (
	Firstrow= 2,
	Fieldterminator = ',',
	tablock 
);

Truncate table bronze.erp_cust_az12;
Bulk Insert bronze.erp_cust_az12
from 'C:\DataWarehouse Project\Project Files\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
with (
	Firstrow= 2,
	Fieldterminator = ',',
	tablock 
);

Truncate table bronze.erp_loc_a101;
Bulk Insert bronze.erp_loc_a101
from 'C:\DataWarehouse Project\Project Files\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
with (
	Firstrow= 2,
	Fieldterminator = ',',
	tablock 
);

Truncate table bronze.erp_px_cat_g1v2;
Bulk Insert bronze.erp_px_cat_g1v2
from 'C:\DataWarehouse Project\Project Files\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
with (
	Firstrow= 2,
	Fieldterminator = ',',
	tablock 
);
end
