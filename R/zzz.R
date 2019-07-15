.onAttach <- function(libname = find.package("webhoser"), pkgname = "webhoser") {
  options(webhoser_base_url = "https://webhose.io")
  token <- Sys.getenv("WEBHOSER_TOKEN")
  msg <- "Token loaded!"
  if(nchar(token) <= 1)
    msg <- "Token not found, see `wh_token`"

  token <- structure(trimws(token), class = "webhoserToken")
  Sys.setenv("WEBHOSER_TOKEN" = token)
  packageStartupMessage(msg)
}

.onLoad <- function(libname = find.package("webhoser"), pkgname = "webhoser") {
  options(webhoser_base_url = "https://webhose.io")
}

.onUnload <- function(libpath = find.package("webhoser")) {
  options(webhoser_base_url = NULL)
}

.onDetach <- function(libpath = find.package("webhoser")) {
  options(webhoser_base_url = NULL)
}
