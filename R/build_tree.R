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
#' @examples
#' \donttest{
#' # Build NJ tree from multiple sequence alignment (requires msa package)
#' if (requireNamespace("msa", quietly = TRUE)) {
#'   # Create example sequences
#'   df <- data.frame(
#'     accession = c("seq1", "seq2", "seq3"),
#'     sequence = c("ATGCATGC", "ATGCTAGC", "ATGGATGC")
#'   )
#'   
#'   # Generate MSA
#'   msa_result <- align_sequences(df, method = "msa", msa_method = "ClustalOmega")
#'   
#'   # Build NJ tree
#'   tree <- build_nj_tree(msa_result, model = "raw")
#'   print(tree)
#' }
#' }
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
