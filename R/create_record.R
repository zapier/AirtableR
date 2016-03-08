#' Create a record to Airtalbe 
#'
#' \code{create_record} creates an Airtable record remotely by issuing POST request to the table endpoint
#'
#' @param airtable An Airtable wrapper object 
#' @param fields A list
#' @return A request object
#' @export

create_record <- function(airtable, fields) {
  stopifnot(is.list(fields)) 
  req <- dispatch_request(
    airtable, 
    fields = fields, 
    method = "post"
  ) 
  airtable_check(req)
  req
} 
