library(ggplot2)
library(dplyr)


#----------------------------------
# Create Charts Folder
#----------------------------------

if(!dir.exists("charts")){
  dir.create("charts")
}


#----------------------------------
# 1. Daily Revenue Trend
#----------------------------------

revenue_chart <- ggplot(
  daily_summary,
  aes(
    x = Date,
    y = TotalRevenue
  )
) +

  geom_line(
    linewidth = 1.2
  ) +

  geom_point(
    size = 3
  ) +

  theme_minimal() +

  labs(
    title = "Daily Revenue Trend",
    x = "Date",
    y = "Revenue ($)"
  )


ggsave(
  filename = "charts/daily_revenue.png",
  plot = revenue_chart,
  width = 8,
  height = 5
)



#----------------------------------
# 2. Units Sold by Product
#----------------------------------

product_units <- sales %>%
  group_by(Product) %>%
  summarise(
    Units = sum(Units)
  )


units_chart <- ggplot(
  product_units,
  aes(
    Product,
    Units
  )
) +

  geom_col() +

  theme_minimal() +

  labs(
    title = "Units Sold by Product",
    x = "Product",
    y = "Units Sold"
  )


ggsave(
  filename = "charts/product_units.png",
  plot = units_chart,
  width = 8,
  height = 5
)



#----------------------------------
# 3. Revenue by Product
#----------------------------------

product_revenue <- sales %>%
  group_by(Product) %>%
  summarise(
    Revenue = sum(Revenue)
  )


revenue_product_chart <- ggplot(
  product_revenue,
  aes(
    Product,
    Revenue
  )
) +

  geom_col() +

  theme_minimal() +

  labs(
    title = "Revenue by Product",
    x = "Product",
    y = "Revenue ($)"
  )


ggsave(
  filename = "charts/product_revenue.png",
  plot = revenue_product_chart,
  width = 8,
  height = 5
)


cat("\nCharts created successfully!\n")
