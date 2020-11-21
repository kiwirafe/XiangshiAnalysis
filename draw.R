library(dplyr)
library(tidyr)
library(plotly)
library(reshape)

commonprocessing <- function(dat) {
  colnames(dat) <- c("File1", "File2", "Result")
  dat$File1 <- as.numeric(dat$File1)
  dat$File2 <- as.numeric(dat$File2)
  dat$Result <- as.numeric(dat$Result)
  dat <- dat %>% filter(File1 < 40, File2 < 40)
  dat
}

data <- commonprocessing(read.csv("C:/Development_local/tfidf/data/long_text_original.csv"))

#separate(Column1, c("File1", "File2", "Result"), " ")




data <- data %>% rbind(data.frame(File1=c(1:39), File2=c(1:39),Result=0))
data <- data[order(data[,1],data[,2],decreasing=FALSE),]

data <- cast(data, File1 ~ File2)
data[is.na(data)] <- 0
data <- data %>% select(-"File1")
result <- data + t(data)
result[result == 0] <- 1
result <- as.matrix(result)
dimnames(result) <- list(c(1:39), 
                         c(1:39))
plot_ly(x = colnames(result), y = rownames(result), z = result, type = "heatmap", colorscale = "Greys", reversescale =T)         


plot(hclust(as.dist(result), method = "median"))


#https://stackoverflow.com/questions/3081066/what-techniques-exists-in-r-to-visualize-a-distance-matrix
#You could also use force-directed graph drawing algorithms to visualize a distance matrix

library(qgraph)
jpeg('example_forcedraw.jpg', width=1000, height=1000, unit='px')
qgraph(result, layout='spring', vsize=3)
dev.off()


#https://www.statmethods.net/advstats/cluster.html
# Ward Hierarchical Clustering with Bootstrapped p values
library(pvclust)
fit <- pvclust(result, #method.hclust="ward",
               method.dist="euclidean")
plot(fit, main="", axes=F, xlab="", ylab="", sub="")  # dendogram with p values
# add rectangles around groups highly supported by the data
pvrect(fit, alpha=.95) 