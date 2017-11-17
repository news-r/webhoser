#' @export
print.webhoserToken <- function(x, ...) {
  print("wehoser token", ...)
}

#' @export
print.webhoser <- function(x, ...) {
  hidden <- attr(x, "hidden")
  print(x[!names(x) %in% hidden], ...)
}
