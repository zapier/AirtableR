#' Compose endpoint to a table or a table record
#'
#' \code{compose_endpoint} composes an endpoint to table or a table record
#'
#' @param base An Airtable wrapper object
#' @param table A length-one character vector
#' @param record_id An optional length-one character vector for record id e.g "recbYejyoIyRBloTj"
#' @return A length-one character vector which represents the composed endpoint

compose_endpoint <- function(base, table, record_id = NULL) {
  paste(
    base$api_version, 
    base$app,
    table, 
    record_id, 
    sep = "/", 
    collapse = NULL
  )
} 
