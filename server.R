###########################################################################
##### Simulation of Truncated Standard Gaussian Distribution - ui.R  #####
##########################################################################

library(shiny) 

## Algorithm 1 ##
fTGauss1=function(a,N) #a=TruncationParameter (a>=1), N=Number Simulations
{
 X=rep(0,N)
 for ( i in 1:N)
 {
  find=0
  while(find==0)
  {
   
   x=rexp(1,1/2)
   u=runif(1)
   if(u*sqrt(x)<= (as.numeric(sqrt(x)>=a)))
   {
    X[i]=sqrt(x)
    find=1
   }
  }
 }
 return(X)
}

## Algorithm 2 ##
fTGauss2=function(a,N) #a=TruncationParameter (a>=1), N=Number Simulations
{
 X=rep(0,N)
 for ( i in 1:N)
 {
  find=0
  while(find==0)
  {
   u1=runif(1)
   x=sqrt(a*a-2*log(1-u1))
   u2=runif(1)
   if(u2<= 1/x)
   {
    X[i]=x
    find=1
   }
  }
 }
 return(X)
}


##Wrap Algorithms 1 and 2 ##
fTGauss=function(TruncationParameter,NumberSimulations,Algorithm) 
{
 if(TruncationParameter=="TP1"){a=1}
 if(TruncationParameter=="TP2"){a=1.5}
 if(TruncationParameter=="TP3"){a=2}
 if(TruncationParameter=="TP4"){a=2.5}
 if(TruncationParameter=="TP5"){a=3}
 if(TruncationParameter=="TP6"){a=3.5}
 
 if(Algorithm=="V1"){Res=fTGauss1(a,NumberSimulations)}
 if(Algorithm=="V2"){Res=fTGauss2(a,NumberSimulations)}
 return(Res)  
}


shinyServer(function(input, output) {
 
  output$distPlot <- renderPlot({
  Res=fTGauss(input$TruncationParameter,input$NumberSimulations,input$Algorithm)
  
  if(input$TruncationParameter=="TP1"){scale=1}
  if(input$TruncationParameter=="TP2"){scale=1.5}
  if(input$TruncationParameter=="TP3"){scale=2}
  if(input$TruncationParameter=="TP4"){scale=2.5}
  if(input$TruncationParameter=="TP5"){scale=3}
  if(input$TruncationParameter=="TP6"){scale=3.5}
  
  fn=function(x){exp(-x*x/2)}
  K=integrate(fn,lower=scale,upper=Inf)$value
  
  curve((1/K)*exp(-x*x/2),-5,5,col=2,lwd=2,main=paste(input$NumberSimulations,"Independent Realizations of Truncated Standard Gaussian Distribution",sep=" "),cex.main=1,xlab="x",ylab="f(x)")
  hist(Res,breaks=50,prob=T,add=T,col="green")
  legend("topright",legend=c("Theoretical pdf","Empirical pdf"),lty=c(1,1),cex=1, col=c(2,3), lwd=c(2,2))
  
 })
 
 
 
})


