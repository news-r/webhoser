# webhoser

![webhose.io](http://kinlane-productions.s3.amazonaws.com/api-evangelist-site/company/logos/webhose-io-logo.png)

* [Install](#install)
* [Function](#functions)
* [Examples](#examples)
* [Extension](#extension)

## Install

```r
devtools::install_git("http://chlxintgitl01.weforum.local/JCOE/webhoser",
  credentials = git2r::cred_user_pass('username', 'pwd'))
```

## Functions

* `wh_token` - setup token
* `wh_news` - Get news
* `wh_broadcasts` - Get broadcast transcripts
* `wh_paginate` - paginate
* `wh_collect` - collect results
* ~~`wh_date` - format dates returned~~ Moved to `webhoser.extension`

## Examples

``` r
token <- <- wh_token("xXX-x0X0xX0X-00X") # setup token

# webhoser object
token %>% 
  wh_news(q = '"World Economic Forum" is_first:true language:english site_type:news') -> news

# basic
# collect results
token %>% 
  wh_news(q = '"World Economic Forum"') %>% # get news
  wh_collect -> basic
  
# flatten results
token %>% 
  wh_news(q = '"World Economic Forum" OR WEF') %>% # get news
  wh_collect(TRUE) -> flat  # flatten results
  
# broadcasts
token %>% 
  wh_broadcasts('Davos AND WEF OR "World Economic Forum"') %>% 
  wh_paginate(p = 1) %>% 
  wh_collect() -> davos_broadcasts

# get three pages on the WEF.
# format dates
token %>%  
  wh_news(q = '"World Economic Forum" OR WEF') %>% 
  wh_paginate(3) %>% 
  wh_collect() %>% 
  dplyr::mutate(published = wh_date(published)) -> wef
```

## Extension

See [webhoser.extension](http://chlxintgitl01.weforum.local/JCOE/webhoser.extension) package for utility functions to extract features, format dates, and more.

Author and maintainer: <Jean-Philippe.Coene@weforum.org>
