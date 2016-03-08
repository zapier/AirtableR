#' List records 
#'
#' List records or retreive a particular record by issuing GET request to a table/record endpoint
#' @param table_endpoint A length-one character vector. Path to a table in your Airtable account. e.g "appANrRXq7xaOU0dd/table_name"
#' @param query A list. Query string parameters. e.g list(page = 2)
#' @export

airtable_GET <- function(table_endpoint, record = NULL, query = NULL) { 

  req <- httr::GET(
    airtable_base_url(),
    path = airtable_endpoint(
      airtable_api_version(), 
      table_endpoint, 
      record
    ),
    query = query,
    httr::add_headers(
      Authorization = paste(
        "Bearer",
        airtable_key()
      )
    )
  ) 

  airtable_check(req)

  if (!is.null(record)) {
    return(httr::content(req))
  }

  offset  <- httr::content(req)$offset
  records <- httr::content(req)$records

  # recursively append next page records to `records` 
  if (!is.null(offset)) {
    return(
      records <- append(
        records, 
        airtable_GET(
          table_endpoint, 
          query = list(offset = offset)
        )
      )
    )
  } 

  records
}

airtable_endpoint <- function(...) {
  paste(..., sep = "/", collapse = NULL)
}

#' Create a new record 
#'
#' Create a new record by issuing POST request to a table endpoint 
#' @param table_endpoint A length-one character vector. Path to a table in your Airtable account. e.g "appANrRXq7xaOU0dd/table_name" 
#' @param fields A list
#' @export

airtable_POST <- function(table_endpoint, fields) {

  stopifnot(is.list(fields))

  req <- do.call(
    "POST", 
    request_arguments(table_endpoint, fields), 
    envir = loadNamespace("httr")
  )

  airtable_check(req)
  req
}


#' Update some(but not all) fields of a table record
#'
#' Update a table record by issuing a PATCH request to the record endpoint. 
#' Note that any fields that are not included will not be updated.
#'
#' @param record_endpoint A length-one character vector
#' @param fields A list
#' @export

airtable_PATCH <- function(record_endpoint, fields) {

  stopifnot(is.list(fields))

  req <- do.call(
    "PATCH", 
    request_arguments(record_endpoint, fields), 
    envir = loadNamespace("httr")
  )

  airtable_check(req)
  req
}


#' Update all fields of a table record
#'
#' Update a table record by issuing a PUT request to the record endpoint
#' Note that any fields that are not included will be cleared.
#'
#' @param record_endpoint A length-one character vector
#' @param fields A list
#' @export

airtable_PUT <- function(record_endpoint, fields) {

  stopifnot(is.list(fields))

  req <- do.call(
    "PUT", 
    request_arguments(record_endpoint, fields), 
    envir = loadNamespace("httr")
  )

  airtable_check(req)
  req
}


#' Get common arguments for POST, PATCH, PUT request
#' @param path
#' @param body

request_arguments <- function(path, body) {
  list(
    url = airtable_base_url(),
    path = file.path(
      airtable_api_version(),
      path
    ),
    body = list(fields = body),
    encode = "json",
    httr::add_headers(
      Authorization = paste(
        "Bearer",
        airtable_key()
      )
    )
  )
}


#' Get Airtable API base url

airtable_base_url <- function() {
  "https://api.airtable.com"
}


#' Get the version of Airtable API

airtable_api_version <- function() {
  "v0"
}


#' Get Airtable API key if exists
#' otherwise set Airtable API key
#' @param force A length-one logical vector
#' @return A length-one character vecotr 

airtable_key <- function(force = FALSE) {
  env <- Sys.getenv("AIRTABLE_KEY")
  if (!identical(env, "") && !force) return(env)
  if (!interactive()) {
    stop("Please enter env var AIRTABLE_KEY", call. = FALSE)
  }

  message(
    "Couldn't find env var AIRTABLE_KEY. See ?airtable_key for more details."
  )

  message(
    "Please enter your KEY and press enter:"
  )

  key <- readline(": ")

  if (identical(key, "")) {
    stop("Airtable API key entry failed", call. = FALSE)
  }
  
  message(
    "Updating AIRTABLE_KEY env var to key"
  )

  Sys.setenv(AIRTABLE_KEY = key)

  key
}


#' Check request status
#' @param req A httr request object 

airtable_check <- function(req) {
  if (req$status_code < 400) {
    return(invisible())
  }

  message <- 
    paste0(
      unname(
        airtable_parse(req)$error
      ), 
      ". "
    )

  stop(
    "HTTP failure: ", 
    req$status_code, 
    "\n",
    message,
    call. = FALSE
  )
}


#' Parse request
#' @param req A httr request object 

airtable_parse <- function(req) {
  text <- httr::content(req, as = "text")
  if (identical(text, "")) stop(
    "No output to parse",
    call. = FALSE
  )
  RJSONIO::fromJSON(text)
}
