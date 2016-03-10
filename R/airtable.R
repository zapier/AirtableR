#' Class: Airtable
#'
#' \code{Airtable} is an S3 class to represent an Airtbale API wrapper
#' @param app A length-one character vector for app name
#' @param tables A character vector for tables
#' @return An Airtable wrapper object
#' @export

Airtable <- function(app, tables) {

  base        <- list(
    base_url    = "https://api.airtable.com",
    api_version = "v0",
    app         = app
  )

  out             <- lapply(tables, function(x) airtable_funs(base, x)) 
  names(out)      <- tables 
  class(out)      <- "Airtable" 
  attr(out, "app") = app 
  return(out)
} 


airtable_funs <- function(base, table) {

  res_list <- list()

  res_list[["list_records"]] <- 
    function(
      offset = NULL, 
      filterByFormula = NULL) {
      list_records(base, table, offset, filterByFormula)
    }

  res_list[["retrieve_record"]] <- 
    function(record_id) {
      retrieve_record(base, table, record_id)
    }

  res_list[["create_record"]] <- 
    function(fields) {
      create_record(base, table, fields)
    }

  res_list[["update_record"]] <- 
    function(record_id, fields, method = "PATCH") {
      update_record(base, table, record_id, fields, method = method)
    }

  res_list
}
