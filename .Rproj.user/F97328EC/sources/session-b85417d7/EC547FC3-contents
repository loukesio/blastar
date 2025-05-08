#' Fetch Metadata (and optionally sequence ranges) from NCBI
#'
#' @param accessions  Character vector of accession numbers.
#' @param db          Either "nuccore" or "protein".
#' @param seq_range   Either:
#'   - NULL (default): fetch full sequence for every accession
#'   - numeric(2):   fetch that same start–end for *all* accessions
#'   - named list:   each element is a numeric(2) vector, names are accessions;
#'                   will fetch only that slice for the named accession,
#'                   full sequence for others.
#'
#' @return A tibble with columns
#'   `accession`, `accession_version`, `title`, `organism`, `sequence`
#' @importFrom rentrez entrez_search entrez_summary entrez_fetch
#' @importFrom dplyr bind_rows
#' @importFrom tibble tibble
#' @export
#'
fetch_metadata <- function(accessions,
                           db = c("nuccore", "protein"),
                           seq_range = NULL) {
  db <- match.arg(db)
  if (!requireNamespace("rentrez", quietly = TRUE))
    stop("Please install the 'rentrez' package.")

  ## Helper: validate a single range vector
  is_valid_range <- function(x) {
    is.numeric(x) && length(x) == 2 && all(x > 0) && x[1] < x[2]
  }

  ## If seq_range is a single numeric, apply to all later
  global_range <- NULL
  per_accession_ranges <- NULL

  if (!is.null(seq_range)) {
    if (is.numeric(seq_range)) {
      if (!is_valid_range(seq_range))
        stop("If numeric, `seq_range` must be c(start, end) with start < end.")
      global_range <- as.integer(seq_range)
    } else if (is.list(seq_range)) {
      # must be named
      if (is.null(names(seq_range)) || any(names(seq_range) == ""))
        stop("When list, `seq_range` must be a named list, names matching accessions.")
      # validate each element
      bad <- names(seq_range)[!vapply(seq_range, is_valid_range, logical(1))]
      if (length(bad))
        stop("Invalid ranges for: ", paste(bad, collapse = ", "))
      # only keep those names that are actually in accessions
      per_accession_ranges <- lapply(seq_range, as.integer)
    } else {
      stop("`seq_range` must be NULL, a numeric(2), or a named list of numeric(2).")
    }
  }

  ## Main loop
  out <- lapply(accessions, function(acc) {
    tryCatch({
      # 1) UID lookup
      sr <- rentrez::entrez_search(db = db, term = acc)
      if (length(sr$ids) == 0) {
        warning("No UID for ", acc); return(NULL)
      }
      uid <- sr$ids[[1]]

      # 2) Metadata
      sm <- rentrez::entrez_summary(db = db, id = uid)

      # 3) Decide which range to use
      this_range <- NULL
      if (!is.null(global_range)) {
        this_range <- global_range
      } else if (!is.null(per_accession_ranges) && !is.null(per_accession_ranges[[acc]])) {
        this_range <- per_accession_ranges[[acc]]
      }

      # 4) Fetch FASTA
      fetch_args <- list(db = db, id = uid, rettype = "fasta", retmode = "text")
      if (!is.null(this_range)) {
        fetch_args$seq_start <- this_range[1]
        fetch_args$seq_stop  <- this_range[2]
      }
      fasta <- do.call(rentrez::entrez_fetch, fetch_args)

      # strip header + newlines
      lines <- strsplit(fasta, "\n", fixed = TRUE)[[1]]
      seq   <- paste(lines[-1], collapse = "")

      tibble::tibble(
        accession         = acc,
        accession_version = sm$accessionversion,
        title             = sm$title,
        organism          = sm$organism,
        sequence          = seq
      )
    }, error = function(e) {
      warning("Error for ", acc, ": ", e$message)
      NULL
    })
  })

  dplyr::bind_rows(out)
}
