#To output the plots in the manuscript
ri=27.5
#Read results for 50%
temp = list.files(path="result/Wind speed/50%",pattern="csv")
n<-length(temp)
temp50<-list()
for (i in 1:n) {
  temp50[[i]]<-read.csv(paste("result/Wind speed/50%/",temp[i],sep=""))
}

#Create a dataframe to store  50% results. 
result50<-data.frame(ID=temp,maxtemp=c(1:n),mintemp=c(1:n),
                     surface=ri^2*pi,
                     maxvolume=c(1:n),minvolume=c(1:n),maxTa=c(1:n),
                     minTa=c(1:n))

#Read results for 100% wind
temp = list.files(path="result/Wind speed/100%",pattern="csv")
n<-length(temp)
temp100<-list()
for (i in 1:n) {
  temp100[[i]]<-read.csv(paste("result/Wind speed/100%/",temp[i],sep=""))
}

#Create a dataframe to store 100% results. 
result100<-data.frame(ID=temp,maxtemp=c(1:n),mintemp=c(1:n),
                     surface=ri^2*pi,
                     maxvolume=c(1:n),minvolume=c(1:n),maxTa=c(1:n),
                     minTa=c(1:n))

#Read results for 150%
temp = list.files(path="result/Wind speed/150%",pattern="csv")
n<-length(temp)
temp150<-list()
for (i in 1:n) {
  temp150[[i]]<-read.csv(paste("result/Wind speed/150%/",temp[i],sep=""))
}

#Create a dataframe to store  150% results. 
result150<-data.frame(ID=temp,maxtemp=c(1:n),mintemp=c(1:n),
                     surface=ri^2*pi,
                     maxvolume=c(1:n),minvolume=c(1:n),maxTa=c(1:n),
                     minTa=c(1:n))

#Obtain the warmest month: temperature and volume,50%
for (i in 1:n) {
  a<-tapply(temp50[[i]]$Temperature.C[731:1095]
            ,temp50[[i]]$Month[731:1095],mean)
  result50$maxtemp[i]<-max(a)
  result50$mintemp[i]<-min(a)
  
  b<-tapply(temp50[[i]]$Volume.m3[731:1095]
            ,temp50[[i]]$Month[731:1095],mean)
  result50$maxvolume[i]<-b[a==max(a)]
  result50$minvolume[i]<-b[a==min(a)]
}

result50$SVratio.max<-result50$surface/result50$maxvolume
result50$SVratio.min<-result50$surface/result50$minvolume

#Obtain the warmest month: temperature and volume,100%
for (i in 1:n) {
  a<-tapply(temp100[[i]]$Temperature.C[731:1095]
            ,temp100[[i]]$Month[731:1095],mean)
  result100$maxtemp[i]<-max(a)
  result100$mintemp[i]<-min(a)
  
  b<-tapply(temp100[[i]]$Volume.m3[731:1095]
            ,temp100[[i]]$Month[731:1095],mean)
  result100$maxvolume[i]<-b[a==max(a)]
  result100$minvolume[i]<-b[a==min(a)]
}

result100$SVratio.max<-result100$surface/result100$maxvolume
result100$SVratio.min<-result100$surface/result100$minvolume

#Obtain the warmest month: temperature and volume,200%
for (i in 1:n) {
  a<-tapply(temp150[[i]]$Temperature.C[731:1095]
            ,temp150[[i]]$Month[731:1095],mean)
  result150$maxtemp[i]<-max(a)
  result150$mintemp[i]<-min(a)
  
  b<-tapply(temp150[[i]]$Volume.m3[731:1095]
            ,temp150[[i]]$Month[731:1095],mean)
  result150$maxvolume[i]<-b[a==max(a)]
  result150$minvolume[i]<-b[a==min(a)]
}

result150$SVratio.max<-result150$surface/result150$maxvolume
result150$SVratio.min<-result150$surface/result150$minvolume

#To obtain air temperature
Envir.daily<-read.csv("daily env input_RH.csv",header=T)
Envir.daily$Tmean<-(Envir.daily$AirTmax1+Envir.daily$AirTmin1)/2
Tmean.air<-tapply(Envir.daily$Tmean[731:1095]
                  ,Envir.daily$Month[731:1095],mean)
result50$maxTa<-max(Tmean.air)
result50$minTa<-min(Tmean.air)
result100$maxTa<-max(Tmean.air)
result100$minTa<-min(Tmean.air)
result150$maxTa<-max(Tmean.air)
result150$minTa<-min(Tmean.air)


