#----------------------------------
# Logging Function
#----------------------------------

log_message <- function(message){

  timestamp <- format(
    Sys.time(),
    "%Y-%m-%d %H:%M:%S"
  )

  log_entry <- paste(
    timestamp,
    "-",
    message
  )

  write(
    log_entry,
    file = "logs/automation_log.txt",
    append = TRUE
  )

  cat(log_entry, "\n")
}
