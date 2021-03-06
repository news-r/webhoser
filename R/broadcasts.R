#' Get broadcasts
#'
#' Get access to structured transcripts data from broadcasts.
#'
#' @param token your token as returned by \code{\link{wh_token}}.
#' @param q a string query containing the filters that define which transcript lines will be returned.
#' @param ts The "ts" (timestamp) parameter is telling the system to return results that were
#' crawled after this timestamp (\code{POSIXct} or \code{POSIXlt}).
#' @param highlight return the fragments in the review that matched the textual Boolean query.
#' The matched keywords will be surrounded by \code{<em/>} tags.
#' @param latest this will return the latest 100 crawled posts matching your query (**NOT** recommended).
#' @param quiet if \code{FALSE} does not return useful information to console.
#'
#' @details
#' See \href{https://docs.webhose.io/docs/filters-reference-4}{official documentation} for valid filters.
#'
#' @examples
#' \dontrun{
#' token <- wh_token("xXX-x0X0xX0X-00X")
#'
#' rstats <- wh_broadcasts(token, q = '"R programming language"') %>%  # use quote marks!
#'   wh_collect()
#'
#' token %>%
#'   wh_broadcasts(token, q = 'Trump OR "US President"') %>%
#'   wh_paginate(p = 2) # 2 additional pages of results
#'   wh_collect() -> trump
#' }
#'
#' @export
wh_broadcasts <- function(token, q, ts = (Sys.time() - (3 * 24 * 60 * 60)), highlight = NULL,
                          latest = NULL, quiet = !interactive()){
  
  stop("This endpoint is no longer available", call. = FALSE)

  if(missing(q))
    stop("must pass q", call. = FALSE)

  if(!missing(token))
    warning("token is deprecated, there is no need for this argument")

  token <- wh_get_token(quiet)

  if(inherits(ts, "POSIXct")) ts <- paste0(as.character(as.numeric(ts) * 1000), '000')

  uri <- getOption("webhoser_base_url")
  uri <- paste0(uri, "/broadcastFilter")
  uri_parsed <- httr::parse_url(uri)

  uri_parsed$query <- list(
    token = token,
    format = "json",
    q = q,
    ts = ts,
    size = 10,
    highlight = highlight,
    latest = latest
  )
  uri_built <- httr::build_url(uri_parsed)

  response <- httr::GET(uri_built)

  httr::stop_for_status(response)

  content <- httr::content(response, as = "text", encoding = "UTF-8")
  content <- jsonlite::fromJSON(content, flatten = TRUE)

  if(!isTRUE(quiet))
    message(content$requestsLeft, "queries left.")

  construct(content)
}
