R
=

## Installing

 * [UBUNTU PACKAGES FOR R](https://cran.r-project.org/bin/linux/ubuntu/).
 * [How to install R on Ubuntu and Debian](https://www.linode.com/docs/development/r/how-to-install-r-on-ubuntu-and-debian/).

Under macOS, run:
```bash
brew tap homebrew/science
brew install r
```

There exists a GUI application downloadable [here](http://www.cran.r-project.org).
On macOS, to uninstall it run:
```bash
rm -rf /Library/Frameworks/R.framework /Applications/R.app /usr/bin/R /usr/bin/Rscript
```

Under Debian/Ubuntu:
```bash
apt-get install r-base
```

To get the latest R version under Ubuntu, setup the CRAN package repository.
Add the following line to `/etc/apt/sources.list` file:
	deb http://cran.stat.unipd.it/bin/linux/ubuntu zesty/
And run:
```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
sudo apt-get update
```

To get the latest version under Debian, see [Debian Packages of R Software](http://cran.univ-paris1.fr/bin/linux/debian/).

## Running

Execute specified file:
```bash
R -f myfile
```

Don't print startup message:
```bash
R -q ...
```

Print neither startup message, nor lines of program:
```bash
R --slave ...
```

For running from a standalone script, use the following shebang:
```r
#!/usr/bin/env R --slave -f
```

To pass arguments:
```bash
R --args ...
```

To run a script, use preferably the `Rscript` executable:
```bash
Rscript myscript.R
```

Another way to run a script:
```bash
R CMD BATCH myscript.R
```

Quit:
```r
q()
q(status = 1)
quit()
quit(status = 1)
```

## Variables & Types

### Assignment

Local assignment:
```r
a <- 3
```
It creates a local object.

Non-local assignment:
```r
n <<- 100
```
Used in OOP, to modify a field's value.

Assigning dynamically:
```r
assign("varname", value, pos = .GlobalEnv) # create a new variable varname in global environment.
```

Getting dynamically the value of a variable:
```r
x <- get("myvar")
```


### NA

This i a logical value of length 1:
```r
NA # means Not Available
```

Constants for other atomic vector types:
```r
NA_integer_
NA_real_
NA_complex_
NA_character_ 
```

Testing:
```r
is.na(myvar)
```

Affecting inside a vector:
```r
(xx <- c(0:4))
is.na(xx) <- c(2, 4)
xx                     #> 0 NA  2 NA  4
```

### NULL

 * [R : NA vs. NULL](http://www.r-bloggers.com/r-na-vs-null/).

Test:
```r
is.null(myvar)
```

Convert:
```r
as.null(myvar) # --> returns NULL whatever is passed to it
```

### Strings

Getting the length of a string:
```r
l = nchar(s)
```

Concatenate strings:
```r
s <- paste(s1, s2, sep="")
s <- paste(s1, s2, s3, s4, sep="")
```
Be careful, by default the separator ('sep' argument) is the space character.

Getting a substring (the first 100 characters):
```r
s <- substr(s, 1, 100)
```

Putting to lower or upper case
```r
s <- tolower(s)
s <- toupper(s)
```

Getting character code:
```r
charToRaw('A') # Returns a string containing the hex code of A.
```

Repeat a character or string n times:
```r
paste(rep(s, 3), sep = '')
```

Pading character strings:
```r
stringr::str_pad(c('abc', 'defghi', '', 'jk'), width = 10, side = 'right', pad = ' ')
```

#### Reading/writing from/to a string

Write a data frame into a string:
```r
my.dataframe <- data.frame(a = c(1,2), b = (4.10, 10.6))
writetc <- textConnection("my.string", "w", local = TRUE)
write.csv(my.dataframe, writetc)
```

Read a data frame from a string:
```r
readtc <- textConnection("my.string", "r", local = TRUE)
df <- read.csv(readtc)
```
or
```r
df <- read.table(text = my.string) 
```

#### Substrings

Substring extraction:
```r
substr(text, start, stop)
substring(...)
```

Substring replacement:
```r
substr(text, start, stop) <- s
```

#### Split & join

Spliting:
```r
v = strsplit(s, " *;") # Split all strings in vector s, and returns a list of vectors of strings.
v = strsplit(s, " +", perl = TRUE) # Use PERL style
v = strsplit(s, " ", fixed = TRUE) # Do not use regex
```

Joining:
```r
s <- paste(v, collapse = " ")
```

#### Trimming

Trimming leading white spaces:
```r
trim.leading <- function (x)  sub("^\\s+", "", x)
```

Trimming trailing white spaces:
```r
trim.trailing <- function (x) sub("\\s+$", "", x)
```

Trimming leading and trailing white spaces:
```r
trim <- function (x) gsub("^\\s+|\\s+$", "", x)
```


#### Search, replace and regex

Replacing with regexp:
```r
result <- sub('\\.in$', '.out', variable)    # replace first occurence only
new_str <- sub('^.*/([^/]+)$', '\\1', str, perl = TRUE)
result <- gsub('\\.in$', '.out', variable)   # replace all occurences
```

`grep`:
```r
grep("blabla", df) # returns a list of indices
length(grep("blabla", df)) > 0
grep("blabla", df, value = TRUE) # returns a the matched elements of the vector 
```

`grepl` searches for regexp in vector, and returns a vector of booleans:
```r
if (grepl("^blabla", my_string, perl=TRUE)) do_something()
grepl("^blabla", c(s1, s2, s3), perl=TRUE) # --> returns a vector
```

Get index of first match:
```r
pos <- regexpr('\\.[a-z]', 'zap.plouf.hop', perl = TRUE)[[1]]
index <- as.integer(pos)
```

Get indices of all matches:
```r
pos <- gregexpr('\\.[a-z]', 'zap.plouf.hop', perl = TRUE)[[1]]
indices <- as.integer(pos)
```

Extracting substrings:
```r
library(stringr)
str_extract("blabla lala", "la") # search once for the regexp
str_extract_all("blabla lala", "la") # search several times for the same regexp: returns a list
```

Searching for groups:
```r
library(stringr)
str_match("id=1244 id=3939", "id=([0-9]+)") # Return the first match in the form of a list: first is the whole, then the groups
str_match_all("id=1244 id=3939", "id=([0-9]+)") # Return all matches in the form of a matrix: first column is the whole match, then the groups
```

Ignoring case:
```r
str_match(str_vect, ignore.case(pattern))
```

Matching also new lines and carriage return with `.`:
```r
match <- stringr::str_match(xml, stringr::regex('^(.*)(<metabolite>.*</metabolite>)(.*)$', dotall = TRUE))
```

### Array

Arrays are objects that have 1 or more dimensions. Matrix is a special case of arrays.

Create an array 4x5, initialized with integer values from 1 to 20:
```r
A<-array(1:20,dim=c(4,5))
```

A 3D array:
```r
arr <- array(data = c(m1, m2), dim = c(3,2,2)) # construct a 3D array from two 3x2 matrices.
```

Test if two arrays are equal:
```r
isTRUE(all.equal(A, B, tol=0))  # tol is tolerance
```

Example of operations on a array:
```r
x <- c(1:10)
x[(x>8) | (x<5)]
```
yeilds 1 2 3 4 9 10.

Another example which counts the number of elements of an array which are <= 1:
```r
p <- sum(v <= 1) # where v is an array
```

### Floating number

By default a number is a floating number (called numeric in R):
```r
x <- 21
```

### Integer

Define an integer value
```r
i <- 25L
```

Maximum of an integer value:
```r
.Machine$integer.max # 2147483647 (2^31-1).
```
For both negative and positive values.

`numeric` type can store bigger integer values:
```r
2 ** .Machine$double.digits
```

Integer division:
```r
5 %/% 2
```

Modulo:
```r
5 %% 2
```

### Vector

Elements of a vector can be of the following types: logical, integer, double, complex, character and raw.

Vectors are also called "atomic vectors", to distinguish them from list (called "generic vectors" or "recursive vectors")

Create a vector with integers from 1 to 10:
```r
x <- c(1:10)
```

Length of a vector:
```r
length(x)
```

Create a vector x:
```r
x <- c(10.5, 9.3, 10.2, 4.1)
assign("x", c(10.5, 9.3, 10.2, 4.1))
c(10.5, 9.3, 10.2, 4.1) -> x
y <- vector(length = 2)
y <- vector(mode = 'integer', length = 0)
a <- numeric()
y <- 5:8
y <- 5:1
y <- seq(from = 12, to = 30, by = 3) # 12 15 18 21 24 27 30
y <- seq(from = 1.1, to = 2, length = 10)
y <- rep(8,4) # 8 8 8 8
y <- rep(c(1,2),4) # 1 2 1 2 1 2 1 2
y <- rep(c(5,12,13), each = 2) # 5 5 12 12 13 13
```

Empty vector:
```r
numeric()
character()
```

Condition on vector elements:
```r
ifelse(v, 'A', 'B')
```

Concatenating vectors:
```r
y <- c(x, 0, x)
y <- c(1, 2, c(6, 7)) # gives 1 2 6 7. Vectors are flattened.
```

Appending to a vector:
```r
a <- c(a, 2)
```

Getting value:
```r
v[4]
```

Setting value:
```r
v[5] <- 19
```
Attention, this operation may involve a reassignment of v (i.e.: a creation of a new vector and destruction of this old). As a matter of fact, what happens is that the operator/function [<- is called as is :
```r
v <- "[<-"(v, 5, value = 19)
```
This should trigger a reassignment, but in fact R tries to avoid this and modify the vector in-place.
 - d[1] is first dimension (nb rows, since matrices are stored in column-major mode)
 - d[2] is second dimension (nb columns)
 - ...

```r
p <- nrow(m) # get number of rows
q <- ncol(m) # get number of rows
```

Getting rows:
```r
m[1,] # row 1
```

Getting columns:
```r
m[,2] # column 2
```

Removing columns and rows:
```r
m[c(1,3),] # keeps only rows 1 and 3
m[c(-2),] # removes row 2
m[,c(-2)] # removes column 2
```

For inversion of a matrix, see R/LAPACK/ATLAS.

Submatrices:
```r
y[c(1,3),] <- matrix(c(1,1,8,12),nrow=2) # assign values to a submatrix
y[2,, drop = FALSE] # The option drop=FALSE avoid obtaining a vector instead of a matrix in case the resulting submatrix is a 1-by-n or n-by-1 matrix.
```

Multiplication:
```r
m %*% c(1,1)
```

Addition:
```r
m + 10:13 # Since matrices are vectors, we can add a vector of total size nxm to a matrix nxm.
```

Apply:
```r
apply(m, MARGIN = 1, func) # MARGIN is the code for the dimension (1 = rows, 2 = columns). It tells if the function func is applied on rows or columns.
```

Names:
```r
colnames(m) <- c("a", "b")
m[,"a"]
```

Getting duplicated elements:
```r
x <- duplicated(y) # Returns a vector of boolean
```

Getting unique elements (remove duplicates):
```r
x <- y[ ! duplicated(y)]
```

Split a vector in smaller vectors (chunks) of equal size:
```r
chunks <- split(v, ceiling(seq_along(v) / 50))
```

### Lists

Remove values from a list:
```r
mylist <- list(4, 6, 3, 1, 3, 0)
mylist[1,3] <- NULL
```

Set values to NULL in a list:
```r
mylist <- list(4, 6, 3, 1, 3, 0)
mylist[1,3] <- list(NULL)
```

Created a list of repeated values:
```r
mylist = rep(list(NULL), 4)
```

### Data frames

A data frame is a list of vectors, factors or matrices of equal lengths.
It can aso be view as a matrix with columns of different modes.
A data frame can also contain other data frames.

Creation:
```r
n <- c(2, 3, 5) 
s <- c("aa", "bb", "cc") 
b <- c(TRUE, FALSE, TRUE) 
df <- data.frame(n, s, b)       # df is a data frame
```
or
```r
d <- data.frame(kids=c("Jack","Jill"),ages=c(12,10))
d <- data.frame(kids=c("Jack","Jill"),ages=c(12,10), stringsAsFactors=FALSE) # don't create factors
```

Columns and rows can be created at will:
```r
df <- data.frame()
df['zap', 'hop'] <- 4
```

Accessing:
```r
d[[1]] # get first column
d[,1] # get first column
d$kids # get column "kids"
```

A data frame can have a names attribute (for naming columns):
```r
names(my_data_frame)
```

Check that a named column exists:
```r
'mycol' %in% colnames(my_data_frame)
```

Filtering:
```r
examsquiz[examsquiz$Exam.1 >= 3.8,]
subset(examsquiz,Exam.1 >= 3.8)
```

NA values:
```r
mean(x,na.rm=TRUE) # remove NA values when computing the mean.
d4[complete.cases(d4),] # keep only the lines containing no NA values.
```

Apply() can be used on a data frame if all columns are of the same type:
```r
apply(examsquiz,1,max)
lapply(d, sort) # sorts all columns of d individually, and returns a list of the sorted vectors.
```

Appending/inserting a column or a row:
```r
rbind(d,list("Laura",19)) # append a row
examsquiz$ExamDiff <- examsquiz$Exam.2 - examsquiz$Exam.1 # append a column made of a computation on other columns.
d$new_col <- c(1,2) # append a new column and use recycling if c(1,2) is too short compared to the length of columns of d.
```

Using `plyr` library, for appending two data frames with different columns:
```r
library(plyr)
a <- rbind.fill(b, c)
```
If a column is missing in b or in c, it is filled with NA values.

#### Reading

Reading a data.frame from file:
```r
df <- read.table("exams", header=TRUE) # In the header, blanks are replaced with period in names.
all2006 <- read.csv("2006.csv", header=TRUE, as.is=TRUE) # read CSV file. as.is=TRUE disable use of factors (identical to stringsAsFactors=FALSE)
```

Reading a UTF-16 file, with tab separated columns:
```r
df <- read.table("SPI-N1.txt", header=TRUE, stringsAsFactors = FALSE, sep="\t", fileEncoding="UTF-16")
```

#### Writing

```r
write.csv(df, file = "myfile.csv") # period for decimal separator and comma for field separator
write.csv2(df, file = "myfile.csv") # coma for decimal separator and semicolon for field separtor
write.table(df, file = "myfile.tsv", sep = "\t")
write.table(df, file = "myfile.tsv", sep = "\t", row.names = FALSE) # Do not write row names
```

#### Subdata frames

```r
examsquiz[2:5,]
examsquiz[2:5, 2] # returns a vector
examsquiz[2:5, 2, drop=FALSE] # returns a one column data frame
```

### Factors (enum)

```r
gender <- c(rep("male",20), rep("female", 30)) 
gender <- factor(gender) 

mons = c("March","April","January","November","January",
         "September","October","September","November","August",
         "January","November","November","February","May","August",
         "July","December","August","August","September","November",
         "February","April")
mons = factor(mons)
```

There exists an ordered factor where values can be ordered (ex: small, medium, high):
```r
mons = factor(mons,
              levels=c("January","February","March",
                       "April","May","June","July","August","September",
                       "October","November","December"),
              ordered=TRUE)
```

### Table

Compute an histogram: count occurences of each value.

```r
hist <- table(c(1,45,1,6,3,14,45,6,6))
```

## Statements

### Source

Use source() command to include/load another R file:
```r
source('myfile.R')
```

Switch to sourced file directory while sourcing:
```r
source('../../blabla/myfile.R', chdir = TRUE)
```
Before sourcing the file, R will change to directory `../../blabla`.

By default the names parsed and loaded in the sourced file are put inside the global environment. If you want them to reside inside the current environment use:
```r
source('myfile.R', local = TRUE)
```
or if you want to load them into another environment:
```r
source('myfile.R', local = myenv)
```

Get the path of the current sourced file:
```r
current.file.path <- parent.frame(2)$ofile
```

#### Loading module relativily to script path

Solution 1:
```r
args <- commandArgs(trailingOnly = F)
scriptPath <- dirname(sub("--file=","",args[grep("--file",args)]))
source(file.path(scriptPath, '../input-parser/InputExcelFile.R'), chdir = TRUE)
```

Solution 2:
```r
#- Get path of current R script to source using a relative directory:
source(file.path(dirname(rscript_current()), '../myfile.R'))
#- Where rscript_current is:
rscript_current <- function() {
	stack <- rscript_stack()
	r <- as.character(stack[length(stack)])
	first_char <- substring(r, 1, 1)
	if (first_char != '~' && first_char != .Platform$file.sep) {
		r <- file.path(getwd(), r)
	}
	r
}
```
### For

Loop on a list or vector:
```r
for (x in list.or.vector) {
}
```

Best way to iterate on all indices of a vector:
```r
for (i in seq_along(v))
	v[i] <- compute(v[i], i)
```
`seq_along` is the same as `seq(along.with = v)`, which means it will use the length of the argument (i.e.: length of vector `v`).

*Wrong* way to iterate on all indices of a vector:
```r
for (i in seq(v))
	v[i] <- compute(v[i], i)
```
There will be no iteration if `length(v) == 0`. Also if v is a single integer, it will be interpreted as the number of integers to generate.

How to break / continue:
```r
break
next
```

### If / else

`if()` is a function in R.
```r
if (TRUE) x <- 2 else x <- 10
```

Logical negation:
```r
if ( ! condition) ...
```

Ternary operator using if/else:
```r
x <- if(a==1) 1 else 2 # <=> x = a == 1 ? 1 : 2
```

The `else` clause must appear at the end and on the same line than the `then` clause:
```r
if (...) do_1() else do_2()
```
or
```r
if (...) {
	do_1()
} else {
	do_2()
}
```

### Switch

Value must not be null, and must be a vector of length 1.
The possible values (str1, str2) must be strings and not integer. If these are integers, they must be quoted in order to be strings.
```r
switch(value, # value to test
       str1 = EXPR,
       str2 = EXPR,
       EXPR # default
       )
```

## Operators

 * [Operator Syntax and Precedence](https://stat.ethz.ch/R-manual/R-devel/library/base/html/Syntax.html).

Arithmetic operators:

Operator  | Description
--------- | ----------------------
`+`       | Addition.
`-`       | Subtraction.
`*`       | Multiplication.
`/`       | Division.
`^`, `**` | Exponentiation.
`%%`      | Modulus (x mod y) 5%%2 is 1.
`%/%`     | Integer division 5%/%2 is 2.

Logical operators:

Operator    | Description
----------- | --------------------------
`<`	        | Less than.
`<=`        | Less than or equal to.
`>`	        | Greater than.
`>=`        | Greater than or equal to.
`==`        | Exactly equal to.
`!=`        | Not equal to.
`!`         | Not.
`|`         | Or.
`&`         | And.
`isTRUE(x)` | Test if x is TRUE.

## Maths

Logarithm:
```r
log10(x)
```

Power:
```r
10^3
```

Integer division:
```r
5 %/% 2
```

Truncating integer:
```r
trunc(1.23)
floor(1.23)
```

Find roots of an equation:
```r
f <- function(x) x - 300 - x^0.8
uniroot(f, c(300, 1200))
```

## Packages

Getting information about loaded packages (package version, ...) in a session:
```r
sessionInfo()
```

Getting version of package:
```r
packageVersion('biodb')
```

### Installing packages

R packages can be found on [CRAN](http://cran.r-project.org/) web site.

Select CRAN mirror:
```r
chooseCRANmirror()
chooseCRANmirror(graphics = FALSE) # Avoid opening of X11 window when selecting mirror site:
```
CRAN mirror can be set permanently inside `.Rprofile` configuration file. See <https://stackoverflow.com/questions/8475102/set-default-cran-mirror-permanent-in-r>.

Installing a CRAN package:
```r
install.packages("pkgname")
```

Install with all dependencies:
```r
install.packages("pkgname", dependencies = TRUE)
```

For installing a particular place (like some system path, for system wide installation), first look at the list of available destination directories:
```r
.libPaths()
```
then choose the destination you want by using the `lib` option:
```r
install.packages("pkgname", lib = .libPaths()[2])
```

For installing in user home directory, see `.libPaths()` documentation. On Ubuntu with R 3.4, the following directory needs to be created:
```bash
mkdir -p $HOME/R/x86_64-pc-linux-gnu-library/3.4
```
This is the default value of the `R_LIBS_USER` environement variable for R under Linux.
For macOS:
```bash
mkdir -p $HOME/Library/R/3.4/library
```

Installing a package from source:
```r
install.packages('RMySQL', type='source')
```

Installing a package from local source bundle:
```r
install.packages('C:/RMySQL.tar.gz', repos = NULL, type='source')
```

Installing using the command line:
```bash
R -e "install.packages('getopt', dependencies = TRUE, repos='https://cloud.r-project.org/')"
```

Getting a list of installed packages:
```r
rownames(installed.packages())
```

See also devtools package.

### Removing packages

```r
remove.packages("rJava")
```

### Loading packages

List available packages:
```r
library()
```

Load package:
```r
library(mypackage)
```
`library()` gives an error if the package can not be loaded.

```r
if (require(mypackage)) {
	# stuff to do
}
```
`requires()` returns `FALSE` and gives a warning if the package can not be loaded. It is designed to be used inside a function.

Non-verbose loading:
```r
library(RMySQL, quietly = TRUE)
```

Test if a package is loaded:
```r
library(R.utils)
isPackageLoaded('mypkg')
```

### Creating packages

 * [Programmation en R : incorporation de code C et création de packages, Sophie Baillargeon, Université Laval](http://www.math.univ-montp2.fr/~pudlo/documents/ProgR_AppelC_Package_210607.pdf).
 * [Creating R Packages: A Tutorial, Friedrich Leisch](https://cran.r-project.org/doc/contrib/Leisch-CreatingPackages.pdf).
 * [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html).
 * [Who Did What? The Roles of R PackageAuthors and How to Refer to Them](https://journal.r-project.org/archive/2012-1/RJournal_2012-1_Hornik~et~al.pdf).

 * [How to Install R Packages using devtools on Ubuntu 16.04](https://www.digitalocean.com/community/tutorials/how-to-install-r-packages-using-devtools-on-ubuntu-16-04).

 * `R CMD check`: [Automated checking](http://r-pkgs.had.co.nz/check.html).
 * How to write tests for a package: [Writing tests](http://kbroman.org/pkg_primer/pages/tests.html)
 * [The DESCRIPTION file](http://www.hep.by/gnu/r-patched/r-exts/R-exts_4.html).
 * [Package Development Prerequisites](https://support.rstudio.com/hc/en-us/articles/200486498-Package-Development-Prerequisites).

#### Writing a vignette

 * [Writing package vignettes](http://cran.fhcrc.org/doc/manuals/R-exts.html#Writing-package-vignettes).
 * [Authoring R Markdown vignettes with Bioconductor style](https://bioconductor.org/packages/3.7/bioc/vignettes/BiocStyle/inst/doc/AuthoringRmdVignettes.html).

On macOS, for building vignettes with `R CMD build .`, install first the [MacTeX LaTeX](http://www.tug.org/mactex/) distribution.

Example of header for an Rmd vignette using knitr package and BiocStyle package:
```rmd
 ---
 title: "Configuring biodb"
 author: "Pierrick Roger"
 output:
   BiocStyle::html_document:
 #    toc_float: true    # TOC implies enabling a theme.
     theme: null         # A theme uses around 700KB.
 #    highlight: null     # Highlighting uses around 60KB.
 #    mathjax: null
 package: biodb
 abstract: |
   How to configure biodb package.
 vignette: |
   %\VignetteIndexEntry{Configuring biodb}
   %\VignetteEngine{knitr::rmarkdown}
   %\VignetteEncoding{UTF-8}
 ---
```

Here is the settings to put insisde the `DESCRIPTION` file:
```
VignetteBuilder: knitr
Suggests:
	BiocStyle,
	knitr,
	rmarkdown
```

#### Writing documentation with roxygen2

 * [Generating Rd files](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd.html).
 * [Object documentation](http://r-pkgs.had.co.nz/man.html).
 * [How to properly document S4 class slots using Roxygen2?](http://stackoverflow.com/questions/7368262/how-to-properly-document-s4-class-slots-using-roxygen2).

Note that constructors of subclasses are ignored by roxygen2. You cannot document them.

Defining documentation separated from any code:
```r
 #' Title 
 #' 
 #' Other stuff 
 #' 
 #' @name MyClass_fooey 
 #' @param foo_value numeric blah blah blah 
 #' @return numeric 
 #' @examples{ 
 #'	\dontrun{ 
 #'	blah blah blah 
 #'      } 
 #' } 
NULL 
```

#### Submitting to CRAN

 * [Getting your R package on CRAN](http://kbroman.org/pkg_primer/pages/cran.html).
 * [CRAN Repository Policy](https://cran.r-project.org/web/packages/policies.html).
 * [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html).

#### Submittin to Bioconductor

 * [Coding Style](https://bioconductor.org/developers/how-to/coding-style/).

#### The `inst/` folder

 * [Installed files](http://r-pkgs.had.co.nz/inst.html).
 
## Compiling code

 * [Compile Files for Use with R](https://stat.ethz.ch/R-manual/R-devel/library/utils/html/COMPILE.html).

To compile C source files into a shared library:
```bash
R CMD SHLIB *.c
```

## Home

Get R HOME directory:
```r
R.home()
```

## R environments and namespaces

 * [Environments](http://adv-r.had.co.nz/Environments.html).
 * [Environments in R](https://www.r-bloggers.com/environments-in-r/).
 * [How R Searches and Finds Stuff](http://blog.obeautifulcode.com/R/How-R-Searches-And-Finds-Stuff/).

Global environment (i.e.: working environment):
```r
globalenv()
```

Base environment (i.e.: the environment of the base package):
```r
baseenv()
```

Empty environment (the parent of the base environment):
```r
emptyenv()
```

Current environment:
```r
environment()
```

List all parents of the global environment:
```r
search()
```

Getting an environment from its name/string:
```r
as.environment('package:stats')
```

Get parent environment:
```r
parent.env(e)
```

Accessing a variable in an environment:
```r
e$myvar
```

Modifying a variable inside an environment:
```r
e$myvar <- 'myval'
```

Find the environment where a name is defined:
```r
pryr::where('myname')
```

List objects in an environment:
```r
ls()
objects()
```

Remove objects in an environment:
```r
rm(myvar)
remove(myvar)
```

## Command line arguments

```r
args <- commandArgs(trailingOnly = TRUE)
my_first_arg = args[1]
```
The option `trailingOnly` keeps only arguments after `--args` flag.

Getting script path, script name and script directory:
```r
args <- commandArgs(trailingOnly = FALSE)
script.path <- sub("--file=", "", args[grep("--file=", args)])
script.name <- basename(script.path)
script.dir <- dirname(script.path)
```

## Environment variables

Get all env vars:
```r
ENV = Sys.getenv()
```

Set env var:
```r
Sys.setenv(MY_VAR = "value", MY_VAR2 = "value2")
```

## Data

The data() function loads specified data sets, or list the available data sets.

Loading unknown data set into a separate environment in order to check what is inside:
```r
data(crude, verbose = TRUE, envir = e <- new.env())
ls(e) # check what is in `e`
class(e$crude)
summary(e$crude)
rm(e)
```

Load into workspace:
```r
data(crude)
```

## Load data

Load data from a plain text file with lines like:
1224.233 1228.12e12
and put result in a list
```r
mylist <- scan(file="myfile.txt", what=list(t=0.0, f=0.0))
```

See also `read.table()` in DATA FRAMES.

## Equality

Testing elements of a vector:
```r
x < 8 # returns a vector of logical values
all(x < 8) # returns true if all elements of x are < 8
all(v == w) # returns true if v and w are equals.
identical(v, w) # returns true if v and w are identical (same type, same values). A vector of integers won't be identical to a vector of floating points even if values are equal.
any(x < 8) # returns true if at least one element of x is < 8
```

## I/O

### dput and dget

`dput` and `dget` are used to serialize and deserialize an R object.

### File information

Get file size:
```r
sz <- file.info(myfile)$size
sz <- file.size(myfile)  # Only available from R 3.3.
```

### Loading vector from a file

```r
scan(file = "myfile.txt", what = integer())
```

### Saving vector to a file

```r
write(v, 'myfile.txt', ncolumns = 1)
```

### Reading from a file

Read all characters from a file and put them into a string:
```r
s <- readChar(filename, file.info(filename)$size)
```

Read lines:
```r
lines <- readLines(filename)
```

### Reading from stdin

Reading strings from stdin:
```r
con <- file("stdin")
strings <- readLines(con)
close(con) # close stdin to avoid warning message "closing unused connection 3 (stdin)"
```

Reading floats from stdin:
```r
values <- as.numeric(readLines(file("stdin")))
```

Reading line by line stdin:
```r
con <- file("stdin")
open(con)
while (TRUE) {
	line <- readLines(con, n = 1)
	if (length(line) == 0)
		break
}
close(con)
```

### Writing to a file

```r
cat(..., file = "myfile.txt")
write(x, file = "myfile.txt")
writeLines(content, file.path)
```

### Default output

Redirect output to a file:
```r
sink("myfile")
```

Redirect to console again:
```r
sink()
```

### Printing

Print a variable:
```r
print(myvar)
```

`str` (structure) prints an object in a compact mode:
```r
str(myobject)
str(mylist)
```

`cat` print as is (without all the transformations print() makes):
```r
cat('Computed PI=',pi,'\n');
```

Print on standard error stream:
```r
write("prints to stderr", stderr())
write("prints to stderr", file = stderr())
```

Print information about an object (field length, field mode, ...):
```r
summary(myobject)
```

Print double values (control number of printed decimals):
```r
print(83.247837878523745) # will be truncated on output

options(digits=22) # now will display all decimals of our number
print(83.247837878523745)
```

## Base functions

### vapply

Apply a function on a list or vector, and returns a vector of a defined type:
```r
myvector = vapply(mylist_or_vector, function(x) paste(x, 'some text'), FUN.VALUE = '')
```

### Filter

Filter values of a list or vector:
```r
mynewlist <- Filter(function(x) ! is.null(x), mylist)
```

### cbind / rbind & Typeg

Combine vector, matrix or data frame by row or columns.

```r
m <- rbind(c(1,4),c(2,2)) # rbind = row bind
m <- cbind(c(1,4),c(2,2)) # cbind = column bind
```

If you encounter the warning message "row names were found from a short variable and have been discarded" with cbind, this means that one of the input has row names and that rows need to be duplicated. To avoid this warning, discard the row names by using the `row.names` option:
```r
z <- cbind(x, y, row.names = NULL)
```

Adding columns and rows to a matrix
```r
rbind(rep(1, dim(m)[1]), m) # insert a row of 1s at top.
cbind(rep(1, dim(m)[2]), m) # insert a column of 1s at left.
```

### Merge

Merging data frames (equivalent of SQL join):
```r
merge(d1, d2) # try to find a column C in common, and only keep rows whose values of C are in d1 and d2.
merge(d1, d2, by.x="col1", by.y="col2") # specify explicitly the columns
```

By default merge will make an exclusive join, and thus will eliminate rows that are only in one of the data frames. To keep those rows:
```r
merge(d1, d2, all = TRUE) # keep single rows of both d1 and d2.
merge(d1, d2, all.x = TRUE) # keep single rows from d1.
merge(d1, d2, all.y = TRUE) # keep single rows from d2.
```

## Throwing an error and catching

```r
stopifnot(cond1, cond2, ...)
```

Try / catch:
```r
tryCatch(expr = stop('Error'), finally = print('Hello!'))
```

## Eval

Evaluate an expression contained in a string:
```r
a <- 1
x <- eval(parse(text="1+4+a"))
```

## Function

Declaring a function:
```r
myfunc <- function(n) {
	return(n+5)
}
```

Arguments can have default values:
```r
myfunc <- function(a, b = 2, c = FALSE) {
}
```

Returning a value:
```r
return(n) # Can be used at any place in the function
return() # idem
```
The last value of the function is returned.
If the caller doesn't assign the returned value of a function, then it's printed. To avoid this behaviour, use the invisible primitive:
```r
invisible(x)
return(invisible(x))
```

Returning multiple values:
```r
list[a, b] <- myfunc(c) # myfunc returns a list with two values.
list[, b] <- myfunc(c) # we only want the second value
```

Calling a function from its name as a string:
```r
do.call("my_func", list(arg1, arg2, arg3))
```
or calling it from its name/variable:
```r
myfunc <- function(x,y) x+y
do.call(myfunc, list(x=1, y=2))
```

Test if a function exists:
```r
exists('my_func', mode = 'function')
```

Construct a call as a string that can be evaluated with `eval`:
```r
my_str_call <- call("my_func", arg1, arg2, arg3)
eval(call("my_func", arg1, arg2, arg3))
```

Ellipsis:
```r
foo <- function(x, ...) {
	foo2(z = x, ...)
}
```

## Error handling & debugging

Throwing an error:
```r
stop("Bad bad error !") # Print message on stderr and quit function immediatly
stopifnot(cond1, cond2, cond3, ...) # quit if conditions are not satisfied. No possibility of leaving a message.
```
To have traceback printed when an error occur, we must provide a user defined function:
```r
options(error = function() { traceback(2) ; q(status = 1) } )
```

To have warnings treated as errors, set the `warn` option to 2:
```r
options(error = function() { traceback(2) ; q(status = 1) }, warn = 2 )
```

Printing a warning:
```r
warning("This was wrong...") # Print message
```
Warning are not displayed by default.
To display them as they occur:
```r
options(warn = 1)
```
To treat them as errors:
```r
options(warn = 2)
```
By default `warn` is set to 0, which means that warnings are stored until the top-level function returns. In order to display all stored warnings, you need to call the `warnings()` method at the end of your code:
```r
warnings()
```

Suppressing warnings like for instance "NAs introduced by coercion":
```r
suppressWarnings(as.integer('WRONG'))
```

Call a function and display all errors on stderr without failing:
```r
try(my_function(a,b,c))
```

### Error during wrapup

`Error during wrapup: one of "yes", "no", "ask" or "default" expected.`
An `Error during wrapup` happens when inside the error callback function defined with `options(error = ...)` (see upon).
The message `one of "yes", "no", "ask" or "default" expected.` is due to the fact that a bad value is passed to the save parameter if the `quit()` method.

## Memory

Get pointer/reference of an object:
```r
tracemem(x)
```

Getting reference count:
```r
library(pryr)
address(x) # reference
refs(x) # reference ocunt
```

## System environment variables

Getting all system environment variables, into a hash map:
```r
env <- Sys.getenv()
home <- env[["HOME"]]
```

Getting a selected list of system environment variables, into a regular vector:
```r
env <- Sys.getenv(c("HOME", "USER", "PATH"))
home <- env[[1]]
user <- env[[2]]
path <- env[[3]]
```

## Help

Get help on a function:
```r
help(solve)
?solve
help("[[")
```

Getting help about a package:
```r
help(package=MASS)
```

Search:
```r
help.search(solve)
??solve
```

Get examples:
```r
example(topic)
```

## File system

Current working directory:
```r
wd <- getwd()
setwd(dir)
```

Glob (list files inside current directory):
```r
Sys.glob('*.txt')
Sys.glob(c('*.txt', '*.csv'))
```

Getting current script path:
```r
args <- commandArgs(trailingOnly = F)
script_path <- dirname(sub("--file=","",args[grep("--file",args)]))
```

Test that a file or directory exists:
```r
file.exists(path)
```

Concatenate two paths:
```r
newpath <- file.path(path1, path2)
```

Rename a file:
```r
file.rename(current.file.name, new.file.name)
```

Create a directory:
```r
dir.create(mydir)
```

Remove a directory and its content:
```r
unlink(mydir, recursive = TRUE)
```

Get absolute path:
```r
normalizePath('tmp/..')
```

## System call

```r
system('mycommand')
```

## Workspace

List workspace:
```r
ls()
```

Clear workspace:
```r
rm(list = ls())
```

## Types

Name        Description
---------   --------------------
logical     Boolean.
numeric     Float.
character   String.
vector      A 1-D array of same basic type (logical, numeric, character) elements.
list
matrix
data.frame  A list of vectors of same length.

Testing type:
```r
is.numeric(x)
is.character(x)
is.vector(x)
is.matrix(x)
is.data.frame(x)
is.list(x)
```

Converting:
```r
y <- as.numeric(x)
y <- as.character(x)
y <- as.vector(x)
y <- as.matrix(x)
y <- as.data.frame(x)
```

Getting type:
```r
typeof(x)
```

Getting mode (type of object: list, numeric, ...):
```r
mode(x)
```

Getting class (object's class, list, numeric, ...):
```r
class(x)
```
The `class` function returns a vector in case of a class inheriting from other classes.
The `inherits` function eases inheritance test:
```r
inherits(x, "SomeClass")
```

## Random

Generate a floating random number, with Uniform distribution:
```r
x <- runif(1, 5.0, 7.5)     # generates a random number between 5.0 and 7.5 included
x <- runif(1)   # generates a number in [0.0;1.0]
v <- runif(10)  # generates an array if 10 numbers
```

## Basic statistical functions

Getting the minimum:
```r
a <- min(v)
```

Getting this index of the minimum in v:
```r
i <- which.min(v)
```

Mean:
```r
mean(c(2,5,8))
```

Standard deviation (écart type):
```r
sd(c(1,4,7.5,6.9))
```

## Sorting

Sort a vector:
```r
v <- (5,1,3,9,10)
sort(v)
```

Get the reordering of indicies of the vector:
```r
order(v)
```

Sort vector:
```r
v <- rbind(v)[,order(v)]
```

Sort data frame:
```r
df <- df[order(df[[1]]), ] # sort on first column.
df <- df[order(df[[1]], df[[3]]), ] # sort on columns 1 and 3 in that order.
```

Sorting a list/vector of objects:
```r
molecules <- db$getMolecules()
molecules <- rbind(molecules)[,order(vapply(molecules, function(x) x$getId(), FUN.VALUE = 1))]
```

Sort x in the same order as y, when x and y have elements starting at 1, and x is as long as y or longer than y (i.e.: with duplicated elements):
```r
x <- c(1,3,3,4,1,1,2)
y <- c(4,2,3,1)
y[sort(order(y)[x])]
```

Sort x in the same order as y, when x and y have the same number of elements:
```r
x <- c(5,10,3,9)
y <- c(9,5,3,10)
x[order(x)[order(y)]]
```

## Map, Reduce, Filter and Lambda

 * [R Programming Tutorial – Map, Reduce, Filter and Lambda Examples](https://helloacm.com/r-programming-tutorial-map-reduce-filter-and-lambda-examples/).

## Objects (OOP)

 * [OO in R](http://www.r-bloggers.com/oo-in-r/).
 * [OO field guide](http://adv-r.had.co.nz/OO-essentials.html).
 * [Package ‘R.oo’](https://cran.r-project.org/web/packages/R.oo/R.oo.pdf).
 * [S4 Classes in 15 pages, more or less](https://www.stat.auckland.ac.nz/S-Workshop/Gentleman/S4Objects.pdf).
 * [The S4 object system](http://adv-r.had.co.nz/S4.html).
 * [R Inheritance](https://www.programiz.com/r-programming/inheritance).
 * [R6](https://adv-r.hadley.nz/r6.html).
 * [R6: Encapsulated object-oriented programming for R](https://r6.r-lib.org/).

Workspace = collection of objects.

List objects in memory:
```r
objects()
ls()
```

Delete objects:
```r
rm(x,y,w)
```

Get a list of attributes and their values (object fields):
```r
attributes(x)
```

### S3

Check inheritance:
```r
if (inherits(o, "MyClass"))
	doSomething()
```
`inherits` has been extended to work for S4, but is not reliable. I've experienced malfunctioning from inside a package, when testing if an object inherits from a base class.

### S4

```r
library(methods)
```

Check inheritance for an object:
```r
if (methods::is(o, "MyClass"))
	doSomething()
```

Check inheritance between classes:
```r
if (methods::extends("SubClass", "SuperClass"))
	doSomething()
```

Declare a class:
```r
MyClass <- setClass('MyClass', slots = c(a = 'integer', b = 'numeric'))
```

Inheriting:
```r
MySubClass <- setClass('MySubClass', contains = 'MyClass', slots = c(c = 'character'))
```

Instantiate a class:
```r
x <- new('MyClass', a = 1L, b = 45.32)
```
or
```r
x <- MyClass(a = 1L, b = 45.32)
```

Accessing an object's slot:
```r
x@a
```
or
```r
slot(x, 'a')
```

Modifying an object's slot:
```r
x@a <- 10L
```
or
```r
slot(x, 'a') <- 10L
```

Get a list of all S4 generic functions:
```r
showMethods()
```

Test if a function is a generic function:
```r
isS4(print) # FALSE, `print` is S3.
isS4(show)  # TRUE.
```

Define a method:
```r
setGeneric("myMethod", function(o) { standardGeneric("myMethod") })
setMethod('myMethod', 'MyClass', function(o) {})
```

Call a method:
```r
myMethod(my_object)
```

### RC (Reference Classes, aka R5)

 * [Reference classes](http://adv-r.had.co.nz/R5.html).
 * [Objects With Fields Treated by Reference (OOP-style)](https://stat.ethz.ch/R-manual/R-devel/library/methods/html/refClass.html).
 * [ReferenceClasses](https://www.rdocumentation.org/packages/methods/versions/3.6.0/topics/ReferenceClasses).

```r
library(methods)
```

Fields declaration:
```r
MyClass <- setRefClass('MyClass', fields = list(size = 'numeric', name = 'character'))
```

A field type can be a class:
```r
MyClass <- setRefClass('MyClass', fields = list(size = 'numeric', name = 'character', somefield = 'SomeOtherClass'))
```
But then the field must be initialized to a class instance of that (or a derived class). It can't be initialized to NULL.
In order to be able to set a field to NULL, the field must be of type ANY.
A more correct solution is to set the field to NA in the constructor declaration.

#### Inheritance

To inherit from another class
```r
MyClassA <- setRefClass("MyClassA", contains = "MyClassB")
```

!!! For inheritance to work, all arguments of a parent's constructor must have default values (i.e.: an empty constructor must be provided). This is a S4 requirement.
```r
A <- setRefClass("A", fields = list(n = "numeric"),
				 methods = list( initialize = function(a = 0, ...) {
				                 n <<- a
				                 callSuper(...)
				               	 }
							   ))

B <- setRefClass("B", methods = list(initialize = function(...) {
                                     callSuper(...)
                                     }
                                    ))
```

To avoid setting default values of fields to empty values like 0 or "", one can set them to NA:
```r
A <- setRefClass("A", fields = list(n = "numeric"),
				 methods = list( initialize = function(a = NA_integer_, ...) {
				                 n <<- a
				                 callSuper(...)
				               	 }
							   ))
```

To test inheritance, see S4.

To inherit from more than one class, use a vector to declare all super classes:
```r
C <- setRefClass('C', contains = c('A', 'B'))
```
Apparently, only the first class will provide field members, subsequent classes will only be seen as interfaces.

#### Field validity

```r
A <- setRefClass("A", fields=list(x="numeric"))

setValidity("A", function(object) {
                if (length(object$x) != 1L || !all(object$x < 11))
                        "'x' must be length 1 and < 11"
                            else NULL
                            })
a = A(x=11)
validObject(a)
```
Error in validObject(a) : 
	invalid class "A" object: 'x' must be length 1 and < 11

## Profiling

```r
Rprof()
#- some code
Rprof(NULL)
#- write a file Rprof.out
```

To read Rprof.out:
```r
summaryRprof()
```

## Graphical output

```r
pdf("xh.pdf")
hist(rnorm(100))
dev.off()
```

Plot a set of points:
```r
plot(x, y)
```

To a open a new window for plotting:
```r
windows() # on Windows platform
quartz() # on MacOS-X platform
X11() # on UNIX platform (opens a Quartz window on MacOS-X)
```

## HPC

TODO see CRAN packages doMC and DoSnow.

 * [High-Performance and Parallel Computing with R](https://cran.r-project.org/web/views/HighPerformanceComputing.html).
 * [(A Very) Experimental Threading in R – Random Remarks](https://random-remarks.net/2016/12/11/a-very-experimental-threading-in-r/).
 * [GPU computing](http://www.r-tutor.com/gpu-computing).
 * [Rmpi homepage](http://www.stats.uwo.ca/faculty/yu/Rmpi/).
 * [Rmpi tutorial](http://math.acadiau.ca/ACMMaC/Rmpi/).

## Some R error messages

### row names were found from a short variable and have been discarded

Error message from cbind.
Set `row.names = NULL` in cbind:
```r
cbind(df.1, df.2m row.names = NULL)
```

### could not find function "getGeneric"

The exact error is:
```
Error in getGeneric("$") : could not find function "getGeneric"
```

When running script from `Rscript`, the `methods` library is not loaded by default.
Add the following line at the start of your R script file:
```r
library(method)
```

## Interesting packages

### colorout

 * [colorout](https://github.com/jalvesaq/colorout).

It colorizes R output.

Not on CRAN because " it used non-API entry points not allowed by the CRAN policies.".

Install from github:
```r
devtools::install_github("jalvesaq/colorout", dependencies = TRUE)
```

### Rcpp

 * [Main page](http://dirk.eddelbuettel.com/code/rcpp.html).
 * [Extending R with C++: A Brief Introduction to Rcpp](http://dirk.eddelbuettel.com/code/rcpp/Rcpp-introduction.pdf).
 * [Writing a package that uses Rcpp](http://dirk.eddelbuettel.com/code/rcpp/Rcpp-package.pdf).

 * [Using R — .Call(“hello”)](https://www.r-bloggers.com/using-r-callhello/).
 * [Rcpp for Seamless R and C++ Integration](http://rcpp.org/).
 * [Calling C++ from R using Rcpp](https://www.r-bloggers.com/calling-c-from-r-using-rcpp/).
 * [Working with Rcpp::StringVector](http://gallery.rcpp.org/articles/working-with-Rcpp-StringVector/).
 * [Rcpp Attributes](http://dirk.eddelbuettel.com/code/rcpp/Rcpp-attributes.pdf).
 * [Frequently Asked Questions aboutRcpp](http://dirk.eddelbuettel.com/code/rcpp/Rcpp-FAQ.pdf).
 * [Rcpp for everyone](https://teuder.github.io/rcpp4everyone_en/).
 * [RcppQuick Reference Guide](http://dirk.eddelbuettel.com/code/rcpp/Rcpp-quickref.pdf).

 * [Exposing a C++ Student Class With Rcpp](https://www.gormanalysis.com/blog/exposing-a-cpp-student-class-with-rcpp/).
 * [Exposing C++ Classes into R Through Rcpp Modules](https://github.com/r-pkg-examples/rcpp-modules-student).
 * [ExposingC++functions and classeswith Rcpp modules](https://cran.r-project.org/web/packages/Rcpp/vignettes/Rcpp-modules.pdf).

### devtools

Installing from a git repos:
```r
devtools::install_git("https://gitlab.com/proger/biodb.git", branch='develop', credentials=git2r::cred_user_pass ("proger", getPass::getPass()))
```

Installing local sources:
```r
devtools::install_local('~/dev/biodb/')
```

Building on Windows for testing:
```r
devtools::build_win('~/dev/biodb')
```

### RMySQL

```r
library(RMySQL)
```

Open the default test database provided by MySQL installation:
```r
if (mysqlHasDefault()) {
	conn <- dbConnect(RMySQL::MySQL(), dbname = "test")
	# Do some stuff...
	dbDisconnect(conn)
}
```

Send a query:
```r
result <- try(dbSendQuery(conn, query))
```

Test if everything went right:
```r
if (dbHasCompleted(result)) ...
```

#### .my.cnf file

One can define connection settings inside the .my.cnf file:
``` {.linux-config}
[my_conn_settings]
host = localhost
user = root
password = root
database = 2biodb
```

The file should be of course only readable by the user.
And then use group parameter to dbConnect
```r
dbConnect(MySQL(), group = 'my_conn_settings')
```
The configuration file path is defined by the default.file parameter of dbConnect, that, by default, is set to `$HOME/.my.cnf` under UNIX type platforms and `C:\my.cnf` under Windows platforms.

#### Installing RMySQL on Windows

On windows platform the RMySQL package isn't provided as binary. One needs to compile it.

For this, one needs to install Rtools and MySQL, and then run:
```r
install.packages('RMySQL', type='source')
```
Be careful of choosing compatible binary versions (32 or 64 bits) for the 3 software: R, Rtools (and the extension to install: "Extras to build 32 bit R: TCL/TK, bitmap code, internationalization") and MySQL.
Eventually look at <http://www.r-bloggers.com/installing-the-rmysql-package-on-windows-7/>.
You'll have to define `MYSQL_HOME` env var to be `C:\Program Files\MySQL\MySQL Server 5.6`, and also to copy `libmysql.dll` from the lib folder of `C:\Program Files\MySQL\MySQL Server 5.6` to its bin folder.

### R.matlab

 * [Package R.matlab](http://search.r-project.org/library/R.matlab/html/R.matlab-package.html).

```r
library(R.matlab)
```

#### Read/write matlab data files

```r
A <- matrix(1:27, ncol=3)
B <- as.matrix(1:10)

filename <- paste(tempfile(), ".mat", sep="")
writeMat(filename, A=A, B=B)
data <- readMat(filename)
print(data)
unlink(filename)
```

#### Evaluate matlab code

Run Matlab server:
```r
Matlab$startServer()
```
The 'matlab' executable must be in the PATH.

Create a matlab client:
```r
matlab <- Matlab()
```

Open connection:
```r
open(matlab)
```

Set detailed output:
```r
setVerbose(matlab, -2)
```

Evaluate matlab code:
```r
evaluate(matlab, "A=1+2;", "B=ones(2,20);")
```

Get variables:
```r
matlab_vars <- getVariable(matlab, c("a", "b"))
```

Create a function:
```r
setFunction(matlab, "          \
	function [win,aver]=dice(B)  \
	%Play the dice game B times  \
	gains=[-1,2,-3,4,-5,6];      \
	plays=unidrnd(6,B,1);        \
	win=sum(gains(plays));       \
	aver=win/B;                  \
");
```

Call function:
```r
evaluate(matlab, "[w,a]=dice(1000);")
```

Close client and server (to verify: only if this is the last client ?):
```r
close(matlab)
```

### Getopt package

```r
library(getopt)

spec = matrix(c(
#-  longname        shortname   arg_presence    arg_type        description
	'db',           'd',        1,              'character',    'Database name.',
	'help',         'h',        0,              'logical',      'Print this help.',
	'input',        'i',        1,              'character',    'Input excel file.'
#- arg_presence can be 0 (no arg), 1 (required), 2 (optional)
	), byrow = TRUE, ncol = 5)

opt <- getopt(spec)
```

### RCurl

```r
library(RCurl)
```

Getting URL content:
```r
txt <- getURL("http:/.../")
```

Setting the user agent:
```r
txt <- getURL("http:/.../", useragent="MyApp ; www.myapp.fr ; pierrick.rogermele@icloud.com")
```

### XML

Parsing XML from string:
```r
xml <- XML::xmlInternalTreeParse(s, asText = TRUE)
```

Saving an XML tree into a file:
```r
XML::saveXML(myxml, myfile)
```

Writing an XML tree into a string:
```r
xmlstr <- XML::saveXML(myxml)
```

Getting a list of nodes:
```r
nodes <- XML::getNodeSet(xml, "//ExtendedCompoundInfo")
```

Get a node's text content:
```r
txt <- XML::xpathSApply(xmldoc, "//mynode", XML::xmlValue)
```

Get attributes:
```r
ids <- XML::xpathSApply(xml, '//book', XML::xmlGetAttr, 'id')
```

XML using an anonymous namespace
If the XML top node contains an xmlns attribute (ex: <mytopnode xmlns="http://..../"...>), then it must be defined with a prefix while searching using XPath, otherwise XPath will return nothing.
```r
txt <- XML::xpathSApply(xmldoc, "//mynamespace:mynode", XML::xmlValue, namespaces = c(mynamespace = "http://..../"))
```

Getting XML namespaces:
```r
xml <-  XML::xmlInternalTreeParse(xmlstr, asText = TRUE)
print(XML::xmlNamespace(xmlRoot(xml)))
```

### rJava

Allows to call Java from R.

#### Install

If a jar is compiled with more recent version of Java than the one configure inside R and used to compile rJava, then rJava will complain telling something like "Unsupported major.minor version 52.0".

So be Careful of the version with which R is configured. To reconfigure Java inside R, run:
```bash
R CMD javareconf
#sudo chmod a+r /Library/Frameworks/R.framework/Resources/etc/ldpaths /Library/Frameworks/R.framework/Resources/etc/Makeconf
```
To get help about `javareconf`:
```bash
R CMD javareconf --help
```
On MacOS-X, make sure to set the proper env vars to point to the right version of Java. If `JAVA_HOME` is properly set, it should be:
```bash
export JAVA_CPPFLAGS="-I$JAVA_HOME/include -I$JAVA_HOME/include/darwin"
export JAVA_LIBS="-L$JAVA_HOME/jre/lib/server -L$JAVA_HOME/jre/lib -ljvm"
export JAVA_LD_LIBRARY_PATH="$JAVA_HOME/jre/lib/server:$JAVA_HOME/jre/lib"
R CMD javareconf
```

Then reinstall rJava from R:
```r
install.packages('rJava', type='source', dependencies = TRUE)
```
or for most recent package:
```r
install.packages("rJava",,"http://rforge.net/",type="source", dependencies = TRUE)
```

To check the version of Java used by rJava:
```r
library(rJava)
.jinit()
print(.jcall('java/lang/System', 'S', 'getProperty', "java.version"))
```
If it prints version 1.6 and you want 1.8, and you are under MacOS-X, then there may be an issue with Java OS-X version. Re-install the OS-X Java with (<https://support.apple.com/kb/DL1572?locale=en_US>).
It still doesn't work, then first try to look at what libs are loaded:
```bash
DYLD_PRINT_LIBRARIES=1 R
```

The loading of rJava
```r
library(rJava)
```
should print the line:
	dyld: loaded: /Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home/jre/lib/jli/libjli.dylib
And the initializatio
```r
.jinit()
```
should print the lines:
	dyld: loaded: /Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home/bundle/Libraries/libclient64.dylib
	dyld: loaded: /Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Libraries/../Libraries/libjvmlinkage.dylib
	dyld: loaded: /Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Libraries/libverify.dylib
	dyld: loaded: /System/Library/Frameworks/JavaVM.framework/Versions/A/Frameworks/JavaNativeFoundation.framework/Versions/A/JavaNativeFoundation
	dyld: loaded: /Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Libraries/libjava.jnilib
	dyld: loaded: /System/Library/Frameworks/JavaVM.framework/Versions/A/Frameworks/JavaRuntimeSupport.framework/Versions/A/JavaRuntimeSupport
	dyld: loaded: /Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Libraries/libzip.jnilib
Check which is the current JDK:
```bash
ls -l /System/Library/Frameworks/JavaVM.framework/Versions
```
Reinstall Oracle JDK 1.8.
Reconfigure R (`R CMD javareconf`) and reinstall rJava.

#### Use

Initialize rJava:
```r
.jinit()
```

Printing JRE version:
```r
print(.jcall('java/lang/System', 'S', 'getProperty', "java.version"))
```

Set class path and call a class method:
```r
library(rJava)
.jaddClassPath("my/paths/to/classes")
.jcall('my/name/space/MyClass', 'V', 'myMethod')
```
`.jcall` uses the JNI notation for returned parameter:
Type                    | Description
----------------------- | -------------
`V`                     | Void.
`B`                     | Byte.
`C`                     | Char.
`I`                     | Int.
`J`                     | Long.
`S`                     | Short.
`Z`                     | Boolean.
`F`                     | Float.
`D`                     | Double.
`[I`                    | 1D array of integers.
`[[I`                   | 2D array of integers.
`Lfr/path/to/my/Class`  | An object of that class.
`[Lfr/path/to/my/Class` | 1D array of instances of that class.

To know the signature of a java method, use `javap -s ...`.

Create an object:
```r
obj <- .jnew('my.name.space.MyClass')
```

Get the class path:
```r
cp <- .jclassPath()
```

### Rserve

Allows to call R from Java.
See [How to make a simple program to call R from java using eclipse and Rserve](http://stackoverflow.com/questions/10216014/how-to-make-a-simple-program-to-call-r-from-java-using-eclipse-and-rserve).

```r
install.packages("Rserve")
library(Rserve)
Rserve()
```

In Java, use the jars RserveEngine.jar and REngine.jar:
```java
import org.rosuda.REngine.*;
import org.rosuda.REngine.Rserve.*;

public class rserveuseClass {
	public static void main(String[] args) throws RserveException {
		try {
			RConnection c = new RConnection();// make a new local connection on default port (6311)
			double d[] = c.eval("rnorm(10)").asDoubles();
			org.rosuda.REngine.REXP x0 = c.eval("R.version.string");
			System.out.println(x0.asString());
		} catch (REngineException e) {
		//manipulation
		}       
	}
}
```

### RJSONIO

[RJSONIO](https://cran.r-project.org/web/packages/RJSONIO/index.html) is a JSON package.

### tripack

Triangulation of irregularly spaced data (Delaunay triangulation). Used for visualizing Voronoï cells.

### Rdist

Euclidian distance.

### hyperSpec

Read SPC files (spectrometry files). See [official website](http://hyperspec.r-forge.r-project.org).

### R.utils

Various programming utilities.

### caTools

Contains trapz() function for integration (needs bitops).

AUC (Area Under Curve):
```r
library(caTools)
area <- trapz(vx, vy)
```

### RCDK

 * [rcdk sources](https://github.com/rajarshi/cdkr).
 * [rcdk Java sources](https://github.com/rajarshi/cdkr/tree/master/rcdkjar).

### MASS

LDA (Linear discriminant analysis) function:
```r
library(MASS)
lda(x, ...)
```

LDA function can complain that "variables appear to be constant within groups".
This means that it has detected the matrix as singular.
It can be true, which really means some variables are constant.
Or it can be that the data is poorly scaled. In that case the threshold must be changed.
The condition to detect that the matrix is singular is that a variable has within-group variance less than tol^2.
"tol" can be set in the parameters
```r
lda(....., tol = 0.0000001, ....)
```

### Bioconductor

 * [Bioconductor](http://www.bioconductor.org).
 * [Advanced R / Bioconductor Programming](https://www.bioconductor.org/help/course-materials/2012/Seattle-Oct-2012/AdvancedR.pdf).
 * [Bioc-devel -- Bioconductor Developers' List](https://stat.ethz.ch/mailman/listinfo/bioc-devel).
 
Install all Bioconductor packages:
```r
source("http://bioconductor.org/biocLite.R")
biocLite()
```

Install a package of Bioconductor:
```r
source("http://bioconductor.org/biocLite.R")
biocLite(c("GenomicFeatures", "AnnotationDbi"))
```

#### Creating a bioconductor package

Le fichier 'NEWS' dans les packages (i.e. change log) suit un format spécifique (il est parsé par bioc). La core team recommande le fichier NEWS <http://www.bioconductor.org/packages/devel/bioc/news/Rsamtools/NEWS> comme exemple.

#### Risa

Load ISA-Tab:
```r
isa <- readISAtab('some_isatab_dir')
```

Get assay file names:
```r
assay.fiel.names <- getMSAssayFilenames(isa)
```

#### Rdisop

Annotation of mass spectra (Steffen Neumann). Part of BioConductor.

#### Rmassbank

[RMassBank](https://bioconductor.org/packages/release/bioc/html/RMassBank.html) is a Bioconductor package. It is a workflow designed to process MS data and build MassBank records.

#### XCMS

Framework for processing and visualization of chromatographically separated and single-spectra mass spectral data.

 * [XCMS official page](http://www.bioconductor.org/packages/release/bioc/html/xcms.html).
 * [XCMS^plus^](http://sciex.com/about-us/news-room/xcmssupplus/sup), commercial version which is a personal cloud version of *XCMS Online*.

To install XCMS library, run the following lines in R:
```r
source("http://bioconductor.org/biocLite.R")
biocLite("xcms")
```

#### metfRag

[MetFragR](https://github.com/c-ruttkies/MetFragR).

Installing:
```r
source("http://bioconductor.org/biocLite.R")
biocLite("KEGGREST")
library(devtools)
install_github("c-ruttkies/MetFragR/metfRag")
```

```r
library(metfRag)
```

### Testthat

 * [testthat: Get Started with Testing](https://journal.r-project.org/archive/2011-1/RJournal_2011-1_Wickham.pdf).
 * [Package ‘testthat’](https://cran.r-project.org/web/packages/testthat/testthat.pdf).

Testthat propose different reporters.
For instance, when called with devtools for a package, we can trigger a progress reporter (`ProgressReporter`) with a failure reporter (`FailReporter`, that will ensure that a fail message is sent):
```r
R -q -e "devtools::test('.', reporter = c('progress', 'fail'))"
```
Or use the Stop reporter (`StopReporter`) that will stop at the first error:
```r
R -q -e "devtools::test('.', reporter = c('stop', 'summary', 'fail'))"
```

### RUnit

```r
library(RUnit)
```

Assert true:
```r
checkTrue(1 < 2, "check1.")
```

Assert equality:
```r
checkEquals(10, my_var, "some text.")
```

Assert identity:
```r
checkIdentical(character(0), some_var, "Something isn't right.")
```

Assert exception:
```r
checkException(some_expression_or_function, "Some message") # checks that an exception is thrown
checkException(some_expression_or_function, "Some message", silent = TRUE) # Tells 'try' to do not print error message.
```

### SSOAP

No more in CRAN.

 * [Using R SOAP (SSOAP) to retrieve data from NOAA](http://stackoverflow.com/questions/24528351/using-r-soap-ssoap-to-retrieve-data-from-noaa).
 * [R Package SSOAP](http://arademaker.github.io/blog/2012/01/02/package-SSOAP.html).
 * [SOAP Client with WSDL for R](http://stackoverflow.com/questions/32594448/soap-client-with-wsdl-for-r). --> Example of using RCurl in replacement of SSOAP.



### Grid

 * [Grid](https://stat.ethz.ch/R-manual/R-devel/library/grid/html/00Index.html).

Use to make graphical presentation. See also [gridSVG](https://stat.ethz.ch/R-manual/R-devel/library/grid/html/00Index.html) to export grid object to SVG file.

### RSQLite

 * [Package ‘RSQLite’](https://cran.r-project.org/web/packages/RSQLite/RSQLite.pdf).
 * [R and SQLite: Part 1](https://www.r-bloggers.com/r-and-sqlite-part-1/).

### Shiny

 * [Shiny](https://shiny.rstudio.com).

Shiny is a package for building interactive web apps.

### DiagrammeR

Use DiagrammeR for drawing GrapheVIZ style diagrams.
See <http://rich-iannone.github.io/DiagrammeR/graphs.html>.
