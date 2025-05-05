# blastar

<!-- README.md for blastar -->

<!-- Logo on the right -->
<p align="left">
  <img align="right" src="blastar_2000.png" alt="blastar logo" width="450" />
  <h1>blastar</h1>
 <p><strong>Fast retrieval, alignment &amp; phylogenetic-tree construction for NCBI sequences in R</strong></p>
  <p>
    <a href="https://cran.r-project.org/package=blastar"><img src="https://img.shields.io/cran/v/blastar.svg" alt="CRAN version"/></a>
    <a href="https://github.com/yourusername/blastar/actions"><img src="https://img.shields.io/github/actions/workflow/status/yourusername/blastar/ci.yml?branch=main" alt="CI status"/></a>
    <a href="https://opensource.org/licenses/MIT"><img src="https://img.shields.io/badge/license-MIT-blue.svg" alt="License: MIT"/></a>
  </p>
</p>

---

## 🚀 Features

- **NCBI Sequence Retrieval**  
  Fetch FASTA sequences &amp; descriptions via `rentrez` by accession number.
- **Flexible Alignments**  
  - **Pairwise** with `Biostrings::pairwiseAlignment()`  
  - **Multiple** with `DECIPHER::AlignSeqs()` or `msa::msaClustalOmega()`
- **Phylogenetic Trees**  
  Build &amp; visualize trees (NJ, UPGMA, ML) via `ape`, `phangorn` &amp; `ggtree`.
- **Batch & Parallel**  
  Process hundreds of accessions in parallel (via `future`/`furrr`).
- **Caching & Resume**  
  Local cache of downloaded sequences; resume interrupted analyses seamlessly.
- **Export Formats**  
  Write alignments &amp; trees as FASTA, Clustal, NEXUS, Newick or PDF.
- **Publication-Quality Graphics**  
  Ready-to-publish plots with `ggtree`, `ggplot2` &amp; alignment highlights.

---

## 🔧 Installation

From CRAN:

```r
install.packages("blastar")
```

library(blastar)

## 1. Retrieve sequences
acc <- c("NC_000852", "NC_001422")
records <- fetch_sequences(acc, email="you@example.com")

## 2. Pairwise alignment
pw_aln <- align_pairwise(records[[1]], records[[2]])

## 3. Multiple sequence alignment
msa <- align_multiple(records, method="ClustalOmega", nthreads=4)

## 4. Build & plot tree
tree <- build_tree(msa, method="NJ", bootstrap=100)
plot_tree(tree, file="my_tree.pdf")


🤝 Contributing
Fork it: https://github.com/yourusername/blastar/fork

Create a branch: git checkout -b feature/fooBar

Commit: git commit -m "Add fooBar"

Push: git push origin feature/fooBar

Open a PR!

Please follow our CONTRIBUTING.md & CODE_OF_CONDUCT.md.



