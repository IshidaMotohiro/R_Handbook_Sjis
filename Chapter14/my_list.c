
/* リストを作成する my_list.c */
#include <R.h>
#include <Rinternals.h>
SEXP myList (SEXP x, SEXP y, SEXP z){
  SEXP my_list , my_listnames;
  //リスト要素の名前とする文字列
  char *my_names[3] = {"string", "integer", "numeric"};
  int i, j = 0;
  //要素となるベクトルが3つのリストを定義
  PROTECT(my_list = allocVector(VECSXP, 3)); j++;
  SET_VECTOR_ELT(my_list, 0, x);
  SET_VECTOR_ELT(my_list, 1, y);
  SET_VECTOR_ELT(my_list, 2, z);
  //リストの要素名を設定
  PROTECT(my_listnames = allocVector(STRSXP, 3));j++;
  for(i = 0; i < 3; i++)
	SET_STRING_ELT(my_listnames, i, mkChar(my_names[i]));
  setAttrib(my_list, R_NamesSymbol, my_listnames);
  UNPROTECT (j);// 保護の解除
  return my_list;
}
