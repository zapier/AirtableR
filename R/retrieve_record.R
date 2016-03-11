#' Retrieve a record from Airtable 
#'
#' \code{retrieve_record} returns a record by issuing GET request to a record endpoint
#'
#' @param air_options A list 
#' @param table A length-one character vector
#' @param record_id A length-one character vector for record id. e.g "recbYejyoIyRBloTj"
#' @return A list which represents the retrieved record

retrieve_record <- function(air_options, table, record_id) { 

  req <- dispatch_request(
    air_options, 
    table,
    resource_id = record_id, 
    method = "get"
  )

  airtable_check(req)

  httr::content(req) 
} 
