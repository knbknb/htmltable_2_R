htmltable_2_R
=============

**This simple R script from 2013 is about learning to get web-data into R, and to create plots. Quite an experience for me, back when I just started using R.**

Import science-data directly from the internet, via screen-scraping, then generate a simple X-Y-scatterplot using the qplot() function of the popular *gglot2* library. *(Update 2017: I would do this differently now)*

Geological data are fetched from the science-data repository http://pangaea.de, using *Rcurl*. The R code selects the HTML table on the page with an xpath expression, creates a data frame, generates the simple X-Y plot. 
At this time, only a single column is plotted.

The sample dataset - ages of sediment layers  from Lake Rehwiese near the Berlin/Brandenburg area- 
 is simple+small. This geochronology data is easy to understand, and has some relevance to my work.

For other data sets from pangaea.de, or to select other columns: - Must change the source code. There is no other way at this time.

A sample [outfile (in JPG Format)](/rehwiese.jpg) is attached. 

![Plot](rehwiese.jpg)

Again, I was not involved in creating this dataset, I just selected it because of its small size and simple structure. I'm not interpreting the data here.


Todo: make the xpath-expression, and the selection of columns in the plot, a command line option

