#' Retrieve a table of SSP metadata
#' 
#' @seealso \href{https://en.wikipedia.org/wiki/Shared_Socioeconomic_Pathways}{Shared Socioeconomic Pathways}
#' @export
#' @return tibble of SSP metadata
SSP_metadata <- function(){
  uri <- "https://en.wikipedia.org/wiki/Template:AR6_SSP_table"
  x <- rvest::read_html(uri) |>
    rvest::html_elements("body") |> 
    rvest::html_table() 
  x <- x[[1]]
  ssp <- x$SSP
  ssp <- regmatches(ssp, gregexpr("[[:digit:]]+", ssp)) |>
    sapply( function(x) paste(x,collapse = ""), simplify = FALSE) |>
    unlist()
  x |> dplyr::mutate(x, code = ssp, .before = 1)
  }


#' Retrieve the CMIP6 variable metadata
#' 
#' @export
#' @seealso \href{https://www.worldclim.org/data/bioclim.html}{BioClim}
#' @return a tibble of metadata
CMPI6_metadata <- function(){
 dplyr::tribble(
    ~name,  ~longname,                                                    ~unit,
    'bio1', 'Mean annual temperature',                            NA_character_,
    'bio2', 'Mean diurnal range',                 'mean of max temp - min temp',
    'bio3', 'Isothermality',                                 '(bio2/bio7)* 100',
    'bio4', 'Temperature seasonality',                'standard deviation *100',
    'bio5', 'Max temperature of warmest month',                   NA_character_, 
    'bio6', 'Min temperature of coldest month',                   NA_character_,
    'bio7', 'Temperature annual range',                             'bio5-bio6',
    'bio8', 'Mean temperature of the wettest quarter',            NA_character_,
    'bio9', 'Mean temperature of driest quarter',                 NA_character_,
    'bio10', 'Mean temperature of warmest quarter',               NA_character_,
    'bio11', 'Mean temperature of coldest quarter',               NA_character_,
    'bio12', 'Total (annual) precipitation',                      NA_character_,
    'bio13', 'Precipitation of wettest month',                    NA_character_,
    'bio14', 'Precipitation of driest month',                     NA_character_,
    'bio15', 'Precipitation seasonality',            'coefficient of variation',
    'bio16', 'Precipitation of wettest quarter',                  NA_character_,
    'bio17', 'Precipitation of driest quarter',                   NA_character_,
    'bio18', 'Precipitation of warmest quarter',                  NA_character_)
}
