# ������3�Ł@2016�N2��15��

############################################################
#                 ��2�� �I�u�W�F�N�g�̊�b                 #
############################################################





  ## ----- SECTION 015  �I�u�W�F�N�g�̊�b
x <- 10
# �I�u�W�F�N�g�̒��g���m�F
x
# �I�u�W�F�N�g���͔��p�A���t�@�x�b�g�Ɛ��l���g����
x1 <- 1
# �I�u�W�F�N�g�̒��g���m�F
x1

# �I�u�W�F�N�g���͐��l�Ŏn�܂��Ă͂����Ȃ�
# �ȉ��̓G���[�ɂȂ�
1x <- 1
# �Ђ炪�Ȋ����Ȃǂ̑S�p���������p�͂ł���
�� <- "��"
��
#[1] "��"

# �I�u�W�F�N�g���ɔ��p�X�y�[�X�����ނ��Ƃ͂ł��Ȃ�
x 1 <- 1


# �L�����g�����Ƃ��ł��邪�A���_�[�o�[�𓪂ɒu�����Ƃ�
# �ł��Ȃ��Ȃǂ̐���������
.var <- 1e5 # 1e5 �� 100000 �̂���
.var

# �ȉ��̓G���[�ɂȂ�
_var <- 1e5

# �N�I�[�g����Ɣ��p�X�y�[�X���g�����Ƃ��ł���
`name with space` <- "ABC" # �o�b�N�N�I�[�g
'name with space' <- "DEF" # �_�u���N�I�[�g
"name with space" <- "GHI" # �V���O���N�I�[�g

# �I�u�W�F�N�g�Ƃ��ė��p����ꍇ���N�I�[�g�ň͂�
`name with space`

# �ȉ��̓G���[�ɂȂ�
name with space

�@�@# SECTION-016 �I�u�W�F�N�g�̃^�C�v�ƃf�[�^�\��

sum (1:10)
sum (c(1, 3, 5, 7, 9))

�@�@# SECTION-017 �I�u�W�F�N�g�̃^�C�v�ƃf�[�^�\��
x <- 1
typeof (x)
# �ux�v�ɐ��l��1��������
x <- 1
# �I�u�W�F�N�g�ux�v�̃��[�h���m�F����
mode (x)

# �I�u�W�F�N�g�ux�v�̃^�C�v���m�F����
typeof (x)
# �I�u�W�F�N�g�ux�v�̃X�g���[�W���[�h���m�F����
storage.mode (x)
# �umoji�v�ɕ�����������
moji <- "��"
# �I�u�W�F�N�g�umoji�v�̃��[�h���m�F����
mode (moji)

x <- c (1, 2, 3)
str (x)

z <- factor (x, labels = c ("A", "B", "C"))
z

class (z)
str (z)
attributes (z)

x <- c (1, 2, 3)
x

mode (x)

typeof (x)

y <- 1:5
y

x [1]
x [c (1, 2)]
x [c (1, 3)]
x [c (2, 3)]
y [2:3]




  ## ----- SECTION 018 �N���X�ƃI�u�W�F�N�g

class (x)
# �ux�v�ɐ��l��1��������
x <- 1
# �I�u�W�F�N�g�ux�v�̃��[�h���m�F����
mode (x)
# �I�u�W�F�N�g�ux�v�̃^�C�v���m�F����
typeof (x)
# �I�u�W�F�N�g�ux�v�̃��[�h��ύX����
mode (x) <- "integer"
# �ύX��̃I�u�W�F�N�g�ux�v�̃^�C�v���m�F����
typeof(x)
# �I�u�W�F�N�g�ux�v�̃X�g���[�W���[�h���m�F����
storage.mode (x)

# �umoji�v�ɕ�����������
moji <- "��"
# �I�u�W�F�N�g�umoji�v�̃��[�h���m�F����
mode (moji)
# �I�u�W�F�N�g�umoji�v�̃��[�h��ύX����
mode (moji) <- "integer"

# �I�u�W�F�N�g�umoji�v�̒��g�������I��NA�ɕϊ�����Ă���
moji
# �ύX��̃I�u�W�F�N�g�umoji�v�̃^�C�v���m�F����
typeof (moji)

methods (print)
# �ʏ�̕����I�u�W�F�N�g
x <- "A"
print (x)

# �Ǝ��̃��\�b�h���`
print.str <- function (x ){
  cat ("x = ", x, "; charToRaw (x) = ", charToRaw (x), "\n");
}
# �I�u�W�F�N�g�̃N���X��ݒ�
class (x) <- "str"
# ���\�b�h���Ăяo��
print (x)




  ## ----- SECTION 019 �I�u�W�F�N�g�̐���
# R�͐��l�╶���Ȃǂ��f�[�^�Ƃ��ă������ɓW�J����
# �P�Ƃ̒l�i�X�J���[�j���I�u�W�F�N�g�ɑ��
x <- 1
# ������ʂ��Q�Ƃ���
x
# ���ۂɂ̓x�N�g���Ȃ̂œY�����w��ł���
x [1]
# �����̒l���܂Ƃ߂�1�̃I�u�W�F�N�g�ɑ��
(y <- 1:10)
# ������S�̂��ۊ��ʂň͂�ł����Ƒ�����ʂ��\�������

