#' Compose request arguments
#'
#' \code{compose_request_arguments} composes \code{httr} request arguments as a list
#' @param airtable An Airtable wrapper object
#' @param resource_id An optional length-one character vector
#' @param fields An optional list
#' @param method A length-one character vector. e.g "put", "patch", ...
#' @param query An optional list
#' @return A list

compose_request_arguments <- function(airtable, resource_id = NULL, fields= NULL, method, query = NULL) {
  arguments <- list(
    url     = airtable$base_url,
    path    = compose_endpoint(airtable, resource_id),
    httr::add_headers(
      Authorization = paste(
        "Bearer",
        airtable_key()
      )
    ) 
  ) 

  if (toupper(method) %in% c("PUT", "PATCH", "POST")) {
    arguments <- append(
      arguments, 
      list(encode = "json")
    )
  }

  if (!is.null(fields)) {
    arguments <- append(
      arguments, 
      list(body = list("fields" = fields))
    )
  }

  if (!is.null(query) && !(length(query) == 0)) {
    arguments <- append(
      arguments,
      list(query = query)
    )
  }

  arguments
} 
