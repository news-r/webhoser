#' Setup webhose token
#'
#' @param token your token, see details.
#'
#' @details
#' \enumerate{
#'   \item{Create a \href{https://webhose.io}{webhose.io} account.}
#'   \item{Visit your \href{https://webhose.io/dashboard}{dashboard}.}
#'   \item{Use the "Active API Key" at the bottom as \code{token} parameter.}
#' }
#'
#' @examples
#' token <- wh_token("xXX-x0X0xX0X-00X")
#'
#' @export
wh_token <- function(token){
  structure(trimws(token), class = "webhoserToken")
}