# �E�ӂƍ��ӂ��t�ɂ��邱�Ƃ��ł��Ȃ����Ƃ��Ȃ�
(c ("A", "B") -> z)

# �ȉ��͑���̕ʂ̕��@
(x = 1)
(`<-` (z, 1))
(assign ("z", 1))

# �����̖��߂�1�s�ɂ܂Ƃ߂�
x <- 1:100; mean (x)





  ## ----- SECTION 020  �I�u�W�F�N�g�̑����̊m�F�E�ύX
# �x�N�g���𐶐�
z <- 1:12
# ���O�����͂Ȃ��iNULL�j
names (z)
# ���O������ݒ�
attr (z, "names") <- LETTERS[1:12]
z

# names (z) <- LETTERS[1:9] �ł�����
# �N���X�������m�F
class (z)
# 4�s3��̎�����ݒ�
attr (z, "dim") <- c (4,3)
# dim (z) <- c (4,3) �ł�����
z


# �����ɖ��O������^����
attr (z, "dimnames") <- list (row = c ("r1", "r2", "r3", "r4"),
                              col = c ("c1", "c2", "c3"))
# dimnames (z)<- list (row = c("r1", "r2", "r3", "r4"),
# col = c ("c1", "c2", "c3"))
# �Ƃ��Ă�����
z

attributes (z)

# ���O�����͕s�v�Ȃ̂ō폜����
attr (z, "names") <- NULL
attributes (z)

class (z)

x <- 1:10
attr (x, "dim") <- c(3, 3)

dim (z) <- c (4, 3)




  ## ----- SECTION 021 ����I�u�W�F�N�g�̍쐬
# �������\�����I�u�W�F�N�g�ɕύX����
x <- parse (text = "a * b * c")
x
mode (x)

# ����I�u�W�F�N�g�ł��邩
is.language (x)
# ���s�i�]���j���Ă݂�
# �\�����ux�v���́ua,b,c�v�͒�`����Ă��Ȃ�
eval (x)

# �ueval�v�֐����Łua,b,c�v�̒l���w�肷��
eval (x, list (a = 1, b = 2, c = 3))

# �\�����I�u�W�F�N�g�𕶎���ɕϊ�
x1 <- deparse (x)
x1
mode (x1)

#####
# �\�����I�u�W�F�N�g�𒼐ڍ쐬
y <- expression (a * b * c)
y
mode (y)
eval (y, list (a = 1, b = 2, c = 3))


#�@�\���������X�g�Ƃ��ĕ\�����Ă݂�
y <- as.list (y); is.list (y)


#�@�S�̂̍\�� `*` ([`*` (a, b)] , c)
str (y[1])

#�@�ŏ��̗v�f�͉��Z�q `*` 
y [[1]] [1]
#�@���̑�P����
y [[1]] [2]

# �������͓���q�ł�͂艉�Z�q������
y [[1]] [[2]][1]
# �ŏ��̉��Z�q�uy [[1]] [1]�v�̑�Q����
y [[1]] [3]

#####
# �Ăяo���I�u�W�F�N�g���쐬
z <- call ("+", 7, 8)
z

mode (z)
# ����I�u�W�F�N�g�ł��邩
is.language (z)

eval (z)

# �Ăяo���I�u�W�F�N�g�͖��O�I�u�W�F�N�g��v�f�Ƃ��郊�X�g�\��
z [[1]] ; class (z[[1]])
z [[2]]
z [[3]]

# ����I�u�W�F�N�g�ł��邩
is.language (z [[1]])
# �萔2�͌���I�u�W�F�N�g�ł͂Ȃ�
is.language (z [[2]])
# ���O�I�u�W�F�N�g�ł��邩
is.name (z [[1]])

# �萔�͖��O�I�u�W�F�N�g�ł͂Ȃ�
is.name (z [[2]])
# �^�C�v�𒲂ׂ�
typeof (z [[1]])
typeof (z [[2]])

# ���Z�q���u+�v����u*�v�ɕύX
z [[1]] <- as.name ("*")
eval (z)�@# �v�Z���́u7*8�v�ɕς��
# [1] 56

# �\�����𕶎���ɕϊ�
z1 <- deparse (z)
z1





  ## ----- SECTION 022 �I�u�W�F�N�g�Ȃǂ̃������Ǘ� 

# ��̃I�u�W�F�N�g���쐬
x <- character ()
x
object.size (x)�@# Widnows��64bit�łł̎��s����
x <- "�Γc��L"
# �����̃T�C�Y���m�F
object.size (x)

# ���[�N�X�y�[�X�S�̂̃������g�p��
object.size (ls)
# �P�ʂ��L���o�C�g�ɕύX���ĕ\��
print (object.size (ls), units = "Kb")
gc ()


# �������̍Ċ��蓖��

iris2 <- iris
tracemem(iris2)
iris2$Sepla.Length <- sqrt(iris2$Sepal.Length)
tracemem(iris2)

LL <- list (A = LETTERS, B = 1:26, C = letters)
tracemem(LL)
tracemem(LL$A)
tracemem(LL$B)
tracemem(LL$C)
LL$B <- LL$B * 10

tracemem(LL)