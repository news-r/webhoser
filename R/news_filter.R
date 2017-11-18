#' Get news
#'
#' Get access to structured posts data from news articles, blog posts and online discussions.
#'
#' @param token your token as returned by \code{\link{wh_token}}.
#' @param q a string query containing the filters that define which posts will be returned.
#' @param ts The "ts" (timestamp) parameter is telling the system to return results that were
#' crawled after this timestamp (\code{POSIXct} or \code{POSIXlt}).
#' @param sort by default (when the sort parameter isn't specified)
#' the results are sorted by the recommended order of crawl date.
#' See details for valid values.
#' @param order If you choose to order the posts by any of the numeric \code{sort} values,
#' you can choose in what order you want to get them: \code{asc} (default) or \code{desc}.
#' @param accuracy return only posts with high extraction accuracy, but removes about 30% of
#' the total matching posts (with lower confidence).
#' @param highlight return the fragments in the post that matched the textual Boolean query.
#' The matched keywords will be surrounded by \code{<em/>} tags.
#' @param latest this will return the latest 100 crawled posts matching your query (NOT recommended).
#' @param quiet if \code{FALSE} does not return useful information to console.
#'
#' @details
#' Valid sort values
#' \itemize{
#'   \item{relevancy}
#'   \item{social.facebook.likes}
#'   \item{social.facebook.shares}
#'   \item{social.facebook.comments}
#'   \item{social.gplus.shares}
#'   \item{social.pinterest.shares}
#'   \item{social.linkedin.shares}
#'   \item{social.stumbledupon.shares}
#'   \item{social.vk.shares}
#'   \item{replies_count}
#'   \item{participants_count}
#'   \item{spam_score}
#'   \item{performance_score}
#'   \item{published}
#'   \item{thread.published}
#'   \item{domain_rank}
#'   \item{ord_in_thread}
#'   \item{rating}
#' }
#'
#' @examples
#' \dontrun{
#' token <- wh_token("xXX-x0X0xX0X-00X")
#'
#' barack <- wh_news_filter(token, q = "Barack Obama")
#' }
#'
#' @export
wh_news_filter <- function(token, q, ts = Sys.time() - (3 * 24 * 60 * 60), sort = NULL, order = NULL,
                      accuracy = NULL, highlight = NULL, latest = NULL,
                      quiet = FALSE){

  if(missing(token) || missing(q))
    stop("must pass token and q", call. = FALSE)

  uri <- getOption("webhoser_base_url")
  uri <- paste0(uri, "/filterWebContent")
  uri_parsed <- httr::parse_url(uri)

  uri_parsed$query <- list(
    token = token,
    format = "json",
    q = q,
    sort = sort,
    ts = as.numeric(ts),
    order = order,
    size = 100,
    accuracy_confidence = accuracy,
    highlight = highlight,
    latest = latest
  )

  uri_built <- httr::build_url(uri_parsed)

  response <- httr::GET(uri_built)

  httr::stop_for_status(response)

  content <- httr::content(response, as="text", encoding = "UTF-8")
  content <- jsonlite::fromJSON(content, flatten=TRUE)

  if(!isTRUE(quiet))
    message(content$requestsLeft, "queries left.")

  construct(content)
}
