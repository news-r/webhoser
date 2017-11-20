#' format date
#'
#' Format dates returned by API, see details.
#'
#' @param date date column, see examples.
#'
#' @details Webhose's servers are in Israel, this is used as timezone.
#'
#' @return vector of class \code{POSIXct}.
#'
#' @examples
#' \dontrun{
#' token <- wh_token("xXX-x0X0xX0X-00X")
#'
#' wef <- wh_news(token, q = '"World Economic Forum"') %>%  # use quote marks!
#'   wh_collect() %>%
#'   dplyr::mutate(published = wh_date(published))# collect results
#' }
#'
#' @export
wh_date <- function(date){
  as.POSIXct(date, "%Y-%m-%dT%H:%M:%S%OS+03:00", tz = "Israel")
}
