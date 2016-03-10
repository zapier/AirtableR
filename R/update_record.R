#' Update a record
#'
#' \code{update_record} updates a record by issuing PATCH or PUT request to a record endpoint. 
#' Note that if you use PUT method, any fields that are not included will be cleared.
#'
#' @param base A list 
#' @param table A length-one character vector
#' @param record_id A length-one character vector
#' @param fields A list for fields
#' @param method A length-one character vector. The default is "PATCH" 
#' @return A request object

update_record <- function(base, table, record_id, fields, method = "PATCH") {
  req <- dispatch_request(
    base,
    table,
    resource_id = record_id, 
    fields = fields, 
    method = method
  ) 
  airtable_check(req)
  req
} 
