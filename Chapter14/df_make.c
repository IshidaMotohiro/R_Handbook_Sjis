/* データフレームの作成 df_make.c */
#include <R.h>
#include <Rdefines.h>
extern int utf8locale;//ロケールを判断
SEXP dfMake(SEXP x, SEXP y, SEXP z){
  int pc=0;// PROTECTスタックの管理
  SEXP df, varlabels, tmp, row_names;
  const char* xx = CHAR(STRING_ELT(x, 0));//文字列の変換
  const char* yy = CHAR(STRING_ELT(y, 0));
  const char* zz = CHAR(STRING_ELT(z, 0));
  PROTECT(df = allocVector(VECSXP, 2));// ベクトル要素を2つ持つ data.frame
  pc++;
  // data.frameの第1ベクトル（列）は3つの要素からなる文字ベクトル
  SET_VECTOR_ELT(df, 0, allocVector(STRSXP, 3));
  SET_STRING_ELT(VECTOR_ELT(df,0), 0, mkCharCE(xx, (utf8locale)?CE_UTF8:CE_NATIVE));
  SET_STRING_ELT(VECTOR_ELT(df,0), 1, mkCharCE(yy, (utf8locale)?CE_UTF8:CE_NATIVE));
  SET_STRING_ELT(VECTOR_ELT(df,0), 2, mkCharCE(zz, (utf8locale)?CE_UTF8:CE_NATIVE));
  // data.frameの第2ベクトル（列）は3つの要素からなる整数ベクトル
  SET_VECTOR_ELT(df, 1, allocVector(INTSXP, 3));
  INTEGER(VECTOR_ELT(df,1))[0] = 10;
  INTEGER(VECTOR_ELT(df,1))[1] = 20;
  INTEGER(VECTOR_ELT(df,1))[2] = 30;
  PROTECT(varlabels = allocVector(STRSXP, 2));//data.frameの列名を用意
  pc++;
  SET_STRING_ELT(varlabels, 0, mkCharCE("Name", (utf8locale)?CE_UTF8:CE_NATIVE));
  SET_STRING_ELT(varlabels, 1, mkCharCE("Age", (utf8locale)?CE_UTF8:CE_NATIVE));
  //オブジェクトをdata.frameと指定
  PROTECT(tmp = mkString("data.frame"));
  pc++;
  //行名を用意（ここでは単純な連番）
  PROTECT(row_names = allocVector(STRSXP, 3));
  pc++;
  SET_STRING_ELT(row_names, 0, mkCharCE("1", (utf8locale)?CE_UTF8:CE_NATIVE));
  SET_STRING_ELT(row_names, 1, mkCharCE("2", (utf8locale)?CE_UTF8:CE_NATIVE));
  SET_STRING_ELT(row_names, 2, mkCharCE("3", (utf8locale)?CE_UTF8:CE_NATIVE));
  setAttrib(df, R_ClassSymbol, tmp);//クラス属性の指定
  setAttrib(df, R_NamesSymbol, varlabels);//列名の設定
  setAttrib(df, R_RowNamesSymbol, row_names);//行名の設定
  UNPROTECT(pc);//プロテクトをまとめて解除
  return(df);
}
