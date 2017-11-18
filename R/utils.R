construct <- function(x){
  x$totalResults <- nrow(x[["posts"]])
  attr(x, "hidden") <- c("posts", "next")
  structure(x, class = "webhoser")
}

appendWebhose <- function(x1, x2){
  x2[["posts"]] <- plyr::rbind.fill(x2[["posts"]], x1[["posts"]])
  construct(x2)
}
