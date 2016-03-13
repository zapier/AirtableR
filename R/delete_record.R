#' Delete a record
#'
#' \code{delete_record} deletes a record by issuing DELETE request to a record endpoint.  
#' @param air_options A list 
#' @param table A length-one character vector
#' @param record_id A length-one character vector

delete_record <- 

  function(
    air_options, 
    table, 
    record_id
  ) {

    req <- dispatch_request(
      air_options,
      table,
      resource_id = record_id,
      method = "DELETE"
    )

    req 
  }
