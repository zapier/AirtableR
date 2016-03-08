#' Get data from Airtable
#'
#' Get records from Airtable API then convert them into a list. 
#' @param path A length-one character vector. Path to a table in your Airtable account. e.g "appANrRXq7xaOU0dd/table_name"
#' @param query A list. Query string parameters. e.g list(page = 2)
#' @export

airtable_GET <- function(path, query = NULL) {
  req <- httr::GET(
    airtable_base_url(),
    path = file.path(
      airtable_api_version(), 
      path
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

  offset  <- httr::content(req)$offset
  records <- httr::content(req)$records

  # Append next page records recursively
  if (!is.null(offset)) {
    return(
      records <- append(records, airtable_GET(path, query = list(offset = offset)))
    )
  } 

  records
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
    "Couldn't find env var AIRTABLE_KEY 
    See ?airtable_key for more details."
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
