#'\code{write_generals}
#'
#' This code writes all the variables.
#' 

write_generals <- function(variables=variables, oF=oF){
  
  generals <- c()
  
  for(i in 1:length(variables)){
    
    generals <- c(generals, 
                  paste0("\t", 
                         variables[[i]]$variables[variables[[i]]$idxNodes]))
    generals <- c(generals, 
                  paste0("\t", 
                         variables[[i]]$variables[variables[[i]]$idxB]))
    generals <- c(generals, 
                  paste0("\t",
                         unique(strsplit(oF, split = " ")[[1]][grep(
                           pattern = "absDiff", 
                           x = strsplit(oF, split = " ")[[1]])])))

  }
  
  return(generals)
  
}