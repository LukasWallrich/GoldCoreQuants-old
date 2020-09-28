# Test (pls ignore)


```r
library(dplyr)
mtcars %>% group_by(cyl) %>% summarise(mean(mpg))
```

```
## `summarise()` ungrouping output (override with `.groups` argument)
```

```r
sessionInfo()
```

```
## [90m# A tibble: 3 x 2[39m
##     cyl `mean(mpg)`
##   [3m[90m<dbl>[39m[23m       [3m[90m<dbl>[39m[23m
## [90m1[39m     4        26.7
## [90m2[39m     6        19.7
## [90m3[39m     8        15.1
## R version 4.0.2 (2020-06-22)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 18.04.5 LTS
## 
## Matrix products: default
## BLAS:   /usr/lib/x86_64-linux-gnu/openblas/libblas.so.3
## LAPACK: /usr/lib/x86_64-linux-gnu/libopenblasp-r0.2.20.so
## 
## locale:
##  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
##  [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
##  [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
## [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
##  [1] pacman_0.5.1    webex_0.9.1     forcats_0.5.0   stringr_1.4.0  
##  [5] dplyr_1.0.2     purrr_0.3.4     readr_1.3.1     tidyr_1.1.2    
##  [9] tibble_3.0.3    ggplot2_3.3.2   tidyverse_1.3.0
## 
## loaded via a namespace (and not attached):
##  [1] tidyselect_1.1.0 xfun_0.17        haven_2.3.1      colorspace_1.4-1
##  [5] vctrs_0.3.4      generics_0.0.2   htmltools_0.5.0  yaml_2.2.1      
##  [9] utf8_1.1.4       blob_1.2.1       rlang_0.4.7      pillar_1.4.6    
## [13] glue_1.4.2       withr_2.3.0      DBI_1.1.0        dbplyr_1.4.4    
## [17] modelr_0.1.8     readxl_1.3.1     lifecycle_0.2.0  munsell_0.5.0   
## [21] gtable_0.3.0     cellranger_1.1.0 rvest_0.3.6      evaluate_0.14   
## [25] knitr_1.30       fansi_0.4.1      broom_0.7.0      Rcpp_1.0.5      
## [29] scales_1.1.1     backports_1.1.10 jsonlite_1.7.1   fs_1.5.0        
## [33] hms_0.5.3        digest_0.6.25    stringi_1.5.3    bookdown_0.20   
## [37] grid_4.0.2       cli_2.0.2        tools_4.0.2      magrittr_1.5    
## [41] crayon_1.3.4     pkgconfig_2.0.3  ellipsis_0.3.1   xml2_1.3.2      
## [45] reprex_0.3.0     lubridate_1.7.9  assertthat_0.2.1 rmarkdown_2.3   
## [49] httr_1.4.2       rstudioapi_0.11  R6_2.4.1         compiler_4.0.2
```

