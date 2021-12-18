library(dplyr)
library(tidyr)
library(plotly)
library(reshape)


commonprocessing <- function(dat) {
  colnames(dat) <- c("File1", "File2", "Result")
  dat$File1 <- as.numeric(dat$File1)
  dat$File2 <- as.numeric(dat$File2)
  dat$Result <- as.numeric(dat$Result)
  dat <- dat %>% filter(File1 < 13, File2 < 13)
  dat <- dat %>% mutate(index = paste0(File1, "-", File2))
  dat <- dat %>% select("index", "Result")
  dat
}


data1 <- commonprocessing(read.csv("result/Long Text Original.csv"))
colnames(data1)[colnames(data1)=="Result"] <- "Result1"
data2 <- commonprocessing(read.csv("result/Long Text Random 700 (One Over Tenth).csv"))
colnames(data2)[colnames(data2)=="Result"] <- "Result2"
data3 <- commonprocessing(read.csv("result/Long Text Top 700 (One Over Tenth).csv")) 
colnames(data3)[colnames(data3)=="Result"] <- "Result3"
data4 <- commonprocessing(read.csv("result/Short Text Original.csv")) 
colnames(data4)[colnames(data4)=="Result"] <- "Result4"
data <- data1 %>% left_join(data2, by="index") %>% left_join(data3, by="index") %>% left_join(data4, by="index")
#separate(Column1, c("File1", "File2", "Result"), " ")

plot <- 
plot_ly(data, x=~index, y=~Result1, type = 'scatter', 
        mode = 'lines', name="long text all words (LTAW)", line=list(color="#111111")) %>% 
  add_trace(y=~Result2, name="long text top 1/10 words (LTTW)", mode = 'lines', line=list(color="#555555", dash="dot")) %>% 
  add_trace(y=~Result3, name="long text random 1/10 words (LTRW)", line=list(color="#777777")) %>% 
  add_trace(y=~Result4, name="short text all words (STAW)", line=list(color="#999999", dash="dot")) %>%
  layout(legend = list(orientation = "h",   # show entries horizontally
                       xanchor = "center",  # use center of legend as anchor
                       x = 0.5, y = 1.1),
          xaxis = list(title = "", showgrid = FALSE, categoryarray = data1$index, categoryorder = "array", tickfont = list(size = 15)),
          yaxis = list(title = "", range=c(0, 0.8), nticks = 11, showgrid = TRUE, showline = TRUE, zeroline = TRUE, showticklabels = TRUE, ticksuffix="&nbsp;&nbsp;", tickfont = list(size = 15)))

plot

#Calculate the distance between two vectors
dist(rbind(data1$Result1-data2$Result2))
