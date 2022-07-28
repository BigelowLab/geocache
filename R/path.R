#' Create or retrieve the root data directory
#' 
#' First search for ~/.geocache whihc may contain the desired path
#' If absent search for rappdirs::user_data_dir("geocache")
#' If absent search for rappdirs::site_data_dir("geocache")
#' If absent create the path specified by new_dir argument
#' 
#' If you want to specify a non-rappdirs standard path, then create a
#' ~/.geocache file with one line specifying the desired data path. You must
#' create this path yourself.
#' 
#' @export
#' @param new_dir char, used to create a new directory the first time this is
#'   run
#' @return the root data path
geocache_root <- function(new_dir = rappdirs::user_data_dir("geocache")){
  if (file.exists("~/.geocache")){
    root <- readLines("~/.geocache")
  } else if(dir.exists(rappdirs::user_data_dir("geocache"))){
    root <- rappdirs::user_data_dir("geocache")
  } else if (dir.exists(rappdirs::site_data_dir("geocache"))){
    root <- rappdirs::site_data_dir("geocache")
  } else {
    ok <- dir.create(new_dir[1], recursive = TRUE)
    root <- new_dir[1]
  }
  root
}

#' Retrieve the geocache data path
#' 
#' @export
#' @param ... char, path segments
#' @param root char, the root directory specification
#' @return path specification, untestes for existence
geocache_path <- function(..., root = geocache_root()){
  file.path(root[1], ...)
}


#' List files/directories in the geochache root directory
#' 
#' This is a wrapper around \code{\link[base]{list.files}}
#' @export
#' @param path char, the path to list
#' @param ... arguments passed to \code{\link[base]{list.files}}
#' @return character vector
list_geocache <- function(path = geocache_root(), ...){
  list.files(path, ...)
}
