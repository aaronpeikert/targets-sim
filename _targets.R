options(tidyverse.quiet = TRUE)
library(targets)
library(tidyverse)
library(future)

source(here::here("funs.R"))

plan(multisession)
tar_option_set(error = "save")
tar_pipeline(tar_target(n, c(10, 20)),
             tar_target(k, c(10, 20)),
             tar_target(seeds, withr::with_seed(1123, gen_seed(10))),
             tar_target(raw, continued_testing(k, n, seeds),
                        pattern = cross(k, n, seeds)),
             tar_target(tidy, unnest(mutate(crossing(k, n, seeds), p = raw)))
             )
