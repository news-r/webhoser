# webhoser

![webhose.io](http://kinlane-productions.s3.amazonaws.com/api-evangelist-site/company/logos/webhose-io-logo.png)

## Function

* `wh_token` - setup token
* `wh_news` - Get news
* `wh_broadcasts` - Get broadcast transcripts
* `wh_paginate` - paginate
* `wh_collect` - collect results
* `wh_date` - format dates returned

## Examples

``` r
token <- <- wh_token("xXX-x0X0xX0X-00X") # setup token

# basic
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

# get three pages on Barack Obama.
# format dates
token %>%  
  wh_news(q = '"World Economic Forum" OR WEF') %>% 
  wh_paginate(3) %>% 
  wh_collect() %>% 
  dplyr::mutate(published = wh_date(published)) -> wef
```
