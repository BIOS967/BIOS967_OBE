fol4= read.csv("data/F23 FIxed line disease screen.csv")
fol4
plot(fol4$Trial.ID~fol4$X.Healthy, data = fol4, xlab="Healthy", ylab = "Trial ID", main= "Effect of FOL4 on Health of Tomatoe plants", las=1)
library(ggplot2)
ggplot(data=fol4, mapping=aes(x=as.factor(Trial.ID), y=X.Healthy))+
  geom_line()
ggplot(fol4) +
  aes(x=Trial.ID, y=X.Healthy)+
  geom_point() +
  labs(title = "Relationship between Trial ID and Healthy Species",
       subtitle = "Disease progression",
       caption = "FOL4: '*Folciparum*",
       x="Trial ID",
       y="Healthy Species")
