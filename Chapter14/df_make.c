/* �f�[�^�t���[���̍쐬 df_make.c */
#include <R.h>
#include <Rdefines.h>
extern int utf8locale;//���P�[���𔻒f
SEXP dfMake(SEXP x, SEXP y, SEXP z){
  int pc=0;// PROTECT�X�^�b�N�̊Ǘ�
  SEXP df, varlabels, tmp, row_names;
  const char* xx = CHAR(STRING_ELT(x, 0));//������̕ϊ�
  const char* yy = CHAR(STRING_ELT(y, 0));
  const char* zz = CHAR(STRING_ELT(z, 0));
  PROTECT(df = allocVector(VECSXP, 2));// �x�N�g���v�f��2���� data.frame
  pc++;
  // data.frame�̑�1�x�N�g���i��j��3�̗v�f����Ȃ镶���x�N�g��
  SET_VECTOR_ELT(df, 0, allocVector(STRSXP, 3));
  SET_STRING_ELT(VECTOR_ELT(df,0), 0, mkCharCE(xx, (utf8locale)?CE_UTF8:CE_NATIVE));
  SET_STRING_ELT(VECTOR_ELT(df,0), 1, mkCharCE(yy, (utf8locale)?CE_UTF8:CE_NATIVE));
  SET_STRING_ELT(VECTOR_ELT(df,0), 2, mkCharCE(zz, (utf8locale)?CE_UTF8:CE_NATIVE));
  // data.frame�̑�2�x�N�g���i��j��3�̗v�f����Ȃ鐮���x�N�g��
  SET_VECTOR_ELT(df, 1, allocVector(INTSXP, 3));
  INTEGER(VECTOR_ELT(df,1))[0] = 10;
  INTEGER(VECTOR_ELT(df,1))[1] = 20;
  INTEGER(VECTOR_ELT(df,1))[2] = 30;
  PROTECT(varlabels = allocVector(STRSXP, 2));//data.frame�̗񖼂�p��
  pc++;
  SET_STRING_ELT(varlabels, 0, mkCharCE("Name", (utf8locale)?CE_UTF8:CE_NATIVE));
  SET_STRING_ELT(varlabels, 1, mkCharCE("Age", (utf8locale)?CE_UTF8:CE_NATIVE));
  //�I�u�W�F�N�g��data.frame�Ǝw��
  PROTECT(tmp = mkString("data.frame"));
  pc++;
  //�s����p�Ӂi�����ł͒P���ȘA�ԁj
  PROTECT(row_names = allocVector(STRSXP, 3));
  pc++;
  SET_STRING_ELT(row_names, 0, mkCharCE("1", (utf8locale)?CE_UTF8:CE_NATIVE));
  SET_STRING_ELT(row_names, 1, mkCharCE("2", (utf8locale)?CE_UTF8:CE_NATIVE));
  SET_STRING_ELT(row_names, 2, mkCharCE("3", (utf8locale)?CE_UTF8:CE_NATIVE));
  setAttrib(df, R_ClassSymbol, tmp);//�N���X�����̎w��
  setAttrib(df, R_NamesSymbol, varlabels);//�񖼂̐ݒ�
  setAttrib(df, R_RowNamesSymbol, row_names);//�s���̐ݒ�
  UNPROTECT(pc);//�v���e�N�g���܂Ƃ߂ĉ���
  return(df);
}
