library(scales)

df = read.csv("data/punct_text_ner.csv", sep = ';')
options(scipen=10000)

## Scatter plot

ggplot(df, 
       aes(x = count_punct, y = clicks)) +
  geom_point() +
  geom_smooth() +
  labs(title = "Punctuation versus clicks",
       x = "Number of punctuation",
       y = 'Clicks') +
  coord_flip() +
  theme_classic()

ggsave(filename = "plots/punctuation.png", dpi = 150)

## Barchart

### Simple first bar
ggplot(df,
       aes(x = count_punct, y = clicks)) +
  geom_bar(position="dodge2",stat="identity") +
  labs(title = "Punctuation versus clicks",
       x = "Number of punctuation",
       y = 'Clicks') +
  # geom_smooth() +
  theme_classic()

## Grouping the data
df_grouped <- df %>%
  mutate(new_bin = ntile(count_punct, n=20))

x_axis_labels <- min(df[,]):max(df[,count_punct])

ggplot(df,
       aes(x = factor(count_punct), y = clicks)) +
  #geom_jitter() +
  geom_col() +
  labs(title = "Punctuation versus clicks",
       x = "Number of punctuation",
       y = 'Clicks') +
  geom_smooth() +
  theme_classic()

ggsave(filename = "plots/barplot_punctuation.png", dpi = 150)
