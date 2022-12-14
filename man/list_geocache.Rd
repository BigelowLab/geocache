% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/path.R
\name{list_geocache}
\alias{list_geocache}
\title{List files/directories in the geochache root directory}
\usage{
list_geocache(path = geocache_root(), ...)
}
\arguments{
\item{path}{char, the path to list}

\item{...}{arguments passed to \code{\link[base]{list.files}}}
}
\value{
character vector
}
\description{
This is a wrapper around \code{\link[base]{list.files}}
}
