library(tidyverse)

dirs <-
  list.dirs(
    path =  here::here("data",
                       "raw", 
                       "zip_files"), 
    recursive = FALSE) %>% 
    str_match(., ".*/201[789]$") %>% 
    .[!is.na(.)] %>%
    list.dirs(
      recursive = FALSE)
  


map(
  1:length(dirs),
  function(uz){
    
    unzip(
      zipfile = dirs[uz] %>% 
        list.files(full.names = TRUE),
      exdir = dirs[uz],
      junkpaths = TRUE
      
    )
  }
)

## Code for selecting MG

# dirs %>% 
#   map(list.files,
#       full.names = TRUE) %>% 
#   map(str_match, 
#       ".*[mM][gG].*") %>% 
#   map(function(x){
#     x[!is.na(x)]
#     }) %>% 
#   map(
#     function(c){
#       if(
#         sum(
#           str_detect(c, 
#                      "Ret")) == 1){
#         c[str_detect(c,
#                      "Ret")]
#         } else if(
#           sum(
#             str_detect(c, 
#                        "Ret")) == 2){
#           c[str_detect(c, 
#                         "Ret_Ret")]
#           } else {c}}) %>% 
#   map(
#     function(n){
#       
#       # readxl::read_xlsx(
#       #   path = n,
#       #   sheet = "BRUC VACINA",
#       #   headr = TRUE,
#       #   range = "A:T"
#         
#       str_match(n,
#                 "(201[789]_[12])|_([12] 2019)") %>% 
#         paste("mg",
#               # .[1],
#               sep = "_") %>% 
#         .[1] %>% 
#         map(
#           function(z){
#             if(
#               str_detec(z,
#                         "^_1"){
#               ,
#               "2019_1_mg"}
#               
#               )
#           }
#         )
#      
#       
#       # )
#       
#     }
#     
#   )










walk(
  list.files(
      pattern = "(201[789].*|1 .+| 2)\\.zip",
      recursive = TRUE),
  ~ unzip(
    .x,
    exdir = here::here("data",
                       "raw",
                       "old")
    ))
#)

possibly_read <- 
  possibly(
    .f = readxl::read_xlsx,
    otherwise = NULL
  )

dados_2017_19 <-
  map(
    list.files(
      # path = 
      #   here::here(
      #     "data",
      #     "raw",
      #     "old"
      #     ),
      pattern = "^Inf_semestral_PNCEBT.+\\.xlsx",
      recursive = TRUE),
    ~ possibly_read(
        .x,
        sheet = "BRUC VACINA",
        range = cellranger::cell_cols("A:T")
      )
    ) %>% 
  (function(n){
    names(n) <-
      list.files(
          # path = 
          #   here::here(
          #     "data",
          #     "raw",
          #     "old"
          #   ),
        pattern = "^Inf_semestral_PNCEBT.+\\.xlsx",
        recursive = TRUE) %>% 
          str_extract("[A-Z]{2}_20[0-2]{1}[0-9]{1}_[0-2]{1,2}(-retificado)*")
    n
  })

  
  
# dados_2017_19 <-
  map_dfr(
    list.files(
      # path = 
      #   here::here(
      #     "data",
      #     "raw",
      #     "old"
      #     ),
      pattern = "^Inf_semestral_PNCEBT.+\\.xlsx",
      recursive = TRUE),
    ~ {
      .x %>% 
        readxl::excel_sheets(x)[readxl::excel_sheets(x) %>%
                                  str_detect("BRUC VACINAS{0,1}")] %>% 
        possibly_read(
          path = .x,
          sheet = .,
          range = cellranger::cell_cols("A:T")
        )
    }
      ) %>% 
  (function(n){
    names(n) <-
      list.files(
        # path = 
        #   here::here(
        #     "data",
        #     "raw",
        #     "old"
        #   ),
        pattern = "^Inf_semestral_PNCEBT.+\\.xlsx",
        recursive = TRUE) %>% 
      str_extract("[A-Z]{2}_20[0-2]{1}[0-9]{1}_[0-2]{1,2}(-retificado)*")
    n
  })

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
xxx[[3]] %>%
  (function(xx){
    if(
      str_detect(xx, 
                 "Ret") %>% 
      sum() %>% 
      . == 1)  {
      xx[str_detect(xx, 
                     "Ret")]
      } else if(
        str_detect(xx, 
                   "Ret") %>% 
        sum() %>% 
        . == 2) {
        xx[str_detect(xx, 
                       "Ret_Ret")]
      } else {xx}
      
  }
  )
                                                             
                                                             
 #############################

# Import estados

estados <-
  read.table(
    here::here(
      "data",
      "raw",
      "estados.csv"
    ),
    header = TRUE,
    sep = ",")
