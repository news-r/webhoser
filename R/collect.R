#' Collect results
#'
#' Collect results from \code{webhoser} object.
#'
#' @param wh object of class \code{webhoser} as returned by \code{\link{wh_news}}.
#' @param flatten whether to flatten the collected results
#'
#' @details \code{flatten} ignores sentiment of entities.
#'
#' @return nested \code{data.frame} if \code{flatten = FALSE}. See
#' \href{https://docs.webhose.io/v1.0/docs/output-reference}{official documentation}
#'
#' @examples
#' \dontrun{
#' token <- <- wh_token("xXX-x0X0xX0X-00X")
#'
#' token %>%
#'   wh_news(q = "World Economic Forum") %>%
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
wh_collect.webhoser <- function(wh, flatten = FALSE){

  if(length(wh[["posts"]])){
    res <- wh[["posts"]]

    if(isTRUE(flatten)){
      res$external_links <- res$external_links %>%
        purrr::map_chr(paste, collapse = " ")

      res$thread.site_categories <- res$thread.site_categories %>%
        purrr::map_chr(paste, collapse = " ")
    }
  } else {
    res <- wh[["items"]]
  }

  if(isTRUE(flatten)){
    res$entities.locations <- res$entities.locations %>%
      purrr::map_chr(function(x){
        paste0(x$name, collapse = ",")
      })

    res$entities.organizations <- res$entities.organizations %>%
      purrr::map_chr(function(x){
        paste0(x$name, collapse = ",")
      })

    res$entities.persons <- res$entities.persons %>%
      purrr::map_chr(function(x){
        paste0(x$name, collapse = ",")
      })
	}

	if (length(res) == 0)
		res <- data.frame()

  res
}
