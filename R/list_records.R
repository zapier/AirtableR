#' List records form Airtable 
#'
#' \code{list_records} returns records by issuing GET request to a table endpoint
#'
#' @param airtable An Airtable wrapper object
#' @param offset An optional length-one character vector
#' @param filterByFormula An optional length-one character vector
#' @export

list_records <- function(airtable, offset = NULL, filterByFormula = NULL) { 

  query <- list()

  if (!is.null(offset)) {
    query <- append(query, list(offset = offset))
  }

  if (!is.null(filterByFormula)) {
    query <- append(query, list(filterByFormula = filterByFormula))
  }

  req <- dispatch_request(airtable, method = "GET", query = query)

  airtable_check(req) 

  offset  <- httr::content(req)$offset
  records <- httr::content(req)$records

  # recursively append next page records to `records` 
  if (!is.null(offset)) {
    return(
      records <- append(
        records, 
        list_records(
          airtable,
          offset = offset
        )
      )
    )
  } 

  records
} 

