library(dplyr)
library(lubridate)

#-------------------------
# Clean Sales Data
#-------------------------

# Convert Date column to Date format
sales$Date <- ymd(sales$Date)

# Remove duplicate rows
sales <- distinct(sales)

# Remove rows with missing values
sales <- na.omit(sales)

# Remove negative values
sales <- sales %>%
  filter(
    Units >= 0,
    Revenue >= 0
  )

# Calculate revenue per unit
sales <- sales %>%
  mutate(
    RevenuePerUnit = Revenue / Units
  )

cat("\nData cleaned successfully!\n")
cat("Rows:", nrow(sales), "\n")
cat("Columns:", ncol(sales), "\n")
