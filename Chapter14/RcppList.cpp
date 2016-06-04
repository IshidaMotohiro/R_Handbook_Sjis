
/* RcppList.cpp ソースファイル */
#include <Rcpp.h>
RcppExport SEXP test (SEXP x, SEXP y, SEXP z){
  return Rcpp::List::create(Rcpp::Named("string") = x,
							Rcpp::Named("integer") = y,
							Rcpp::Named("numeric") = z);
}

