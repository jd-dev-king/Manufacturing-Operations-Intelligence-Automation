library(ggplot2)
library(dplyr)


#----------------------------------
# Create Charts Folder
#----------------------------------

if(!dir.exists("charts")){
  dir.create("charts")
}


#----------------------------------
# 1. Production Output Trend
#----------------------------------

production_trend <- production_kpis %>%
  group_by(Date) %>%
  summarise(
    Total_Produced = sum(Produced_Units)
  )


output_chart <- ggplot(
  production_trend,
  aes(
    Date,
    Total_Produced
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
    title = "Daily Production Output",
    x = "Date",
    y = "Units Produced"
  )


ggsave(
  "charts/production_output.png",
  output_chart,
  width = 8,
  height = 5
)



#----------------------------------
# 2. Yield Trend
#----------------------------------

yield_chart <- ggplot(
  production_kpis,
  aes(
    Date,
    Yield_Percent
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
    title = "Manufacturing Yield Trend",
    x = "Date",
    y = "Yield (%)"
  )


ggsave(
  "charts/yield_trend.png",
  yield_chart,
  width = 8,
  height = 5
)



#----------------------------------
# 3. Scrap By Product
#----------------------------------

scrap_product <- production_kpis %>%
  group_by(Product) %>%
  summarise(
    Scrap = sum(Rejected_Units)
  )


scrap_chart <- ggplot(
  scrap_product,
  aes(
    Product,
    Scrap
  )
) +

  geom_col() +

  theme_minimal() +

  labs(
    title = "Scrap by Product",
    x = "Product",
    y = "Rejected Units"
  )


ggsave(
  "charts/scrap_by_product.png",
  scrap_chart,
  width = 8,
  height = 5
)



#----------------------------------
# 4. Downtime Analysis
#----------------------------------

downtime_line <- production_kpis %>%
  group_by(Line) %>%
  summarise(
    Downtime = sum(Downtime_Minutes)
  )


downtime_chart <- ggplot(
  downtime_line,
  aes(
    Line,
    Downtime
  )
) +

  geom_col() +

  theme_minimal() +

  labs(
    title = "Downtime by Production Line",
    x = "Line",
    y = "Minutes"
  )


ggsave(
  "charts/downtime_analysis.png",
  downtime_chart,
  width = 8,
  height = 5
)


cat("\nManufacturing charts created successfully!\n")

#----------------------------------
# Downtime Pareto Analysis
#----------------------------------

library(dplyr)
library(ggplot2)


downtime_pareto <- production_kpis %>%

  group_by(Downtime_Cause) %>%

  summarise(
    Total_Downtime =
      sum(Downtime_Minutes)
  ) %>%

  arrange(desc(Total_Downtime)) %>%

  mutate(
    Cumulative_Percent =
      cumsum(Total_Downtime) /
      sum(Total_Downtime) * 100
  )


pareto_chart <- ggplot(
  downtime_pareto,
  aes(
    x = reorder(
      Downtime_Cause,
      -Total_Downtime
    ),
    y = Total_Downtime
  )
) +

  geom_col() +

  theme_minimal() +

  labs(
    title = "Downtime Pareto Analysis",
    x = "Downtime Cause",
    y = "Minutes Lost"
  )


ggsave(
  "charts/downtime_pareto.png",
  pareto_chart,
  width = 8,
  height = 5
)


# Identify biggest loss

top_downtime_issue <-
  downtime_pareto$Downtime_Cause[1]
