.onAttach <- function(libname = find.package("webhoser"), pkgname = "webhoser") {
  options(webhoser_base_url = "https://webhose.io")
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
