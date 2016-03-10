#' @keywords internal
#' @export 

print.Airtable <- function(obj) {
  cat(paste("Airtable", attr(obj, "base"), "\n"))
  cat(paste("Tables: "))
  cat(paste(paste(names(obj), collapse = ", "), "\n"))
} 
