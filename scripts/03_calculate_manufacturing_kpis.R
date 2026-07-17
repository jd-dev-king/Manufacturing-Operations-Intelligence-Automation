library(dplyr)


#----------------------------------
# Manufacturing KPI Calculations
#----------------------------------


production_kpis <- production %>%

  mutate(

    Yield_Percent =
      ((Produced_Units - Rejected_Units)
       / Produced_Units) * 100,


    Scrap_Percent =
      (Rejected_Units /
         Produced_Units) * 100,


    Availability_Percent =
      ((480 - Downtime_Minutes)
       / 480) * 100

  )


# Overall Metrics

total_production <-
  sum(production_kpis$Produced_Units)


total_rejected <-
  sum(production_kpis$Rejected_Units)


average_yield <-
  mean(production_kpis$Yield_Percent)


average_scrap <-
  mean(production_kpis$Scrap_Percent)


average_downtime <-
  mean(production_kpis$Downtime_Minutes)



cat("\n====== Manufacturing KPI Summary ======\n")

cat(
  "Total Production:",
  total_production,
  "units\n"
)

cat(
  "Total Rejects:",
  total_rejected,
  "units\n"
)

cat(
  "Average Yield:",
  round(average_yield,2),
  "%\n"
)

cat(
  "Average Scrap:",
  round(average_scrap,2),
  "%\n"
)

cat(
  "Average Downtime:",
  round(average_downtime,2),
  "minutes\n"
)

cat("=======================================\n")

#----------------------------------
# OEE Calculation
#----------------------------------

planned_minutes <- 480


production_kpis <- production_kpis %>%

  mutate(

    Availability =
      (planned_minutes - Downtime_Minutes)
    /
      planned_minutes,


    Performance =
      Produced_Units /
      Planned_Units,


    Quality =
      (Produced_Units - Rejected_Units)
    /
      Produced_Units,


    OEE =
      Availability *
      Performance *
      Quality

  )


average_oee <- mean(
  production_kpis$OEE
) * 100



cat(
  "Average OEE:",
  round(average_oee,2),
  "%\n"
)

