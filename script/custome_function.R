fol4= read.csv("data/F23 FIxed line disease screen.csv")

plot(fol4$Trial.ID~fol4$X.Healthy, data = fol4, xlab="Healthy", ylab = "Trial ID", main= "Effect of FOL4 on Health of Tomatoe plants", las=1)
library(ggplot2)
ggplot(data=fol4, mapping=aes(x=as.factor(Trial.ID), y=X.Healthy))+
  geom_line()
Sam + facet_wrap(~Rep)
View(fol4)
fol4_Trial1 <- fol4 %>% filter(Trial.ID=="FOL4-1")
fol4_Trial1
ID <- rep(1:12, each=1, times=4)
fol4$ID <- rownames(as.factor(fol4$Trial.ID))
Sam <- ggplot(fol4) +
  aes(x=Trial.ID, y=X.Healthy, fill=Rep)+
  geom_col() +
  labs(title = "Relationship between Trial ID and Healthy Species",
       subtitle = "Disease progression",
       caption = "FOL4: '*Folciparum*",
       x="Trial ID",
       y="Healthy Species")
fol4
rm(fol4$ID)
