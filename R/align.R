#' Align DNA Sequences (Pairwise or Multiple)
#'
#' This function takes a tibble with a "sequence" column (and optional "accession" names)
#' and performs either a pairwise alignment between two sequences or a multiple sequence
#' alignment (MSA) across all.
#'
#' @param df A tibble or data.frame containing at least:
#'   - `sequence`: character vector of DNA sequences
#'   - `accession` (optional): names for each sequence; if present, they will be
#'      used as identifiers in the alignment object.
#' @param method One of:
#'   - "pairwise": perform a pairwise alignment between two sequences
#'   - "msa": perform a multiple sequence alignment on all sequences
#' @param pairwise_type For pairwise only, alignment type: "global" (Needleman–Wunsch),
#'   "local" (Smith–Waterman), or "overlap".
#' @param msa_method For MSA only, method name: "ClustalOmega", "ClustalW", or "Muscle".
#' @param seq_indices Integer vector of length 2; indices of the two sequences to align when
#'   `method = "pairwise"`. Defaults to `c(1,2)`.
#'
#' @return If `method="pairwise"`, a list with:
#'   - `alignment`: a `PairwiseAlignmentsSingleSubject` object
#'   - `pid`: percent identity (numeric)
#'   If `method="msa"`, an object of class `MsaDNAMultipleAlignment` or similar.
#'
#' @examples
#' # Minimal, always-run example (< 5s)
#' data <- data.frame(
#'   accession = c("seq1", "seq2"),
#'   sequence  = c("ACGTACGTACGT", "ACGTACGTTTGT"),
#'   stringsAsFactors = FALSE
#' )
#'
#' res_pw <- align_sequences(
#'   df = data,
#'   method = "pairwise",
#'   pairwise_type = "global"
#' )
#' res_pw$pid
#'
#'
#' @importFrom Biostrings DNAStringSet pairwiseAlignment pid
#' @export
align_sequences <- function(df,
                            method = c("pairwise", "msa"),
                            pairwise_type = "global",
                            msa_method = "ClustalOmega",
                            seq_indices = c(1,2)) {
  method <- match.arg(method)
  if (!"sequence" %in% names(df)) {
    stop("Input data must have a 'sequence' column.")
  }

  # Convert to DNAStringSet
  seqs <- Biostrings::DNAStringSet(df$sequence)
  if ("accession" %in% names(df)) {
    names(seqs) <- df$accession
  }

  if (method == "pairwise") {
    # Ensure two indices
    if (length(seq_indices) != 2) {
      stop("`seq_indices` must be length 2 for pairwise alignment.")
    }
    s1 <- seqs[[seq_indices[1]]]
    s2 <- seqs[[seq_indices[2]]]
    aln <- Biostrings::pairwiseAlignment(s1, s2, type = pairwise_type)
    pid_val <- Biostrings::pid(aln)
    return(list(
      alignment = aln,
      pid       = pid_val
    ))
  } else {
    # Multiple sequence alignment - check for msa package
    if (!requireNamespace("msa", quietly = TRUE)) {
      stop("Multiple sequence alignment requires the 'msa' package from Bioconductor.\n",
           "Install it with:\n",
           "  if (!require('BiocManager', quietly = TRUE)) install.packages('BiocManager')\n",
           "  BiocManager::install('msa')",
           call. = FALSE)
    }

    msa_aln <- msa::msa(seqs, method = msa_method)
    return(msa_aln)
  }
}

