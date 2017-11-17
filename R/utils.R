construct <- function(x){
  x$totalResults <- length(x[["posts"]])
  attr(x, "hidden") <- c("posts", "next")
  structure(x, class = "webhoser")
}

appendWebhose <- function(x1, x2){
  x2[["posts"]] <- append(x2[["posts"]], x1[["posts"]])
  construct(x2)
}
