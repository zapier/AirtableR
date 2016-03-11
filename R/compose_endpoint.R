#' Compose endpoint to a table or a table record
#'
#' \code{compose_endpoint} composes an endpoint to table or a table record
#'
#' @param air_options A list 
#' @param table A length-one character vector
#' @param record_id An optional length-one character vector for record id e.g "recbYejyoIyRBloTj"
#' @return A length-one character vector which represents the composed endpoint

compose_endpoint <- function(air_options, table, record_id = NULL) {
  paste(
    air_options$api_version, 
    air_options$base,
    table, 
    record_id, 
    sep = "/", 
    collapse = NULL
  )
} 
