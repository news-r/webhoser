# webhoser

![webhose.io](http://kinlane-productions.s3.amazonaws.com/api-evangelist-site/company/logos/webhose-io-logo.png)

## Function

* `wh_token` - setup token
* `wh_news_filter` - Get news
* `wh_paginate` - paginate
* `wh_collect` - collect results

## Examples

``` r
token <- <- wh_token("xXX-x0X0xX0X-00X") # setup token

# basic
token %>% 
  wh_news(q = "World Economic Forum") %>% # get news
  wh_collect -> basic
  
# basic
token %>% 
  wh_news(q = "World Economic Forum") %>% # get news
  wh_collect(TRUE) -> flat  # flatten results

# get three pages on Barack Obama
token %>%  
  wh_news(q = '"World Economic Forum" OR WEF') %>% 
  wh_paginate(p = 3) %>% 
  wh_collect -> wef
```