#the difference between max Ta and max Tm, and min Ta and min Tm
result50$diff.max<-result50$maxtemp-result50$maxTa
cor.test(result50$SVratio.max,result50$diff.max)
result100$diff.max<-result100$maxtemp-result100$maxTa
cor.test(result100$SVratio.max,result100$diff.max)
result150$diff.max<-result150$maxtemp-result150$maxTa
cor.test(result150$SVratio.max,result150$diff.max)

#save(result50,file="result50%_Ottawa.rda")
#save(result100,file="result100%_Ottawa.rda")
#save(result150,file="result150%_Ottawa.rda")

#Input data from Ottawa
load(file="result50%_Ottawa.rda")
load(file="result100%_Ottawa.rda")
load(file="result150%_Ottawa.rda")
#Input data from EDM
EDM<-"C:/Users/hungc/OneDrive - AGR-AGR/AAFC/Project 7_surface area ratio/2_mehtods/R/Test-for-surface-volume-ratio-EDM"
load(file=paste(EDM,"/result50%_EDM.rda",sep=""))
load(file=paste(EDM,"/result100%_EDM.rda",sep=""))
load(file=paste(EDM,"/result150%_EDM.rda",sep=""))

# result$diff.min<-result$mintemp-result$minTa
#To plot results for max temperature
#output at 800 x 600
par(mar=c(4,5,4,4))
plot(result50$SVratio.max,result50$diff.max,
     xlab=expression(paste("Surface area / manure volume (",m^-1,")")),
     #xlab="",
     ylab=expression(paste("T"["diff"]~"(",degree,"C)")),
     las=1,xaxs="i",yaxs="i",
     xlim=c(0.30,0.70),
     ylim=c(-5,6),
     pch=16,cex.lab=1.8,cex=1.5,xaxt="n",cex.axis=1.5)
axis(side = 1, at = c(0.3, 0.4, 0.5, 0.6, 0.7),cex.axis=1.5,
     labels = c('0.30', '0.40', '0.50', '0.60', '0.70'))
points(result100$SVratio.max,result100$diff.max,pch=17,cex=1.5)
points(result150$SVratio.max,result150$diff.max,pch=15,cex=1.5)
#text(0.56,4.8,expression(paste("r = 0.99, ",italic(P),"< 0.001")),pos=4,cex=1.3)
#text(0.56,2.0,expression(paste("r = 0.99, ",italic(P),"< 0.001")),pos=4,cex=1.3)
#text(0.56,-0.1,expression(paste("r = 0.98, ",italic(P),"< 0.001")),pos=4,cex=1.3)
text(0.30,5.6,"(a) Ottawa",pos=4,cex=1.8)
legend(0.30,-1,c("6.5","13.0","19.5")
       ,pch=c(16,17,15),ncol=1,bty="n",cex=1.8
       ,title=expression(Wind~speed~ "("~km~h^-1~")"))

#EDM part
plot(result50.EDM$SVratio.max,result50.EDM$diff.max,
     xlab=expression(paste("Surface area / manure volume (",m^-1,")")),
     #xlab="",
     ylab=expression(paste("T"["diff"]~"(",degree,"C)")),
     las=1,xaxs="i",yaxs="i",
     xlim=c(0.30,0.70),
     ylim=c(-5,6),
     pch=1,cex.lab=1.8,cex=1.5,xaxt="n",cex.axis=1.5)
points(result100.EDM$SVratio.max,result100.EDM$diff.max,pch=2,cex=1.5)
points(result150.EDM$SVratio.max,result150.EDM$diff.max,pch=0,cex=1.5)
#text(0.30,-0.2,expression(paste("r = 0.99, ",italic(P),"< 0.001")),pos=4,cex=1.3)
#text(0.31,-2.0,expression(paste("r = 0.99, ",italic(P),"< 0.001")),pos=4,cex=1.3)
#text(0.32,-3.2,expression(paste("r = 0.99, ",italic(P),"< 0.001")),pos=4,cex=1.3)
axis(side = 1, at = c(0.3, 0.4, 0.5, 0.6, 0.7), 
     labels = c('0.30', '0.40', '0.50', '0.60', '0.70'),
     cex.axis=1.5)
legend(0.32,5.2,c("6.1","12.2","18.3")
       ,pch=c(1,2,0),ncol=1,bty="n",cex=1.8
       ,title=expression(Wind~speed~ "("~km~h^-1~")"))
text(0.30,5.6,"(b) Edmonton",pos=4,cex=1.8)

#I don't want to discuss this part in the paper, CY March 22,2022
#To plot results for min temperature
# plot((result$minvolume/result$surface)[1:10],result$diff.min[1:10])
# plot(result$SVratio.min,result$diff.min)
# cor.test(result$SVratio.min,result$diff.min)


