#'\code{writeLPFile}
#'
#' Write a list of linear programming (LP) constraints into a file while will be 
#' read by interactive cplex solver to perform network optimisation.
#'

writeLPFile <- function(data = data, pknList = pknList, inputs = inputs, 
                        alphaWeight=1, betaWeight=0.2, scores=scores, 
                        mipGAP=0.1, poolrelGAP=0.01, limitPop=100, poolCap=100, 
                        poolIntensity=0, poolReplace=2,timelimit=1800,
                        measWeights=NULL, repIndex, condition="") {
  
  dataMatrix <- buildDataMatrix(data = data, pknList = pknList, inputs = inputs)
  variables <- create_variables_all(pknList = pknList, dataMatrix = dataMatrix)
  oF <- write_objective_function_all(dataMatrix = dataMatrix, 
                                     variables = variables, 
                                     alphaWeight = alphaWeight, 
                                     betaWeight = betaWeight, scores=scores, 
                                     measWeights=measWeights)
  bounds <- write_boundaries(variables = variables, oF=oF)
  binaries <- write_binaries(variables = variables)
  generals <- write_generals(variables = variables, oF = oF)
  c0 <- write_constraints_objFunction_all(variables = variables, 
                                          dataMatrix = dataMatrix)
  c1 <- write_constraints_1_all(variables = variables)
  c2 <- write_constraints_2_all(variables = variables)
  c3 <- write_constraints_3_all(variables = variables)
  c4 <- write_constraints_4_all(variables = variables)
  c5 <- write_constraints_5_all(variables = variables)
  c6 <- write_constraints_6(variables = variables, dataMatrix = dataMatrix, 
                            inputs = inputs)
  c7 <- write_constraints_7(variables = variables, dataMatrix = dataMatrix, 
                            inputs = inputs)
  c8 <- write_constraints_8(variables = variables, inputs = inputs, 
                            pknList = pknList)
  c9 <- write_loop_constraints(variables = variables, pknList = pknList, 
                               inputs = inputs)
  allC <- all_constraints_wLoop(c0 = c0, c1 = c1, c2 = c2, c3 = c3, c4 = c4, 
                                c5 = c5, c6 = c6, c7 = c7, c8 = c8, c9 = c9)

  writeSolverFiles(condition=condition, repIndex=repIndex, oF=oF,
                   allC=allC, bounds=bounds, binaries=binaries,
                   generals=generals, mipGAP=mipGAP, 
                   poolrelGAP=poolrelGAP, poolReplace=poolReplace,
                   limitPop=limitPop, poolCap=poolCap,
                   poolIntensity=poolIntensity, timelimit=timelimit)

  return(variables)
}
