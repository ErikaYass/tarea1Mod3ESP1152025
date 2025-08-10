--Creaci�n del DataWarehouse correspondiente a la tarea 1 del m�dulo 3

CREATE DATABASE DW_TailSpinToys2025;
GO
USE DW_TailSpinToys2025;
GO

--Schema de la nueva DW
CREATE SCHEMA dw; 
GO

-- Creaci�n de DIM DATE 

CREATE TABLE dw.dim_date (
    date_key INT PRIMARY KEY,
    [date] DATE NOT NULL,
    [day] INT NOT NULL,
    [month] INT NOT NULL,
    [year] INT NOT NULL
);
GO

-- Creaci�n de DIM PRODUCT

CREATE TABLE dw.dim_product (
    product_sk INT IDENTITY(1,1) PRIMARY KEY,
    product_bk INT NOT NULL, -- ProductID del origen
    product_sku NVARCHAR(50) NOT NULL,
    product_name NVARCHAR(50) NOT NULL,
    product_category NVARCHAR(50) NOT NULL,
    item_group NVARCHAR(50) NOT NULL,
    retail_price MONEY NOT NULL
);
GO
