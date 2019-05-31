[![Travis-CI Build Status](https://travis-ci.org/JohnCoene/webhoser.svg?branch=master)](https://travis-ci.org/JohnCoene/webhoser)

# webhoser

<img src = "/man/figures/logo.png" align = "right" />

An R wrapper to the [webhose.io](https://webhose.io/) API.

* [Install](#install)
* [Function](#functions)
* [Examples](#examples)
* [Get Started](http://webhoser.john-coene.com/)

## Install

```r
devtools::install_github("news-r/webhoser")
```

## Functions

* `wh_token` - Setup token (see [webhose.io](https://webhose.io/))
* `wh_news` - Get news
* `wh_broadcasts` - Get broadcast transcripts
* `wh_paginate` - paginate
* `wh_collect` - collect results
* `wh_date` - format dates returned

## Examples

```r
token <- wh_token("xXX-x0X0xX0X-00X") # setup token

# webhoser object
token %>% 
  wh_news(q = '"R programming language" is_first:true language:english site_type:news') -> news

# basic
# collect results
token %>% 
  wh_news(q = '"R programming language"') %>% # get news
  wh_collect -> basic
  
# flatten results
token %>% 
  wh_news(q = '"R programming language" OR rstats') %>% # get news
  wh_collect(TRUE) -> flat  # flatten results

# get three pages on the rstats
# format dates
token %>%  
  wh_news(q = '"R programming language" OR rstats') %>% 
  wh_paginate(3) %>% 
  wh_collect() %>% 
  dplyr::mutate(published = wh_date(published)) -> wef
```
