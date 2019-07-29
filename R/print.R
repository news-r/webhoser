#' @export
print.webhoserToken <- function(x, ...) {
  cat(crayon::blue("wehoser token"), ...)
}

#' @export
print.webhoser <- function(x, ...) {
  warn <- crayon::green
  sym <- cli::symbol$tick
  if(x$requestsLeft < 600){
    sym <- cli::symbol$warning
    color <- crayon::yellow
  }
  if(x$requestsLeft < 250){
    sym <- cli::symbol$cross
    color <- crayon::red
  }

  cat(warn(sym), x$requestsLeft, "Requests left\n")

  if(length(x$totalResults))
    cat(cli::symbol$pointer, crayon::blue(x$totalResults), "Articles collected\n")

  if(length(x$moreResultsAvailable))
    cat(cli::symbol$pointer, crayon::blue(x$moreResultsAvailable), "Articles still available\n")
}
