#' Paginate
#'
#' Paginate through query.
#'
#' @param wh object of class \code{webhoser} as returned by \code{\link{wh_news_filter}}.
#' @param p number of pages defaults to \code{Inf}.
#' @param quiet if \code{FALSE} does not return useful information to console.
#'
#' @examples
#' \dontrun{
#' token <- <- wh_token("xXX-x0X0xX0X-00X")
#'
#' token %>%
#'   wh_news_filter(q = "Barack Obama") %>%
#'   wh_paginate(p = 3) -> barack
#' }
#'
#' @importFrom methods new
#' @rdname wh_paginate
#' @export
wh_paginate <- function(wh, p = Inf, quiet = FALSE) UseMethod("wh_paginate")

#' @rdname wh_paginate
#' @method wh_paginate webhoser
#' @S3method wh_paginate webhoser
wh_paginate.webhoser <- function(wh, p = Inf, quiet = FALSE){

  if(!isTRUE(quiet) && is.infinite(p))
    warning("infinite paging", call. = FALSE)

  crawled <- 1 # track crawled page

  while(length(wh$`next`) && crawled <= p){

    uri <- paste0(getOption("webhoser_base_url"), wh$`next`) # build url

    response <- httr::GET(uri) # GET response

    content <- httr::content(response) # parse response

    wh <- appendWebhose(wh, content) # append

    crawled <- crawled + 1

    if(!isTRUE(quiet))
      message(content$requestsLeft, "queries left.")
  }

  wh
}
