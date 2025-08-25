.onAttach <- function(libname, pkgname) {
  if (!requireNamespace("msa", quietly = TRUE)) {
    packageStartupMessage("Note: For multiple sequence alignment functionality, install 'msa' from Bioconductor:\n",
                          "BiocManager::install('msa')")
  }
}
