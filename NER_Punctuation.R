df = read.csv("data/punct_text_ner.csv", sep = ';')

ggplot(df, 
       aes(x = count_punct, y = Clicks)) +
  geom_point() +
  geom_smooth() +
  labs(title = "Punctuation versus clicks",
       x = "Number of punctuation",
       y = 'Clicks') +
  coord_flip() +
  theme_classic()

ggsave(filename = "plots/punctuation.png", dpi = 150)
