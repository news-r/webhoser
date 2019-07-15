[![Build Status](https://travis-ci.org/news-r/webhoser.svg?branch=master)](https://travis-ci.org/news-r/webhoser)

# webhoser

<img src = "/man/figures/logo.png" align = "right" />

An R wrapper to the [webhose.io](https://webhose.io/) API.

- [webhoser](#webhoser)
  - [Install](#Install)
  - [Functions](#Functions)
  - [Setup](#Setup)
  - [Examples](#Examples)

## Install

```r
# install.packages("remotes")
remotes::install_github("news-r/webhoser")
```

## Functions

* `wh_token` - Setup token (see [webhose.io](https://webhose.io/))
* `wh_news` - Get news
* `wh_reviews` - Get reviews
* `wh_broadcasts` - Get broadcast transcripts ~~no longer available~~
* `wh_paginate` - Paginate
* `wh_collect` - Collect results
* `wh_date` - Format dates returned

## Setup

1. Visit [webhose.io](https://webhose.io/)
2. Visit your [dashboard](https://webhose.io/dashboard).
3. Use the "Active API Key" at the bottom with `wh_token`.

## Examples

Visit the [website](https://webhoser.news-r.org/) for a more thorough example.

```r
wh_token("xXX-x0X0xX0X-00X") # setup token

# webhoser object
wh_news(q = '"R programming language" is_first:true language:english site_type:news') -> news

# basic
# collect results
wh_news(q = '"R programming language"') %>% # get news
  wh_collect -> basic
  
# flatten results
wh_news(q = '"R programming language" OR rstats') %>% # get news
  wh_collect(TRUE) -> flat  # flatten results

# get three pages on the rstats
# format dates
wh_news(q = '"R programming language" OR rstats') %>% 
  wh_paginate(3) %>% 
  wh_collect() %>% 
  dplyr::mutate(published = wh_date(published)) -> rstats
```
