pkgname <- "Hozo"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
options(pager = "console")
library('Hozo')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("estimate_stats")
### * estimate_stats

flush(stderr()); flush(stdout())

### Name: estimate_stats
### Title: Estimate Statistical Parameters from Limited Data
### Aliases: estimate_stats

### ** Examples

# A typical case with median 10, minimum 5, maximum 15, and sample size 30
estimate_stats(median = 10, minimum = 5, maximum = 15, sample_size = 30)

# Edge case where minimum equals maximum
estimate_stats(median = 20, minimum = 20, maximum = 20, sample_size = 10)




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
