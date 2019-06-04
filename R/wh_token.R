#' Setup
#'
#' Specify token to be used in all subsequent calls.
#'
#' @param token your token, see details.
#' @param quiet if \code{FALSE} does not return useful information to console.
#' 
#' @note You can specify the \code{WEBHOSER_TOKEN} environment variable, likely in your code{.Renviron}.
#' 
#' @details
#' \enumerate{
#'   \item{Create a \href{https://webhose.io}{webhose.io} account.}
#'   \item{Visit your \href{https://webhose.io/dashboard}{dashboard}.}
#'   \item{Use the "Active API Key" at the bottom as \code{token} parameter.}
#' }
#'
#' @examples
#' wh_token("xXX-x0X0xX0X-00X")
#'
#' @name token
#' @export
wh_token <- function(token){
  if(missing(token))
    stop("Missing token")
  Sys.setenv("WEBHOSER_TOKEN" = token)
  token <- structure(trimws(token), class = "webhoserToken")
  invisible(token)
}

#' @name token
#' @export
wh_get_token <- function(quiet = !interactive()){
  token <- Sys.getenv("WEBHOSER_TOKEN")
  token <- structure(trimws(token), class = "webhoserToken")
  if(!quiet)
    cat(crayon::blue(cli::symbol$info), "Token returned invisibly\n")
  invisible(token)
}