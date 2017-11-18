#' Collect results
#'
#' Collect results from \code{webhoser} object.
#'
#' @param wh object of class \code{webhoser} as returned by \code{\link{wh_news_filter}}.
#' @param flatten whether to flatten the collected results
#'
#' @details \code{flatten} ignores sentiment of entities
#'
#' @return nested \code{data.frame} if \code{flatten = FALSE}
#'
#' @examples
#' \dontrun{
#' token <- <- wh_token("xXX-x0X0xX0X-00X")
#'
#' token %>%
#'   wh_news_filter(q = "World Economic Forum") %>%
#'   wh_paginate(p = 1) %>%
#'   wh_collect -> Wef
#' }
#'
#' @rdname wh_collect
#' @export
wh_collect <- function(wh, flatten = FALSE) UseMethod("wh_collect")

#' @rdname wh_collect
#' @method wh_collect webhoser
#' @export
wh_collect.webhoser <- function(wh,flatten = FALSE){
  wh[["posts"]]
}
