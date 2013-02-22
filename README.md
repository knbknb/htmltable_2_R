htmltable_2_R
=============

**This simple R script is just a proof-of-concept of getting web-data into R. Another learning experience for me.**

Import science-data directly from the internet, via screen-scraping, then generate a simple X-Y-scatterplot using the qplot() function of the popular *gglot2* library.

Geological data are fetched from the science-data repository http://pangaea.de, using *Rcurl*.

select the HTML table on the page with an xpath expression, create a data frame, generate the simple X-Y plot. 

At this time, only a single column is plotted.

The sample dataset - ages of sediment layers  from Lake Rehwiese near the Berlin/Brandenburg area- 
 is simple+small, it is easy to understand, and has some relevance to my work.

For other data sets from pangaea.de, other columns must be selected and plotted - Must adapt the source code. 

A sample [outfile (in JPG Format)](/rehwiese.jpg) is attached.

Todo: make the xpath-expression, and the selection of columns a command line option

