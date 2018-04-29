# Returns TRUE if a status is valid; throws error otherwise.
validateStatus <- function(status) {
  
  if (status %in% validStatuses) {
    return(TRUE)
  }
  
  stop("Invalid status: ", status, ". Valid statuses are: ",
       paste(validStatuses, collapse = ", "), ".")
}

validStatuses <- c("primary", "success", "info", "warning", "danger")