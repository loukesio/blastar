
[![CRAN version](https://img.shields.io/cran/v/blastar.svg)](https://cran.r-project.org/package=blastar)  [![R-CMD-check](https://github.com/loukesio/blastar/actions/workflows/r.yml/badge.svg?branch=main)](https://github.com/loukesio/blastar/actions/workflows/r.yml)  [![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)

## Install the `blastr` package

*The name **blastar** comes from the Greek word [βλαστάρι](https://el.wiktionary.org/wiki/βλαστάρι), which stands for the fresh, tender shoot of a plant. It evokes the idea of growth, branching, and organic evolution — all essential metaphors for phylogenetic exploration.*

Install the package using the following commands   <img align="right" src="blastar_2000.png" alt="blastar logo" width="550" />

```r
# for now, you can install the developmental version of ltc
# first you need to install the devtools package 
# in case you have not already installed
install.packages("devtools") 
# and load it
library(devtools)

# then you can install the dev version of the ltc
devtools::install_github("loukesio/blastr")
# and load it
library(blastr)
```

<br>


### How do I start?
Load the library and explore the example datasets! 

**Fast retrieval, alignment & phylogenetic-tree construction for NCBI sequences in R**



 
### 🚀 Features

- **NCBI Sequence Retrieval**  
  Retrieve FASTA sequences and metadata directly from NCBI using accession numbers.
- **Flexible Alignment Options**  
  - **Pairwise** with `Biostrings::pairwiseAlignment()`  
  - **Multiple** with `DECIPHER::AlignSeqs()` or `msa::msaClustalOmega()`
- **Phylogenetic Tree Construction**  
  Build and visualize NJ, UPGMA, and ML trees with `ape`, `phangorn`, and `ggtree`.
- **Batch & Parallel Processing**  
  Accelerate large jobs with parallel execution using `furrr`.
- **Resume & Caching**  
  Seamlessly continue interrupted downloads with local caching.
- **Export Options**  
  Output results in FASTA, Clustal, NEXUS, Newick, and high-res PDF.
- **Publication-Quality Plots**  
  Elegant tree visualizations and annotated alignments with `ggplot2` and `ggtree`.

