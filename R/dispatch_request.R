#' Dispatch a HTTP request for Airtable API
#'
#' @param airtable An Airtable wrapper object
#' @param resource_id An optional length-one character vector. The default is NULL.
#' @param fields An optional list to dispatch(as JSON object)
#' @param method A length-one character vector. e.g "put", "patch", "post"
#' @param query An optional list
#' @return A request object

dispatch_request <- function(airtable, resource_id = NULL, fields = NULL, method, query = NULL) {

  do.call(
    toupper(method),
    compose_request_arguments(
      airtable, 
      resource_id, 
      fields, 
      method,
      query
    ),
    envir = loadNamespace("httr") 
  )

} 
