#
# Import data from pangaea via API
# with Ropensci package pangear
# then generate a ggplot
#
# knb 06/2018
# modern rewrite of script get_from_pangaea.R
#
# code still contains old-school R code, e.g. qplot()

setwd("~/code/git/_my/htmltable_2_R")
library(pangaear)
library(ggplot2)

# Data files are stored in an operating system appropriate location.
# Run this to get the storage location on your machine.
rappdirs::user_cache_dir("pangaear")

# delta O-18 of foraminifers from the central atlantic
#theurl <- "http://doi.pangaea.de/10.1594/PANGAEA.806538?format=html"

# extract a record from pangaes
# Lake Rehwiese near Berlin, col 1 ,2   ages vs depth
doifrag <- "10.1594/PANGAEA.772960"
theurl <- paste0("https://doi.pangaea.de/", doifrag)

dat <- pangaear::pg_data(doi=doifrag)
dat[[1]]$doi
dat[[1]]$citation
dat[[1]]$data

outfile="rehwiese_coordflipped.jpg"

content <- dat[[1]]$data

#Preview results
head(content)
summary(content)


title <- c("Data from pangaea.de", theurl)
#where to place long intra-panel text?, origin
#ty = -7.5 - 0.5
#tx = 11900

# create multiline, aligned text
wrapper <- function(x, ...) paste(strwrap(x, ...), collapse = "\n")

p <- qplot(content$`Depth [m]`, content$`Varve age [a BP]`,
  color = I("tomato"), size = I(0.5),
  ylab = names(content)[2], xlab = names(content)[1],
  main = wrapper(title, width = 26)
)
p <- p + coord_flip() + scale_x_reverse()
#p <- p + annotate("text", x = tx, y = ty, label = wrapper(citation, width = 50)) #+ guides(colour = guide_legend(title.hjust = 0.5))
# optional.. add
p <- p + geom_smooth(method = lm, se = FALSE, size=0.5) # Add linear regression line
# the equation label - very confusing with coords flipped
#p <- p + geom_text(aes(y = 12000, x = 8 ,#max(y) - 300
#                       label = lm_eqn(data.frame(content))), parse = TRUE) #p + theme_bw()
p <- p + geom_text(aes(y = 12000, x = 8.25 ,#max(y) - 300
                       label = sprintf("Sedimentation Rate:\n~1.33 mm/year (2000mm/1500 yr)\nn = %s measurements",
                       nrow(content)))) #p + theme_bw()

print(p)
ggsave(file=outfile, dpi=72)

