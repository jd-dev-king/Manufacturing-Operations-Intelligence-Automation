library(dplyr)

#-------------------------
# Daily Summary
#-------------------------

daily_summary <- sales %>%
  group_by(Date) %>%
  summarise(
    TotalUnits = sum(Units),
    TotalRevenue = sum(Revenue),
    AverageRevenue = mean(Revenue),
    .groups = "drop"
  )

print(daily_summary)

#-------------------------
# Overall KPIs
#-------------------------

total_units <- sum(sales$Units)

total_revenue <- sum(sales$Revenue)

average_daily_revenue <- mean(daily_summary$TotalRevenue)

top_product <- sales %>%
  group_by(Product) %>%
  summarise(
    Revenue = sum(Revenue),
    .groups = "drop"
  ) %>%
  arrange(desc(Revenue)) %>%
  slice(1)

cat("\n========== KPI SUMMARY ==========\n")
cat("Total Units Sold:", total_units, "\n")
cat("Total Revenue: $", total_revenue, "\n")
cat("Average Daily Revenue: $", round(average_daily_revenue,2), "\n")
cat("Top Product:", top_product$Product, "\n")
cat("=================================\n")
