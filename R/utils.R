construct <- function(x){
  x[["totalResults"]] <- nrow(x[["posts"]]) # totalResults
  attr(x, "hidden") <- c("posts", "next") # hide for print

  x[["posts"]] <- clean_posts(x[["posts"]])

  structure(x, class = "webhoser") # webhoser object init
}

appendWebhose <- function(x1, x2){
  x2[["posts"]] <- plyr::rbind.fill(x2[["posts"]], x1[["posts"]])
  construct(x2)
}

clean_posts <- function(x){
  x[["published"]] <- as.POSIXct(x[["published"]],
                                 "%Y-%m-%dT%H:%M:%S%OS+03:00",
                                 tz = "Israel")
  x
}
