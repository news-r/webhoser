#' Paginate
#'
#' Paginate through query.
#'
#' @param wh object of class \code{webhoser} as returned by \code{\link{wh_news}}.
#' @param p number of pages defaults to \code{Inf}.
#' @param quiet if \code{FALSE} does not return useful information to console.
#'
#' @return object of class \code{webhoser}
#'
#' @examples
#' \dontrun{
#' token <- <- wh_token("xXX-x0X0xX0X-00X")
#'
#' token %>%
#'   wh_news(q = "World Economic Forum") %>%
#'   wh_paginate(p = 3) -> Wef
#' }
#'
#' @importFrom methods new
#' @rdname wh_paginate
#' @export
wh_paginate <- function(wh, p = Inf, quiet = !interactive()) UseMethod("wh_paginate")

#' @rdname wh_paginate
#' @method wh_paginate webhoser
#' @export
wh_paginate.webhoser <- function(wh, p = Inf, quiet = !interactive()){

  if(!isTRUE(quiet) && is.infinite(p))
    warning("infinite paging", call. = FALSE)

  crawled <- 1 # track crawled page

  while(length(wh$`next`) && crawled <= p){

    uri <- paste0(getOption("webhoser_base_url"), wh$`next`) # build url

    response <- httr::GET(uri) # GET response

    httr::stop_for_status(response) # check for errors

    content <- httr::content(response, as="text", encoding = "UTF-8")
    content <- jsonlite::fromJSON(content, flatten=TRUE)

    wh <- appendWebhose(wh, content) # append

    crawled <- crawled + 1

    if(!isTRUE(quiet))
      message(content$requestsLeft, "queries left.")
  }

  wh
}
