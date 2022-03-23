#To calculate manure temperature under various scenarios
temp.radius<-c(10,20,30,40,50)
temp.r<-seq(from=10,to=50,length=20)
temp.Mstorage<-c(2400,9600,21200,38400,60000)
temp.latitude<-c(20,30,40,50,60)
ri<-27.5
#To sumulate various diameter/volume only
for (l in 1:10) {
    ri<-ri
    M.storage<-ri^2*pi*5*1.5*0.97^l
    source("2.Marco loop.R",echo = F)
}
#To simulate various diameter and various annual manure input
# for (l in 1:5){
#   for (p in c(1,0.9,0.8,0.7)){
#     ri<-temp.radius[l]
#     M.storage<-temp.Mstorage[l]*p
#     source("2.Marco loop.R",echo = F)
#   }
# }

# #to simulate in differe latitude
# for (l in 1:5){
#   for (p in 1:5){
#     ri<-temp.radius[l]
#     M.storage<-temp.Mstorage[l]
#     L<-temp.latitude[p]
#     source("2.Marco loop.R",echo = F)
#   }
# }

#Read results
temp = list.files(path="result",pattern="csv")
n<-length(temp)
temp1<-list()
for (i in 1:n) {
   temp1[[i]]<-read.csv(paste("result/",temp[i],sep=""))
 }

#Create a dataframe to store results. 

result<-data.frame(ID=temp,maxtemp=c(1:n),mintemp=c(1:n),
           surface=ri^2*pi,
           maxvolume=c(1:n),minvolume=c(1:n),maxTa=c(1:n),
           minTa=c(1:n))

#Obtain the warmest month: temperature and volume
for (i in 1:n) {
a<-tapply(temp1[[i]]$Temperature.C[731:1095]
,temp1[[i]]$Month[731:1095],mean)
result$maxtemp[i]<-max(a)
result$mintemp[i]<-min(a)

b<-tapply(temp1[[i]]$Volume.m3[731:1095]
          ,temp1[[i]]$Month[731:1095],mean)
result$maxvolume[i]<-b[a==max(a)]
result$minvolume[i]<-b[a==min(a)]
}

result$SVratio.max<-result$surface/result$maxvolume
result$SVratio.min<-result$surface/result$minvolume

#To obtain air temperature
Envir.daily<-read.csv("daily env input_RH.csv",header=T)
Envir.daily$Tmean<-(Envir.daily$AirTmax1+Envir.daily$AirTmin1)/2
Tmean.m<-tapply(Envir.daily$Tmean[731:1095]
       ,Envir.daily$Month[731:1095],mean)
result$maxTa<-max(Tmean.m)
result$minTa<-min(Tmean.m)

#the difference between max Ta and max Tm, and min Ta and min Tm
result$diff.max<-result$maxtemp-result$maxTa
result$diff.min<-result$mintemp-result$minTa
#To plot results for max temperature
plot(result$SVratio.max,result$diff.max,
     xlab="Ratio of surface area to manure volume",
     ylab=expression(paste("Difference between manure and air temperature ( ",degree,"C)")),
     las=1,xaxs="i",yaxs="i",
     xlim=c(0.34,0.48),ylim=c(1.7,2.1),
     pch=16)
text(0.35,2.0,"r = 0.99, p-value < 0.001",pos=4)
cor.test(result$SVratio.max,result$diff.max)

#I don't want to discuss this part in the paper, CY March 22,2022
#To plot results for min temperature
# plot((result$minvolume/result$surface)[1:10],result$diff.min[1:10])
# plot(result$SVratio.min,result$diff.min)
# cor.test(result$SVratio.min,result$diff.min)
