library(tercen)
library(dplyr)

# Set appropriate options
#options("tercen.serviceUri"="http://tercen:5400/api/v1/")
#options("tercen.workflowId"= "4133245f38c1411c543ef25ea3020c41")
#options("tercen.stepId"= "2b6d9fbf-25e4-4302-94eb-b9562a066aa5")
#options("tercen.username"= "admin")
#options("tercen.password"= "admin")

ctx = tercenCtx()

data   <- ctx %>% select(.ri, .ci, .y)
matrix <- ctx$as.matrix()

row_means <- rowMeans(matrix)
row_rank  <- rank(matrix, ties.method = "min")
row_rank  <- 1 + max(row_rank) - row_rank
result    <- data.frame(.ri = data$.ri, .ci = data$.ci, rowMean = NaN, rowRank = NaN)
for (i in 1:length(row_means)){
  result$rowMean[result$.ri == i] = row_means[i]
  result$rowRank[result$.ri == i] = row_rank[i]
}

result %>%
  ctx$addNamespace() %>%
  ctx$save()
