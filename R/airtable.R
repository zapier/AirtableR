#' Class: Airtable
#'
#' \code{Airtable} is an S3 class to represent an Airtbale API wrapper
#' @param app A length-one character vector for app name
#' @param table A length-one character vector for table name
#' @return An Airtable wrapper object
#' @export

Airtable <- function(app, table) {
  out <- structure(
    list(
      app = app,
      table = table,
      base_url = "https://api.airtable.com",
      version = "v0"
    ),
    class = "Airtable"
  )
} 

