#'\code{checkWeightObj}
#'
#'@param weightObj Weight object
#'
#'@return Error message in case of errors in the weights
#'
#'@export
#'

checkWeightObj <- function(weightObj = weightObj, netObj = netObj){
  
  nSpecies = unique(c(as.character(as.matrix(netObj)[, 1]), 
                      as.character(as.matrix(netObj)[, 3])))
  
  if (is.null(weightObj)) {
    weightObj = "NULL"
  } else {
    allowedClass = c("matrix", "data.frame")
    if(!(any(class(weightObj)%in%allowedClass))){
      stop("Weight object should either be of matrix or data.frame class")
    } else {
      if(ncol(weightObj)>0){
        mSpecies = colnames(weightObj)
        
        idx = which(mSpecies%in%nSpecies)
        idx2rem = setdiff(1:length(mSpecies), idx)
        
        if(length(idx2rem)==length(mSpecies)){
          stop("Something wrong with your weight object/network object. 
               No weighted node is present in the network. 
               You can set the weightObj to NULL.")
        } else {
          if(length(idx2rem)>0){
            if((nrow(weightObj)==1) && (class(weightObj)=="matrix")){
              weightObj = weightObj[, -idx2rem]
              weightObj = t(as.matrix(weightObj))
            } else {
              weightObj = weightObj[, -idx2rem]
            }
          }
        }
    } else {
      stop("Something wrong with your weight object. Please check or set it to 
           NULL.")
    }
  }
  }
  
  return(weightObj)
}