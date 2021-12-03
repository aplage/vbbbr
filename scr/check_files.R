# script to check which files were created after unzip

files_to_check <-
  map(
    estados %>% 
      select(sigla) %>% 
      unlist(),
    function(z){
      str_subset(
        dirs %>% 
          list.files(),
        paste0(
          "(?i)[^A-Za-z]",
          z,
          "[^A-Za-z]"
        )
      )
    }
  ) %>% 
  (function(nm){
    
    names(nm) <- estados %>% 
      select(sigla) %>% 
      unlist()
    
    nm
  }) %>% 
  map(
    .,
    ~sort(.x)
  )
