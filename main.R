library(tercenApi)
library(tercen)
library(data.table)
library(dtplyr)
library(dplyr, warn.conflicts = FALSE)

ctx = tercenCtx()

ctx %>% select(.y, .ri) %>%
  lazy_dt() %>%
  group_by(.ri) %>%
  summarise(rowMean = mean(.y)) %>%
  mutate(rowRank=as.double(rank(rowMean, ties.method = "min"))) %>%
  as_tibble() %>%
  ctx$addNamespace() %>%
  ctx$save()

 