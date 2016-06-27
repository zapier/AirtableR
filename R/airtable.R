#' Class: Airtable
#'
#' \code{Airtable} is an S3 class to represent an Airtbale API wrapper
#' @param base A length-one character vector for base name
#' @param tables A character vector for tables
#' @return An Airtable wrapper object
#' @export

Airtable <- function(base, tables) {

  air_options        <- list(
    base_url    = "https://api.airtable.com",
    api_version = "v0",
    base         = base
  )

  out             <- lapply(tables, function(x) airtable_funs(air_options, x))
  names(out)      <- tables
  class(out)      <- "Airtable"
  attr(out, "base") = base
  return(out)
}


airtable_funs <- function(air_options, table) {

  res_list <- list()

  res_list[["list_records"]] <- function(
    pageSize = NULL,
    offset = NULL,
    recursive = TRUE,
    filter_by_formula = NULL,
    maxRecords = NULL
  ) {

    list_records(
      air_options,
      table,
      pageSize,
      offset,
      recursive,
      filter_by_formula,
      maxRecords
    )
  }

  res_list[["retrieve_record"]] <-
    function(record_id) {
      retrieve_record(air_options, table, record_id)
    }

  res_list[["create_record"]] <-
    function(fields) {
      create_record(air_options, table, fields)
    }

  res_list[["update_record"]] <-
    function(record_id, fields, method = "PATCH") {
      update_record(air_options, table, record_id, fields, method = method)
    }

  res_list[["delete_record"]] <-
    function(record_id) {
      delete_record(air_options, table, record_id)
    }

  res_list
}
