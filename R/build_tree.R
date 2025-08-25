#' Build a Neighbor-Joining tree from a multiple sequence alignment
#'
#' This function takes a Multiple Sequence Alignment (MSA) object (e.g., output of
#' `align_sequences(method = "msa")`) and generates a Neighbor-Joining (NJ) tree.
#'
#' @param msa A multiple alignment object (class `MsaDNAMultipleAlignment` or similar)
#' @param model Evolutionary model for distance calculation passed to `ape::dist.dna`
#'              (e.g., "raw", "JC69", "K80", etc.)
#' @param pairwise.deletion Logical. If TRUE, compute distances with pairwise deletion
#' @return An object of class `phylo` (NJ tree)
#' @importFrom ape as.DNAbin dist.dna nj
#' @importFrom Biostrings DNAStringSet pairwiseAlignment pid
#' @export
build_nj_tree <- function(msa, model = "raw", pairwise.deletion = TRUE) {
  # Convert MSA to DNAbin
  aln_bin <- ape::as.DNAbin(msa)
  # Compute distance matrix
  dist_mat <- ape::dist.dna(aln_bin, model = model, pairwise.deletion = pairwise.deletion)
  # Build NJ tree
  nj_tree <- ape::nj(dist_mat)
  return(nj_tree)
}
