
/* ���X�g���쐬���� my_list.c */
#include <R.h>
#include <Rdefines.h>
SEXP myList (SEXP x, SEXP y, SEXP z){
  SEXP my_list , my_listnames;
  //���X�g�v�f�̖��O�Ƃ��镶����
  char *my_names[3] = {"string", "integer", "numeric"};
  int i, j = 0;
  //�v�f�ƂȂ�x�N�g����3�̃��X�g���`
  PROTECT(my_list = allocVector(VECSXP, 3)); j++;
  SET_VECTOR_ELT(my_list, 0, x);
  SET_VECTOR_ELT(my_list, 1, y);
  SET_VECTOR_ELT(my_list, 2, z);
  //���X�g�̗v�f����ݒ�
  PROTECT(my_listnames = allocVector(STRSXP, 3));j++;
  for(i = 0; i < 3; i++)
	SET_STRING_ELT(my_listnames, i, mkChar(my_names[i]));
  setAttrib(my_list, R_NamesSymbol, my_listnames);
  UNPROTECT (j);// �ی�̉���
  return my_list;
}
