# Importing the required libraries

library(dplyr)
library(ggplot2)
library(ggthemes)
library(lme4)
library(sjPlot)

# Plotting Entity label click rates

lengthdata = read.csv("data/GroupedwTIME.csv")

labelplot <- ggplot(lengthdata,aes(x=Label,y=Clicks))+
  geom_point()+
  coord_flip()+
  theme_classic()+
  labs(title= "Click through rate for different NER labels", subtitle ="Labels have been grouped and use their averages")+
  annotate('text', x = 9, y = 325, label = '310')+
  annotate('text', x = 13, y = 460, label = '445')+
  annotate('text', x = 16, y = 490, label = '472') + theme(axis.title.y = element_blank())

labelplot

ggsave("plots/1-labelclicks.png",labelplot, bg="transparent", dpi = 300)

# Headline lengths vs clicks

lengthdata <- read.csv("data/lengthcoded.csv")

subsetted <- subset(lengthdata, Length > 25)
subsetted2 <- subset(subsetted, Length < 110)

lengthplot <- ggplot(subsetted2)+
  geom_bar(aes(x=Length,alpha =0.1), fill = "slateblue3") + 
  scale_x_continuous(breaks = seq(from = 30, to = 110, by = 20)) + geom_smooth(aes(x=Length,y=Clicks),colour="orange", linewidth = 2) + scale_y_log10() +
  labs(title = "Click through rate for headline lengths", y = "log10(Clicks)", subtitle = "Click rate logarithmically transformed for trend analysis")+
  theme_bw() + theme(legend.position = "NONE") 

lengthplot

ggsave("plots/2-lengthclicks.png",lengthplot, bg="transparent", dpi = 300)

# Headline punctuations vs clicks

punctdata = read.csv("data/punct_text_ner.csv", sep = ';')

punctplot <- ggplot(punctdata, 
  aes(x = count_punct, y = clicks)) +
  geom_bar(stat = "identity",position="dodge", fill = "slateblue3", alpha = 0.3) + scale_x_continuous(breaks = seq(0,23, by = 1)) + 
  labs(title = "Click through rate for punctuation frequencies", x = "Number of punctuation characters", y = 'Clicks', subtitle = "Density of colours used as measure of click rate frequency") + theme_classic()

punctplot

ggsave("plots/3-punctclicks.png",punctplot, bg="transparent", dpi = 300)

# Entity existence regression

entityexistence <- read.csv("data/contains_entities.csv")

multientity <- lmer(clicks ~ contains_entity + (1 + contains_entity | test_id), data = entityexistence)

tab_model(multientity)

# Label regression

typesframe <- read.csv("data/typesner.csv")

multitypes <- lmer(Clicks ~ ORG + DATE + PERSON + GPE + LOC + MONEY + TIME + PRODUCT + QUANTITY + EVENT + FAC + LANGUAGE + LAW + NORP + PERCENT + WORK_OF_ART + (1 | Test_id), data = typesframe)

tab_model(multitypes)

# Length regression

multilength <- lmer(Clicks ~ Length + (1 | Test_id), data = lengthdata)

tab_model(multilength)

# Punctuation regression

multipunct <- lmer(clicks ~ count_punct + (1 | clickability_test_id), data = punctdata)

tab_model(multipunct)
