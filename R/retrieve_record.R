#' Retrieve a record from Airtable 
#'
#' \code{retrieve_record} returns a record by issuing GET request to a record endpoint
#'
#' @param airtable An Airtable wrapper object
#' @param record_id A length-one character vector for record id. e.g "recbYejyoIyRBloTj"
#' @return A list which represents the retrieved record
#' @export

retrieve_record <- function(airtable, record_id) { 

  req <- dispatch_request(airtable, resource_id = record_id, method = "get")

  airtable_check(req)

  httr::content(req) 
} 
