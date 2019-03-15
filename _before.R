# Run before each chapter:

rm(list = ls())
set.seed(789)

options(digits = 2)
options(max.print = 8)

knitr::opts_chunk$set(
  collapse = TRUE,
  fig.align = 'center',
  fig.show = "hold",
  fig.width = 5,
  cache = F
)

