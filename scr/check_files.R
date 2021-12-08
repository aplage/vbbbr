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
    
    names(nm) <- 
      estados %>% 
      select(sigla) %>% 
      unlist()
    
    nm
  }) %>% 
  map(
    .,
    ~sort(.x)
  )

# Theoretically we should have 6 files per state, therefore to further check the 
# files we are selecting the states that presented different number of files per state

files_to_check[
  files_to_check %>% 
    map(length) %>% 
    bind_rows() %>%
    t() %>% 
    as.data.frame() %>% 
    filter(V1 != 6) %>% 
    rownames_to_column() %>% 
    rename(estado = rowname) %>% 
    select(estado) %>% 
    unlist()
  ]
