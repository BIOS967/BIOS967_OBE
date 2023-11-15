library(ggplot2)
ggplot(cars) +
  aes(x=speed, y=dist) +
  geom_point() +
  geom_smooth(method = "lm", se=F) +
  labs(title = "Speed and Stopping Distances of Cars",
       x="Speed (MPH)",
       y="Stopping Distance (ft)",
       subtitle = "Some cars are faster than others",
       caption = "Distance: 'Cars'")+
  theme_bw()

# Using differential gene expression dataset to practice ggplot
url <- "http://bioboot.github.io/bimm143_S20/class-material/up_down_expression.txt"
#save into genes
genes <- read.delim(url)
#use head to check the dataset
head(genes)
#nrow() shows the number of rows
nrow(genes)
#colnames() show the column names while, ncol() show the number of roles
colnames(genes)
ncol(genes)
#finding the number of upregulated genes we can use table()
table(genes$State)
#using the round() function for calculation
round(table(genes$State)/nrow(genes)*100, 2)
#building scatter plot for this genes
p <- ggplot(genes)+
  aes(x=Condition1, y=Condition2, col=State)+
  geom_point()
p + scale_color_manual(values = c("blue", "gray", "red"))+
  labs(title = "Gene Expression Changes Upon Drug Treatment",
         x="Control (no drug)",
         y= "Drug Treament")

## Analyzing demographic data using gapminder. The gapminder as a package can be installed with install.packages("gapminder) then load the library(gapminder). But I am going to use another method
url <- "https://raw.githubusercontent.com/jennybc/gapminder/master/inst/extdata/gapminder.tsv"
gapminder <- read.delim(url)
?read.delim
install.packages("dplyr")
library(dplyr)

# Selecting a specific year to focus on
gapminder_2007 <- gapminder %>% filter(year==2007)

# Comparing how gdp per capital relates to life expectancy
gdp <- ggplot(gapminder_2007)+
  aes(x=gdpPercap, y=lifeExp, color=continent, size=pop)+
  geom_point(alpha=0.5)
gdp
# Using color gradient
ggplot(gapminder_2007)+
  aes(x=gdpPercap, y=lifeExp, color=pop)+
  geom_point(alpha=0.8)
# trying different things
ggplot(gapminder_2007)+
  geom_point(aes(x=gdpPercap, y=lifeExp, size=pop),alpha=0.8)+
  scale_size_area(max_size = 10)
# for year 1957
gapminder_1957 <- gapminder %>% filter(year==1957)
ggplot(gapminder_1957)+
  geom_point(aes(x=gdpPercap, y=lifeExp, color=continent, size=pop),alpha=0.7)+
  scale_size_area(max_size = 10)

# using facet to plot multiple graphs in one page
gapminder_57_07 <- gapminder %>% filter(year==1957 | year==2007 | year ==1967)
ggplot(gapminder_57_07)+
  geom_point(aes(x=gdpPercap, y=lifeExp, color=continent, size=pop),alpha=0.8)+
  scale_size_area(max_size = 10)+
  facet_wrap(~year)
# how to use barplot for data visualization
gapminder_top5 <- gapminder %>% filter(year==2007) %>%
  arrange(desc(pop))%>%
  top_n(5, pop)
gapminder_top5

# Creating simple bar chart. Since life expectancy in numerical, it would create a gradient color scale
ggplot(gapminder_top5)+
  geom_col(aes(x= country, y= pop, fill=lifeExp))
# if we use continent, it is categorical, therefore it would only create different color bars
ggplot(gapminder_top5)+
  geom_col(aes(x= country, y= pop, fill=continent))
# We can reorder our bar to make it more sensible
ggplot(gapminder_top5)+
  geom_col(aes(x= reorder(country, -pop), y= pop, fill=lifeExp))
# adding strokes and removing guides
ggplot(gapminder_top5)+
  geom_col(aes(x= reorder(country, -pop), y= pop, fill=country), col="black")+
  guides(fill="none")
# There are times that this does not represent what we want or can't be interpreted well, what if we flip the bar chart to explain what we want to show? For this, we will use an inbuilt data set
head(USArrests)

USArrests$States <- rownames(USArrests)
ggplot(USArrests)+
  aes(x=reorder(States, Murder), y=Murder)+
  geom_col()+
  coord_flip()
# Because this looks crowded, we can add geom_point to geom_segment
ggplot(USArrests)+
  aes(x=reorder(States, Murder), y=Murder)+
  geom_point()+
  geom_segment(aes(x=States,
                   xend=States,
                   y=0,
                   yend=Murder), color="blue")+
  coord_flip()
# How to add animation to data. Ggplot has a lot of extensions that can be found in https://awesomeopensource.com/projects/ggplot-extension. For this we would need to install gifski and gganimate
install.packages("gifski")
install.packages("gganimate")
# Load using library()
library(gganimate)
library(gifski)
# We need to setup our plot first
ggplot(gapminder, aes(gdpPercap, lifeExp, size=pop, colour=country)) +
  geom_point(alpha=0.7, show.legend = FALSE)+
  scale_colour_manual(values = country_colors)+
  scale_size(range = c(2,12))+
  scale_x_log10()+
  # adding facet to so that it show each continent separately
  facet_wrap(~continent)+
  # Adding animation to data
  labs(title = 'Year:{frame_time}', x='GDP per Capital', y='Life Expectancy')+
  transition_time(year)+
  shadow_wake(wake_length = 0.1, alpha=FALSE)
# How to combine different plots into 1 using R
install.packages("patchwork")
library(patchwork)
p1 <- ggplot(mtcars) + geom_point(aes(mpg, disp))
p2 <- ggplot(mtcars) + geom_boxplot(aes(gear, disp, group=gear))
p3 <- ggplot(mtcars) + geom_smooth(aes(disp, qsec))
p4 <- ggplot(mtcars) + geom_bar(aes(carb))

# This will patch the graphs together and arrange p1, p2,p3 on a line and p4 below them
(p1|p2|p3)/
  p4