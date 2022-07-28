geocache
================

In a way, this is a silly R package. It’s a wrapper around the very
useful [rappdirs package](https://CRAN.R-project.org/package=rappdirs),
but with a some extra tools that are helpful for use with the [geodata
package](https://CRAN.R-project.org/package=geodata)

### Requirements

-   [R v4.1+](https://www.r-project.org/)

From CRAN

-   [rappdirs package](https://CRAN.R-project.org/package=rappdirs)

### Installation

    remotes::install_github("BigelowLab/geocache")

### Establish a initial directory for geodata

You can use the [geodata
package](https://CRAN.R-project.org/package=geodata) in such a way that
you request a fresh download each time establish a new R session. As an
alternative, you could download and save a local copy for retrieval and
use in subsequent sessions. There is a balance between saving too much
data locally and the convenience of locally stored data; each of us has
to find that balance.

Using [rappdirs](https://CRAN.R-project.org/package=rappdirs) allows you
to define either a personal data directory or a site-wide directory. See
`?rappdirs` for more details. I’m going to choose the default personal
directory.

> Note that you can choose an entirely different path unrelated to the
> ones provided by
> [rappdirs](https://CRAN.R-project.org/package=rappdirs). In that case,
> just save the path description in a hidden text file, `~/.geocache`,
> and things will work seamlessly.

``` r
library(geocache)
path <- geocache::geocache_path()
path
```

    ## [1] "~/Library/Application Support/geocache"

### Now get some geodata

The [geodata](https://CRAN.R-project.org/package=geodata) serves up a
wide variety of point, vector and raster. Let’s use the example of
future climate projections from
[CMIP6](https://esgf-node.llnl.gov/projects/cmip6/)

Since [geodata](https://CRAN.R-project.org/package=geodata) provides a
wide variety of data it might be good to organize the geocache with
subdirectories. Let’s start with one for `cmip6`.

``` r
cmip6_path <- file.path(path, 'cmip6')
if (!dir.exists(cmip6_path)) ok <- dir.create(cimp6_path)
```

Now let’s get some data and store it there…

``` r
x2021 <- geodata::cmip6_world(model = "CNRM-CM6-1", ssp = "585", 
                          res = 10, time = "2021-2040",
                          var = "bioc",
                          path = cmip6_path)

x2041 <- geodata::cmip6_world(model = "CNRM-CM6-1", ssp = "585", 
                          res = 10, time = "2041-2060",
                          var = "bioc",
                          path = cmip6_path)

x2061 <- geodata::cmip6_world(model = "CNRM-CM6-1", ssp = "585", 
                          res = 10, time = "2061-2080",
                          var = "bioc",
                          path = cmip6_path)
```

### Listing what you have

Use `list_geocache` to list the items you have stored.

``` r
# simple listing
list_geocache()
```

    ## [1] "cmip6"

``` r
# recursive listing
list_geocache(recursive = TRUE)
```

    ## [1] "cmip6/wc2.1_10m/wc2.1_10m_bioc_CNRM-CM6-1_ssp585_2021-2040.tif"
    ## [2] "cmip6/wc2.1_10m/wc2.1_10m_bioc_CNRM-CM6-1_ssp585_2041-2060.tif"
    ## [3] "cmip6/wc2.1_10m/wc2.1_10m_bioc_CNRM-CM6-1_ssp585_2061-2080.tif"
    ## [4] "cmip6/wc2.1_5m/wc2.1_5m_bioc_CNRM-CM6-1_ssp585_2061-2080.tif"

``` r
# full names within a subdirectory
list_geocache(cmip6_path, full.names = TRUE, recursive = TRUE)
```

    ## [1] "/Users/ben/Library/Application Support/geocache/cmip6/wc2.1_10m/wc2.1_10m_bioc_CNRM-CM6-1_ssp585_2021-2040.tif"
    ## [2] "/Users/ben/Library/Application Support/geocache/cmip6/wc2.1_10m/wc2.1_10m_bioc_CNRM-CM6-1_ssp585_2041-2060.tif"
    ## [3] "/Users/ben/Library/Application Support/geocache/cmip6/wc2.1_10m/wc2.1_10m_bioc_CNRM-CM6-1_ssp585_2061-2080.tif"
    ## [4] "/Users/ben/Library/Application Support/geocache/cmip6/wc2.1_5m/wc2.1_5m_bioc_CNRM-CM6-1_ssp585_2061-2080.tif"

### About CMIP6

There is a lot of info about
[CMPI6](https://esgf-node.llnl.gov/projects/cmip6/) with data
distribution [here](https://www.worldclim.org/). Some if it seems a bit
opaque to the new user. We have provided some functions to help navigate
the data lingo.

``` r
knitr::kable(SSP_metadata())
```

| code | SSP      | Scenario                                                                                                                   | Estimated warming (2041–2060) | Estimated warming (2081–2100) | Very likely range in °C (2081–2100) |
|:-----|:---------|:---------------------------------------------------------------------------------------------------------------------------|:------------------------------|:------------------------------|:------------------------------------|
| 119  | SSP1-1.9 | very low GHG emissions: CO2 emissions cut to net zero around 2050                                                          | 1.6 °C                        | 1.4 °C                        | 1.0 – 1.8                           |
| 126  | SSP1-2.6 | low GHG emissions: CO2 emissions cut to net zero around 2075                                                               | 1.7 °C                        | 1.8 °C                        | 1.3 – 2.4                           |
| 245  | SSP2-4.5 | intermediate GHG emissions: CO2 emissions around current levels until 2050, then falling but not reaching net zero by 2100 | 2.0 °C                        | 2.7 °C                        | 2.1 – 3.5                           |
| 370  | SSP3-7.0 | high GHG emissions: CO2 emissions double by 2100                                                                           | 2.1 °C                        | 3.6 °C                        | 2.8 – 4.6                           |
| 585  | SSP5-8.5 | very high GHG emissions: CO2 emissions triple by 2075                                                                      | 2.4 °C                        | 4.4 °C                        | 3.3 – 5.7                           |

``` r
knitr::kable(CMPI6_bioclim_metadata())
```

| name  | longname                                | unit                        |
|:------|:----------------------------------------|:----------------------------|
| bio1  | Mean annual temperature                 | NA                          |
| bio2  | Mean diurnal range                      | mean of max temp - min temp |
| bio3  | Isothermality                           | (bio2/bio7)\* 100           |
| bio4  | Temperature seasonality                 | standard deviation \*100    |
| bio5  | Max temperature of warmest month        | NA                          |
| bio6  | Min temperature of coldest month        | NA                          |
| bio7  | Temperature annual range                | bio5-bio6                   |
| bio8  | Mean temperature of the wettest quarter | NA                          |
| bio9  | Mean temperature of driest quarter      | NA                          |
| bio10 | Mean temperature of warmest quarter     | NA                          |
| bio11 | Mean temperature of coldest quarter     | NA                          |
| bio12 | Total (annual) precipitation            | NA                          |
| bio13 | Precipitation of wettest month          | NA                          |
| bio14 | Precipitation of driest month           | NA                          |
| bio15 | Precipitation seasonality               | coefficient of variation    |
| bio16 | Precipitation of wettest quarter        | NA                          |
| bio17 | Precipitation of driest quarter         | NA                          |
| bio18 | Precipitation of warmest quarter        | NA                          |
