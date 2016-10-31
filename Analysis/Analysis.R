library(ggplot2)
library(reshape2)
library(RCurl)
library(wikipediatrend)
library(corrplot)

mydata <- read.csv('./data/SFlistings.csv')
mycal <- read.csv('./data/SFcalendar.csv')

mydata$price <- as.numeric(gsub('\\$','',mydata$price))
tmp<-mydata%>%
  select(price,accommodates,bathrooms,bedrooms,beds,guests_included,review_scores_rating, reviews_per_month)%>%
  mutate(price = as.numeric(gsub('\\$','',price)))

corrplot(cor(tmp, use = "na.or.complete"), type ="upper", method="shade",shade.col=NA, tl.col="black", tl.srt=45)

Giants2015 = wp_trend("2015_San_Francisco_Giants_season", from = "2015-01-01", to = "2016-10-01")
Giants2016 = wp_trend("2016_San_Francisco_Giants_season", from = "2015-01-01", to = "2016-10-01")

dcomp = rbind(Giants2015, Giants2015)

ggplot(dcomp) +
  geom_line(aes(x = date, y = count, colour = title), size = 1.1) +
  scale_colour_manual(
    values = c("red3", "blue4"),
    labels = c("2015 Giants game season in San Francisco", "2016 Giants game season in San Francisco"),
    "Legend"
  ) +
  scale_y_continuous(breaks = seq(0, max(dcomp$count), 1000)) +
  theme(
    axis.title = element_text(size = 11, face = "bold"),
    axis.text = element_text(size = 10, face = "bold"),
    plot.title = element_text(size = 12, face = "bold"),
    #legend.title = element_text("Legend"),
    #legend.background = element_rect(colour = "black"),
    panel.grid.major = element_line(colour = "black", linetype = "dotted"),
    axis.title.x = element_text(margin = margin(r = 12)),
    axis.title.y = element_text(margin = margin(r = 10))
  )  +
  labs(title = "Wikipedia Trends for Giants game in SF, 2015 to 2016", x = "", y = "Search Count")

ggplot(data=mydata, aes(x=security_deposit, y=price)) + geom_point() 
+ labs(title="Security deposit vs Price in SF Area")

cal <- mycal %>% group_by(price) %>% summarize(total_listings = n())

#shows that there is very little correlation
ggplot(aes(price, total_listings), data=cal[1:1000,]) + geom_point() +
  scale_y_continuous(breaks = seq(0, max(dcomp$count), 5000)) 
