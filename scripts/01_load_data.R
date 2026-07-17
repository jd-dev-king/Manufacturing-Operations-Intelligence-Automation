library(tidyverse)

# Load the sales data
production <- read_csv("data/production.csv")

# Display the first few rows
print(head(production))

# Display summary information
glimpse(production)

