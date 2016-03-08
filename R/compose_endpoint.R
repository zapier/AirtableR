#' Compose endpoint to a table or a table record
#'
#' \code{compose_endpoint} composes an endpoint to table or a table record
#'
#' @param airtable An Airtable wrapper object
#' @param record_id An optional length-one character vector for record id e.g "recbYejyoIyRBloTj"
#' @return A length-one character vector which represents the composed endpoint

compose_endpoint <- function(airtable, record_id = NULL) {
  stopifnot(class(airtable) == "Airtable")
  paste(
    airtable$version, 
    airtable$app, 
    airtable$table, 
    record_id, 
    sep = "/", 
    collapse = NULL
  )
} 
