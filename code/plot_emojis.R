

library(ggplot2)
library(emojifont)
# load.emojifont("EmojiOne.ttf")


# a StackOverflow question
# https://stackoverflow.com/questions/47730589/plot-emojis-emoticons-in-r-with-ggplot

quartz()
ggplot(dat, aes(emoji_name, n, label = emoji)) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label=emoji), family = "EmojiOne", size = 6, vjust = -.5) +
  theme(axis.title.x=element_blank(),
        axis.text.x=element_blank(),
        axis.ticks.x=element_blank())


# my StackOverflow question
# https://stackoverflow.com/questions/52378661/how-to-display-emojis-in-ggplot2-using-emo-package-in-r

names = c("smile","school","office","blush","smirk","heart_eyes")
n = length(names):1
e = sapply(names, emojifont::emoji)
dat = data.frame(emoji_name = names, n = n, emoji = e, stringsAsFactors = F)

quartz()
ggplot(data=dat, aes(emoji_name, n)) + 
  geom_bar(stat = "identity") +
  geom_text(aes(label=n), nudge_y=-0.2) +
  geom_text(aes(y=-0.5, label=emoji), 
            family="EmojiOne", size=6) +
  theme( axis.text.y =element_text( size=20 ) ) +
  coord_flip()


# my shiny app 
xvec = sample(names, 20, T)
tab = as.data.frame(table(xvec))
tab = tab[order(tab$Freq, decreasing = T),]
tab$xvec = factor(tab$xvec, levels=rev(as.character(tab$xvec)))
tab$percent = 100 * tab$Freq / sum(tab$Freq)

quartz()
ggplot(tab, aes(xvec, Freq, fill=xvec)) +
  geom_bar(width = 1, size = 1, color = "white", stat = "identity") +
  geom_text(aes(label = Freq), nudge_y=-0.2) +
  labs(x = NULL, y = NULL, fill = NULL) +
  guides(fill=FALSE) +
  scale_x_discrete(breaks = tab$xvec, labels = tab$xvec) +
  guides(fill = guide_legend(reverse = TRUE)) +
  geom_text(aes(x=xvec, y=-0.5, label=emoji(as.character(xvec))), 
            nudge_x=-0.08, family="EmojiOne", size=6) +
  theme_classic() +
  coord_flip() 


### 

path = "/Users/Wen/百度云同步盘/01_Teaching/01_My_Courses/QuantMethods/quantmethods/graphs"
setwd(path)

library(gridSVG)
ps = grid.export("emoji.svg", addClass=T)

library(convertGraph)
convertGraph("emoji.svg","emoji.png", path="/Users/Wen/百度云同步盘/Packages/phantomjs/bin/phantomjs")


