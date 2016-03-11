#' Dispatch a HTTP request for Airtable API
#'
#' @param air_options A list 
#' @param table A length-one character vector
#' @param resource_id An optional length-one character vector. The default is NULL.
#' @param fields An optional list to dispatch(as JSON object)
#' @param method A length-one character vector. e.g "put", "patch", "post"
#' @param query An optional list
#' @return A request object

dispatch_request <- function(air_options, table, resource_id = NULL, fields = NULL, method, query = NULL) {

  do.call(
    toupper(method),
    compose_request_arguments(
      air_options,
      table,
      resource_id, 
      fields, 
      method,
      query
    ),
    envir = loadNamespace("httr") 
  )

} 
