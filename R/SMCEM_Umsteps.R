SMCEM_Umsteps=function (Y,mu,Sigma,df, nob,K,e){
  n=nrow(Y)
  p=ncol(Y)
  muchain=matrix(rep(NA,p*K),nrow=K)
  dfchain=c()
  SigmaChain=array(rep(NA,p*p*K),dim = c(p,p,K))
  YChain=array(rep(NA,n*p*K),dim = c(n,p,K))
  EDD=matrix(rep(0,n*p),nrow = n)

  for (k in 1:K)
  {
    if(k%%100==0){print(k)}
    GH=suppressWarnings(SMCEM_Uonestep(Y,mu,Sigma, df,nob))

    mu=muchain[k,]=GH$mu
    df=dfchain[k]=GH$df
    YChain[,,k]=GH$Y2
    Sigma= SigmaChain[,,k]=GH$Sigma
    EDD=EDD+GH$Y2
  }
  IMP=(1/K)*EDD
  Y2=GH$Y2

  return(list(Y2=Y2,IMP=IMP,mu=mu,Sigma=Sigma,df=df,YChain=YChain,muchain=muchain,SigmaChain=SigmaChain,
              dfchain=dfchain))
}
