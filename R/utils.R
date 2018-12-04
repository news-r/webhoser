construct <- function(x){

  if(length(x[["posts"]])){
    x[["totalResults"]] <- nrow(x[["posts"]]) # totalResults
    attr(x, "hidden") <- c("posts", "next") # hide for print
    x[["remainingPages"]] <- ceiling(x[["webhoser_data"]]/100)

  } else if (length(x[["items"]])){
    x[["totalResults"]] <- nrow(x[["items"]]) # totalResults
    attr(x, "hidden") <- c("items", "next") # hide for print
    x[["remainingPages"]] <- ceiling(x[["webhoser_data"]]/10)
  }

  structure(x, class = "webhoser") # webhoser object init
}

appendWebhose <- function(x1, x2){
  if(length(x1[["posts"]])){
    x2[["posts"]] <- plyr::rbind.fill(x2[["posts"]], x1[["posts"]])
  } else if (length(x1[["items"]])){
    x2[["items"]] <- plyr::rbind.fill(x2[["items"]], x1[["items"]])
  }
  construct(x2)
}

check_results <- function(wh, p, quiet = FALSE){

  rez <- ifelse(names(wh)[1] == "items", 10, 100)

  max <- ceiling(wh$moreResultsAvailable / rez)

  if(p > max){
    cat(
      crayon::yellow(cli::symbol$play),
      "Crawling", max, "page(s)\n"
    )
    pages <- max
  } else {
    pages <- p
  }

  pages
}
