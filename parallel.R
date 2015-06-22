#sfc.param<-function(modelfile, paramfile){

#start time
strt<-Sys.time()
model<-sfc.model("art.txt")
#modeldata<-simulate(model)
where<-c(model$variables[,"name"]) #creates vector of variables' names
#par<-read.table("art1.txt", header=FALSE,sep=",")
par<-read.table("art1.txt")
#search for number of row (ind) for parameter. Necessary for sfc.editVar function
ind<-match(par[,1],where)
#initialise all parameters with appropriate values of lowerBound
model$variables[,"initial value"][ind[1]:(ind[1]+length(ind)-1)]<-par[,2]

#initialise vector of parameters
p<-list(seq(par[1,2],par[1,3],par[1,4]))
for (i in 1:nrow(par)){
  p[i]<-list(c(seq(par[i,2],par[i,3],par[i,4]))) #creates one list of values of consecutive parameters
}
combinations<-expand.grid(p)  #creates matrix of combinations
colnames(combinations)<-par[,1] #parameters are in columns, combinations in rows

#creates matrix of results
results<-matrix(0,nrow=nrow(par)+2,ncol=nrow(combinations))  
row.names(results)<-c(as.character(par[,1]),"Difference","Stable from")
#first loop changes rows in combinations
for (i in 1:nrow(combinations)){
  
  #second loop picks values in row in combination and creates a new model with new combination of parameters
  model$variables[,"initial value"][ind[1]:(ind[1]+length(ind)-1)]<-as.numeric(combinations[i,])
  
  results[1:nrow(par),i]<-model$variables[,"initial value"][ind[1]:(ind[1]+length(ind)-1)]
}

do <- function (...){
  
  model$variables[,"initial value"][ind[1]:(ind[1]+length(ind)-1)]<-as.numeric(...)
  modeldata<-simulate(model) #simulates model with new set of variables 
  
}

# rezultaty<-apply (results,2,do)

library(parallel)
cl<-makeCluster(detectCores()-1)
clusterEvalQ(cl,library(PKSFC))
# clusterApply(cl, model<-sfc.model("art.txt"))
# clusterEvalQ(cl, ind)
clusterExport(cl,"model")
clusterExport(cl,"ind")
rezultaty<-parLapply (cl,results,do)
stopCluster(cl)