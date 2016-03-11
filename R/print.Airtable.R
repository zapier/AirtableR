#' @keywords internal
#' @export 

print.Airtable <- function(obj) {
  cat(paste("Airtable Base", "\n"))
  cat(paste("Base:", attr(obj, "base"), "\n"))
  cat(paste("Tables: "))
  cat(paste(paste(names(obj), collapse = ", "), "\n"))
} 
