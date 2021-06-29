library(tercen)
library(dplyr)

ctx = tercenCtx()

data   <- ctx %>% select(.ri, .ci, .y)
matrix <- ctx$as.matrix()

row_means <- rowMeans(matrix)
row_rank  <- rank(row_means, ties.method = "min")
row_rank  <- 1 + max(row_rank) - row_rank
result    <- data.frame(.ri = data$.ri, .ci = data$.ci, rowMean = NaN, rowRank = NaN)
for (i in 0:length(row_means)) {
  result$rowMean[result$.ri == i] = row_means[i+1]
  result$rowRank[result$.ri == i] = row_rank[i+1]
}

result %>%
  ctx$addNamespace() %>%
  ctx$save()
