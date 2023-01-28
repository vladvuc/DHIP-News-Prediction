library(dplyr)
library(ggplot2)
library(ggthemes)
library(ggrepel)
library(stringr)

df=read.csv("data/indexedwtext_ner.csv")
df2=read.csv("data/GroupedwoTIME.csv")
df3=read.csv("data/GroupedwTIME.csv")

##########################

ggplot(df3,aes(x=Label,y=Clicks))+
  geom_point()+
  coord_flip()+
  theme_classic()+
  ggtitle("Mean amount of clicks by NER label")+
  annotate('text', x = 9, y = 325, label = '310')+
  annotate('text', x = 13, y = 460, label = '445')+
  annotate('text', x = 16, y = 490, label = '472')

##############################

df$Length<-df$Label
df$Label <- str_count(df$Headline)

df <- df[!duplicated(df$Headline), ]

df5 <- df[,c(1,2,3,6,7)]

###################################

ggplot(df5, aes(x=Label))+
  geom_histogram() +
  #geom_line(aes(x=Label,y=Clicks), color="blue")+
  #geom_bar(stat="identity",color="black")+
  ggtitle("Headline length vs. amount of Clicks")+
  theme_bw() +
  scale_x_continuous(limits=c(25,115))
