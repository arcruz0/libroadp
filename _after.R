packages <- sapply(sessionInfo()$otherPkgs, function(x) x$Package)
packages <- sapply(packages, function(p) paste0("package:", p))
lapply(packages, detach, character.only = TRUE, unload = TRUE)

rm(list = ls())
gc()