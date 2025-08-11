-- Visualización de datos en la DIM DATE
select * from dw.dim_date

-- 
USE DW_TailSpinToys2025
GO

-- Visualización de datos en DIM PRODUCT
INSERT INTO [dw].[dim_product] (
      product_bk,
      product_sku,
      product_name,
      product_category,
      item_group,
      retail_price
)
SELECT DISTINCT
      p.ProductID AS product_bk,
      p.ProductSKU AS product_sku,
      p.ProductName AS product_name,
      p.ProductCategory AS product_category,
      p.ItemGroup AS item_group,
      p.RetailPrice AS retail_price
FROM [TailspinToys2020-US].[dbo].[Product] p
WHERE NOT EXISTS (
      SELECT 1
      FROM [dw].[dim_product] dp
      WHERE dp.product_bk = p.ProductID
);

-- Visualización de datos DIM REGION
INSERT INTO DW_TailSpinToys2025.dw.dim_region (
      region_bk,
      region_name
)
SELECT DISTINCT
      r.RegionID AS region_bk,
      r.RegionName AS region_name
FROM [TailspinToys2020-US].dbo.Region r
WHERE NOT EXISTS (
      SELECT 1
      FROM DW_TailSpinToys2025.dw.dim_region dr
      WHERE dr.region_bk = r.RegionID
);

-- Visualización de datos DIM STATE

INSERT INTO DW_TailSpinToys2025.dw.dim_state (
      state_bk,
      state_code,
      state_name,
      time_zone
)
SELECT DISTINCT
      s.StateID AS state_bk,
      s.StateCode AS state_code,
      s.StateName AS state_name,
      s.TimeZone AS time_zone
FROM [TailspinToys2020-US].dbo.State s
JOIN DW_TailSpinToys2025.dw.dim_region r
      ON s.RegionID = r.region_bk  -- Solo carga si la región ya está en dim_region
WHERE NOT EXISTS (
      SELECT 1
      FROM DW_TailSpinToys2025.dw.dim_state ds
      WHERE ds.state_bk = s.StateID
);


-- Visualización de datos FACT SALES
