#' List records form Airtable
#'
#' \code{list_records} returns records by issuing GET request to a table endpoint
#'
#' @param air_options A list
#' @param table A length-one character vector
#' @param offset An optional length-one character vector
#' @param recursive A length-one logical vector
#' @param filter_by_formula An optional length-one character vector

list_records <- function(
    air_options,
    table,
    pageSize = NULL,
    offset = NULL,
    recursive = TRUE,
    filter_by_formula = NULL,
    maxRecords = NULL
  ) {

  query <- list()

  if(!is.null(offset)) {
    query <- append(
        query,
        list(offset = offset)
      )
  }

  if(!is.null(pageSize)) {
    query <- append(
      query,
      list(pageSize = pageSize)
    )
  }

  if(!is.null(maxRecords)) {
    query <- append(
      query,
      list(maxRecords = maxRecords)
    )
  }

  if(!is.null(filter_by_formula)) {
    query <- append(
        query,
        list(
          filterByFormula = filter_by_formula
        )
      )
  }

  req <- dispatch_request(
      air_options,
      table,
      method = "GET",
      query = query
    )

  airtable_check(req)

  offset  <- httr::content(req)$offset
  records <- httr::content(req)$records

  # recursively append next page records to `records`
  if (recursive && !is.null(offset)) {
    return(
      records <- append(
        records,
        list_records(
          air_options,
          table,
          offset = offset,
          recursive = recursive
        )
      )
    )
  }

  records
}

