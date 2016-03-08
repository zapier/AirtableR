#' Update a record
#'
#' \code{update_record} updates a record by issuing PATCH or PUT request to a record endpoint. 
#' Note that if you use PUT method, any fields that are not included will be cleared.
#'
#' @param airtable An Airtable wrapper object
#' @param record_id A length-one character vector
#' @param fields A list for fields
#' @param method A length-one character vector. The default is "PATCH" 
#' @return A request object
#' @export

update_record <- function(airtable, record_id, fields, method = "PATCH") {
  stopifnot(is.list(fields)) 
  req <- dispatch_request(
    airtable, 
    resource_id = record_id, 
    fields = fields, 
    method = method
  ) 
  airtable_check(req)
  req
} 
