
#install all packages that are needed for this analysis
install.packages("bio3d")
install.packages("ggplot2")
install.packages("gapminder")
install.packages("dplyr")
install.packages("gifski")
install.packages("gganimate")
install.packages("patchwork")
library(dplyr)
library(gifski)
library(gganimate)
library(patchwork)
library(ggplot2)
library(bio3d)
library(gapminder)

# downloading file from protien data bank
CA <- read.pdb("1ca2")
print(CA)
CA$atom
CA$atom[1:2, c("eleno", "elety", "x", "y", "z")]
CA$atom$elety[1:2]
plot.bio3d(CA$atom$b[CA$calpha], sse=CA, typ="l", ylab="B-factor")
# getting to know the dimession of our coordinates "x,y,z"
CA$xyz
dim(CA$xyz)
CA$xyz[ 1, atom2xyz(1:2)] #obtaining the coordinate of atom 2

# How flexible is CA

flex = nma(CA)

plot(flex)
##batch import
list.files("pdbs", pattern=".pdb") #call all of the .pdb file names in the folder

list.files("pdbs", pattern=".pdb", full.names=T) #get path names to those files

pdbs_list=lapply(list.files("pdbs", pattern=".pdb", full.names=T), function(x) scan(file=x, what="text"))


#####
#you can read the pdb file just as a text file this way:
p1=scan(file="pdbs/1A00.pdb", what="text")
p3=scan(file="pdbs/1A4F.pdb", what="text")
p2=scan(file="pdbs/1A3O.pdb", what="text")
p4=scan(file="pdbs/1ABW.pdb", what="text")
P5=scan(file="pdbs/1AJ9.pdb", what="text")
P6=scan(file="pdbs/1BAB.pdb", what="text")
P7=scan(file="pdbs/1BZ1.pdb", what="text")
P8=scan(file="pdbs/1BZZ.pdb", what="text")
P9=scan(file="pdbs/1C7D.pdb", what="text")
P10=scan(file="pdbs/1C40.pdb", what="text")
P11=scan(file="pdbs/1CH4.pdb", what="text")
P12=scan(file="pdbs/1FAW.pdb", what="text")
P13=scan(file="pdbs/1FHJ.pdb", what="text")
P14=scan(file="pdbs/1FSX.pdb", what="text")
P15=scan(file="pdbs/1G0B.pdb", what="text")
P16=scan(file="pdbs/1GLI.pdb", what="text")
P17=scan(file="pdbs/1HBH.pdb", what="text")
P18=scan(file="pdbs/1HBR.pdb", what="text")
P19=scan(file="pdbs/1HDS.pdb", what="text")
P20=scan(file="pdbs/1IBE.pdb", what="text")
P21=scan(file="pdbs/1IWH.pdb", what="text")
P22=scan(file="pdbs/1J7S.pdb", what="text")
P23=scan(file="pdbs/1JEB.pdb", what="text")
P24=scan(file="pdbs/1LA6.pdb", what="text")
P25=scan(file="pdbs/1O1I.pdb", what="text")
P26=scan(file="pdbs/1O1J.pdb", what="text")
P27=scan(file="pdbs/1O1L.pdb", what="text")
P28=scan(file="pdbs/1O1M.pdb", what="text")
P29=scan(file="pdbs/1O1N.pdb", what="text")
P30=scan(file="pdbs/1O1O.pdb", what="text")
P31=scan(file="pdbs/1OUT.pdb", what="text")
P32=scan(file="pdbs/1QPW.pdb", what="text")
P33=scan(file="pdbs/1R1X.pdb", what="text")
P34=scan(file="pdbs/1RVW.pdb", what="text")
P35=scan(file="pdbs/1S0H.pdb", what="text")
P36=scan(file="pdbs/1SPG.pdb", what="text")
P37=scan(file="pdbs/1V4U.pdb", what="text")
P38=scan(file="pdbs/1V75.pdb", what="text")
P39=scan(file="pdbs/1XQ5.pdb", what="text")
P40=scan(file="pdbs/1XY0.pdb", what="text")
P41=scan(file="pdbs/1XYE.pdb", what="text")
P42=scan(file="pdbs/1XZ5.pdb", what="text")
P43=scan(file="pdbs/1XZ7.pdb", what="text")
P44=scan(file="pdbs/1XZU.pdb", what="text")
P45=scan(file="pdbs/1XZV.pdb", what="text")
P46=scan(file="pdbs/1Y0A.pdb", what="text")
P47=scan(file="pdbs/1Y0C.pdb", what="text")
P48=scan(file="pdbs/1Y0D.pdb", what="text")
P49=scan(file="pdbs/1Y09.pdb", what="text")
P50=scan(file="pdbs/2DHB.pdb", what="text")
P51=scan(file="pdbs/2QLS.pdb", what="text")
P52=scan(file="pdbs/2QMB.pdb", what="text")
P53=scan(file="pdbs/2QU0.pdb", what="text")
P54=scan(file="pdbs/2R1H.pdb", what="text")
P55=scan(file="pdbs/2R80.pdb", what="text")
P56=scan(file="pdbs/2RAO.pdb", what="text")
P57=scan(file="pdbs/2W72.pdb", what="text")
P58=scan(file="pdbs/2ZFB.pdb", what="text")
P60=scan(file="pdbs/3A0G.pdb", what="text")
P61=scan(file="pdbs/3A59.pdb", what="text")
P62=scan(file="pdbs/3AT5.pdb", what="text")
P63=scan(file="pdbs/3BCQ.pdb", what="text")
P64=scan(file="pdbs/3BJ1.pdb", what="text")
P65=scan(file="pdbs/3CY5.pdb", what="text")
P66=scan(file="pdbs/3D1A.pdb", what="text")
P68=scan(file="pdbs/3D4X.pdb", what="text")
P67=scan(file="pdbs/3D1K.pdb", what="text")
P69=scan(file="pdbs/3DHR.pdb", what="text")
P70=scan(file="pdbs/3DHT.pdb", what="text")
P71=scan(file="pdbs/3EOK.pdb", what="text")
P72=scan(file="pdbs/3FH9.pdb", what="text")
P73=scan(file="pdbs/3GDJ.pdb", what="text")
P74=scan(file="pdbs/3HRW.pdb", what="text")
P75=scan(file="pdbs/3IA3.pdb", what="text")
P76=scan(file="pdbs/3K8B.pdb", what="text")
P77=scan(file="pdbs/3LQD.pdb", what="text")
P78=scan(file="pdbs/3MJP.pdb", what="text")
P79=scan(file="pdbs/3NMM.pdb", what="text")
P80=scan(file="pdbs/3QJB.pdb", what="text")
P81=scan(file="pdbs/3VRE.pdb", what="text")
P82=scan(file="pdbs/3W4U.pdb", what="text")
P83=scan(file="pdbs/3WR1.pdb", what="text")
P84=scan(file="pdbs/3WTG.pdb", what="text")
P85=scan(file="pdbs/4ESA.pdb", what="text")
P86=scan(file="pdbs/4H2L.pdb", what="text")
P87=scan(file="pdbs/4MQC.pdb", what="text")
P88=scan(file="pdbs/4MQH.pdb", what="text")
P89=scan(file="pdbs/4YU3.pdb", what="text")
P90=scan(file="pdbs/5EUI.pdb", what="text")
P91=scan(file="pdbs/5KER.pdb", what="text")
P92=scan(file="pdbs/5SW7.pdb", what="text")
P93=scan(file="pdbs/5WOG.pdb", what="text")
P94=scan(file="pdbs/6BB5.pdb", what="text")
P95=scan(file="pdbs/6IHX.pdb", what="text")
P96=scan(file="pdbs/6II1.pdb", what="text")
P97=scan(file="pdbs/6IYI.pdb", what="text")
P98=scan(file="pdbs/6SVA.pdb", what="text")
P99=scan(file="pdbs/7DY3.pdb", what="text")
P100=scan(file="pdbs/7DY4.pdb", what="text")
P101=scan(file="pdbs/7QU4.pdb", what="text")

#this will read the file by each line and tab. So a lot of this will be just one word.
setwd("pdbs/")
file_name=list.files(pattern = ".pdb")

data_list=list()
for (i in file_name) {
  data=scan(i,what="text")
  name=gsub(".pdb","",i)
  data_list[[i]]=data
}
#then, you can just search for "RESOLUTION." with the period at the end. The str_which() function will tell you which item in "p1" gives you the exact match.
library(stringr)
str_which(p1, "RESOLUTION.")

#The item that follows that is the the resolution, so you can look that up by using p1[ ], and adding one to the item number of "RESOLUTION." This should give you "1.60"
res=sapply(data_list, function(x) as.numeric(x[str_which(x, "RESOLUTION.")+1]))

sapply(res, function(x) x[is.na(x)==F]) #just get the values that are not NA

# Now use ggplot

