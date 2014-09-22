# 
# Import data directly from the internet, via screen-scraping, then
# generate a quick plot in R
# $Id: get_from_pangaea.R 3638 2014-09-22 11:09:48Z knb $
# 
# developed for ggplot2 0.8.9
# also works on ggplot2 0.9.3

setwd("some dir")

library("XML")
library(RCurl)
library(ggplot2)

# GET EQUATION AND R-SQUARED AS STRING
# SOURCE: http://goo.gl/K4yh
lm_eqn = function(df){
  m = lm(y ~ x, df);
  eq <- substitute(italic(y) == a + b %.% italic(x)*","~~italic(r)^2~"="~r2, 
                   list(a = format(coef(m)[1], digits = 2), 
                        b = format(coef(m)[2], digits = 2), 
                        r2 = format(summary(m)$r.squared, digits = 3)))
  as.character(as.expression(eq));                 
}

# create multiline text for aligned text
wrapper <- function(x, ...) paste(strwrap(x, ...), collapse = "\n")

#theurl <- "http://en.wikipedia.org/wiki/Brazil_national_football_team"
# extract a record from pangaes
# Lake Rehwiese near Berlin, col 1 ,2   ages vs depth
theurl <- "http://doi.pangaea.de/10.1594/PANGAEA.772960?format=html"
n1 = 2
n2 = 1




outfile="rehwiese.jpg"
#
# delta O-18 of foraminifers from the central atlantic
# choose 
#theurl <- "http://doi.pangaea.de/10.1594/PANGAEA.806538?format=html"
#n1 = 2
#n2 = 3
#tx = -4
#ty = -50


webpage <- getURL(theurl)


pagetree <- htmlTreeParse(webpage, useInternalNodes = TRUE) #error=function(...){}, 

# Extract table header and contents
#//table[@class='dditable']/tbody/tr/th
# //div[@class='MetaHeaderItem']/big/text()

# For pangaea, these are constant as of 2013
citation <- xpathSApply(pagetree, "//div[@class='MetaHeaderItem']/big", function(x) xmlValue(x))
title <- "Data from www.pangaea.de"  #xpathSApply(pagetree, "//div[@class='MetaHeaderItem']/big/text()", function(x) xmlValue(x))
tablehead <- xpathSApply(pagetree, "//table[2]//tr/th/span", function(x) xmlValue(x))
results <- xpathSApply(pagetree, "//table[2]//tr/td", function(x) xmlValue(x))

# Convert character vector to dataframe

content <- as.data.frame(matrix(results, ncol = 4, byrow = TRUE))

#mode(content) <- "numeric"

content = t(apply(content, 1,as.numeric))
colnames(content) = tablehead
# Clean up the results
# not always necessary

#Preview results
head(content)
summary(content)



rm(p)
x <- content[,n2]
y <- content[,n1]
xlabel = colnames(content)[n2]
ylabel = colnames(content)[n1]
#opts(axis.text.x=theme_text(size=10))
#opts(axis.text.y=theme_text(size=10))
title <- paste0(title, ", n = ", nrow(content), " measurements", "\n", theurl)
#where to place long intra-panel text?, origin 
ty = -7.5 - 0.5
tx = 11900
# xmin=0, ymax=0, 
p <- qplot(  y, -x, ylab= xlabel, xlab= ylabel, main = wrapper(title, width=26))
p = p + annotate("text", x = tx, y = ty, label = wrapper(citation, width=50)) #+ guides(colour = guide_legend(title.hjust = 0.5))
# optional.. add 
p <- p +   geom_smooth(method=lm, se=TRUE)     # Add linear regression line
p <- p  + geom_text(aes(y = -6.4, x = 12500, label = lm_eqn(data.frame(content))), parse = TRUE)                       
#p + theme_bw()
print(p)
#ggsave(file=outfile, dpi=72)

