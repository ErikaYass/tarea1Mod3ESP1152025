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
SELECT 
    ROW_NUMBER() OVER (ORDER BY s.OrderNumber) AS sales_id,
    s.OrderNumber AS order_number,
    d.date_key,
    p.product_sk,
    st.state_sk,
    r.region_sk,
    s.Quantity,
    s.UnitPrice,
    s.DiscountAmount,
    (s.Quantity * s.UnitPrice) - s.DiscountAmount AS total_amount
FROM [TailspinToys2020-US].dbo.Sales s

    -- Join con dimensión fecha (OrderDate en formato AAAAMMDD)
   INNER JOIN dw.dim_date d
    ON d.[date] = FORMAT(s.OrderDate, 'yyyyMMdd')

    -- Join con dimensión producto (BK = ProductID)
    INNER JOIN dw.dim_product p
        ON p.product_bk = s.ProductID

    -- Join con dimensión estado (BK = CustomerStateID)
    INNER JOIN dw.dim_state st
        ON st.state_bk = s.CustomerStateID

    -- Join con dimensión región
    INNER JOIN dw.dim_region r
        ON r.region_sk = st.region_sk;
GO


