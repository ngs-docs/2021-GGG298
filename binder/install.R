if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("edgeR", update=FALSE, ask=FALSE)

install.packages(c("highr", "markdown", "stringr", "yaml"))
install.packages(c("caTools", "bitops", "knitr", "rprojroot", "rmarkdown"))
tinytex::install_tinytex()
