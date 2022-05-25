library(tercenApi)
library(tercen)
library(data.table)
library(dtplyr)
library(dplyr, warn.conflicts = FALSE)

ctx = tercenCtx()

data = ctx %>% select(.y, .ci, .ri) %>% lazy_dt();

data %>%
  group_by(.ri) %>%
  summarise(rowMean = mean(.y)) %>%
  mutate(rowRank=rank(rowMean, ties.method = "min")) %>%
  right_join(data %>% select(-.y), by = ".ri") %>%
  as_tibble() %>%
  ctx$addNamespace() %>%
  ctx$save()
 