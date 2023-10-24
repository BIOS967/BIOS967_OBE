fol4= read.csv("data/F23 FIxed line disease screen.csv")
fol4
plot(fol4$Trial.ID~fol4$X.Healthy, data = fol4, xlab="Healthy", ylab = "Trial ID", main= "Effect of FOL4 on Health of Tomatoe plants", las=1)
library(ggplot2)
ggplot(data=fol4, mapping=aes(x=Trial.ID, y=X.Healthy))
