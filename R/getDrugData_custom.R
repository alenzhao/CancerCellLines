#' Extract custom drug response data
#'
#' This function creates a \code{data.frame} containing the drug response data from a user provided data frame
#'
#' @param df A \code{data.frame} object containing the data which should include columns names compound_id, unified_id, endpoint, original and value
#' @param drugs A vector of compound identifiers or compound/endpoint identifiers
#' @param cell_lines A vector of cell line identifiers
#' @return A \code{data.frame} containing the drug response data for the requested compounds and cell lines
#' @export
getDrugData_custom <- function(df, drugs, cell_lines) {

  required_colnames <- c('compound_id', 'unified_id', 'endpoint', 'original', 'value')
  missing_columns <- setdiff(required_colnames,colnames(df))

  if(length(missing_columns) > 0) {
    stop(sprintf('Following required column names not present in supplied data frame: %s', sprintf(paste(missing_columns, collapse=', '))))
  }

  outdata <- df %>% dplyr::transmute(unified_id,
                                     compound_id,
                                     assayed_id=paste(compound_id, endpoint, sep='_'),
                                     data_type='resp',
                                     original,
                                     value) %>%
    dplyr::filter((compound_id %in% drugs | assayed_id %in% drugs ) & unified_id %in% cell_lines) %>%
    dplyr::select(-compound_id) %>% as.data.frame

  outdata <- outdata %>% dplyr::mutate_each(dplyr::funs(as.character), -value) %>%
    dplyr::mutate_each(dplyr::funs(as.numeric), value)

  if(nrow(outdata)==0) {
    stop('No data found matching supplied drugs/cell lines')
  } else {
    return(outdata)
  }
}
