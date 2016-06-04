
/* RcppDataFrame.cpp ソースファイル */
#include "Rcpp.h"
using namespace Rcpp;
RcppExport SEXP dfMake2 (SEXP x, SEXP y, SEXP z){
  CharacterVector cv = CharacterVector::create(as<std::string>(x),
											   as<std::string>(y),
											   as<std::string>(z));
  IntegerVector nv = IntegerVector::create(10,20,30);
  return DataFrame::create(Named("Name") = cv, Named ("Age") = nv,
						   Named("stringsAsFactors") = false );
}
