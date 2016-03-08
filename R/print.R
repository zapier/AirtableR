#' print
#' 
#' \code{print} is a generic function. print an Airtable object
#' @param obj An object

print <- function(obj) {
  UseMethod("print")(obj)
}

print.Airtable <- function(obj) {
  cat(paste("Airtable wrapper", "\n"))
  cat(paste("app name:", obj$app, "\n")) 
  cat(paste("table name:", obj$table, "\n")) 
} 

