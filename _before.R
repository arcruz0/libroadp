set.seed(123)

options(digits = 2, max.print = 20, width = 73,
        tibble.width = 73,
        tibble.print_max = 3, tibble.print_min = 3, tibble.max_extra_cols = 0)

knitr::opts_chunk$set(
  collapse = T,
  eval = T,
  fig.align = 'center',
  fig.show = "hold",
  fig.width  = 4,
  fig.height = 3,
  cache = F,
  message = F
)

library(ggplot2)

theme_set(cowplot::theme_cowplot(font_size = 11) +
            theme(legend.position = "top",
                  legend.justification = "right",
                  legend.key.size =  unit(0.2, "inches"),
                  legend.margin = margin(0, 0, 0, 0),
                  legend.box.margin = margin(-5, 10, -10, -10)))
