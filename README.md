htmltable_2_R
=============
Another learning experience for me.

Import data directly from the internet, via screen-scraping, then generate a quick plot in R.

This simple R script is just a proof-of-concept of how to get web data into R. 

Then a simple plot is generated with the popular gglot2 library.

Geological data are fetched from the science-data repository http://pangaea.de, using curl

select the HTML table on the page with an xpath expression, create a data frame, generate a simple X-Y plot. 

At this time, only a single column is plotted.

The sample dataset was chosen because it is from the Berlin/Brandenburg area, 
it is simple+small, it is easy to understand, and has some relevance to my work.

For other data sets from pangaea.de, other columns must be selected and plotted - Must adapt the source code. 

A sample outfile (in JPG Format) is attached.

Todo: make the xpath-expression, and the selection of columns a command line option

