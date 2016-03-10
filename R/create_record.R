#' Create a record to Airtalbe 
#'
#' \code{create_record} creates an Airtable record remotely by issuing POST request to the table endpoint
#'
#' @param base A list
#' @param table A length-one character vector
#' @param fields A list
#' @return A request object

create_record <- function(base, table, fields) {
  req <- dispatch_request(
    base,
    table,
    fields = fields, 
    method = "post"
  ) 
  airtable_check(req)
  req
} 
