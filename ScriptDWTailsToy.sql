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