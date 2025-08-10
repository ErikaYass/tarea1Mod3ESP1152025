-- Visualización de datos en la DIM DATE
select * from dw.dim_date

-- 
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
