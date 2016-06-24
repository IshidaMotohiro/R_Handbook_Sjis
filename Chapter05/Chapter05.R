# 第3版  2016年 06 月 18 日


############################################################
#                        第5章 行列                        #
############################################################






  ## ----- SECTION 063 行列オブジェクトの基礎知識
matrix (1:3, nrow = 3, ncol = 3)

matrix (1:2, nrow = 3, ncol = 3)

x <- matrix (1:9, nrow = 3, byrow = TRUE,
    dimnames = list (c ("row1", "row2", "row3"),
    c ("col1", "col2", "col3")))
x


# 型が異なる場合
matrix (c ("A", 1:8), nrow = 3)

# ゼロ行列（ベクトル）を作成
mat.or.vec (nr = 2, nc = 3)
matrix (0, 2, 3)


# コンソールから数値を入力する
# 改行後にEnterキーだけを押すと入力終了
y <- matrix (scan(), ncol = 3, byrow = TRUE) 





  ## ----- SECTION 064 行列の演算を行う
(x <- matrix (c (1, -2, 0, 3), nrow = 2))
(y <- matrix (c (-1, 4, 1, 2), nrow = 2))


# 行列積を求める
x %*% y

# t(x)  %*% y は以下の関数でも実行可能
crossprod (x, y)

# x %*% t (y) は以下の関数でも実行可能
tcrossprod (x, y)


# 対応する成分ごとの積を求める
x * y


# 外積を求める
x %o% y
outer (x, y)

# ベクトル同士の演算に利用
outer (1:9, 1:9)

# 演算子を変更
outer (1:9, 1:9, "-" )


# 数値以外でも利用できる
outer (LETTERS[1:3], LETTERS[1:3], paste)

# クロネッカー積
# x %x% y か、次の関数で実行
kronecker (x, y)

# Wikipedia
(X <- matrix(1:4, ncol = 2, byrow = TRUE))
(Y <- matrix(c(0,6,5,7), ncol = 2))

kronecker(X,Y)
X %x% Y

# 逆行列
x
x.1 <- solve(x)
x %*% x.1    
# 端数が出る場合は丸める
round (x %*% x.1)





  ## ----- SECTION 065 行列の次元ごとに演算を適用する
(x <- matrix (1, nrow = 2, ncol = 2))


# 1行目から1を、2行目からは2を引く
sweep (x, 1, 1:2)

# 1列目から1を、2列目からは2を引く
sweep (x, 2, 1:2)

# 演算を指定して実行
sweep (x, 1, 1:2, FUN = "+")

sweep (x, 2, 1:2, FUN = "+")


# 行ごとの合計。ただし、rowSums関数の方が効率的
apply (x, 1, sum)

# 列ごとの合計。ただし、colSums関数の方が効率的
apply (x, 2, sum)


(x <- matrix(1:4, nrow = 2, ncol = 2))


# 各要素に1を足してリスト形式で返す
lapply (x, "+", 1)

# 各要素に1を足してベクトル形式で返す
sapply (x, "+", 1)




  ## ----- SECTION 066 データフレームを行列に変換する
# データフレーム
x <- data.frame (x = 1:3, y = 4:6, z = 7:9)
str (x)

# 行列積が適用できない
x %*% x

# 行列演算が行えるようにする
(y <- as.matrix (x))

#  行列演算が適用可能
y %*% y

is.matrix (y)

# 列名などの属性が保持されている
str (y)

# 属性を削除して変換
z <- as.matrix (x, dimnames = NULL)
str (z)




  ## ----- SECTION 067 行列に列名と行名を設定する

(x <- matrix (1:9, nrow = 3, byrow = TRUE) )

rownames (x) <- paste ("R", 1:3, sep = "")
x

colnames (x) <- paste ("C", 1:3, sep = "")
x

dimnames (x) <- list (paste ("R", 1:3, sep = ""),
                      paste ("C", 1:3, sep = ""))
# 行名と列名を同時に削除
unname (x)



  ## ----- SECTION 068  行列の属性を確認する
(x <- matrix (1:12, nrow = 3, byrow = TRUE))

dim (x) # 行と列それぞれの次元数

attributes (x)

colnames (x) <- paste ("C", 1:4, sep = "")
rownames (x) <- paste ("R", 1:3, sep = "")
attributes (x)

# 列名だけ取り出す
attributes (x) $dimnames [[2]]
# 次元属性を4行3列に変更する
attr (x, "dim") <- c (4, 3)
x





  ## ----- SECTION 069 行列から成分を抽出/置換する
(x <- matrix (1:12, nrow = 3, byrow = TRUE))


# 3行目の4列を抽出
x [3, 4]

# 1-3行目の3列を抽出
x [1:3, 3]
# x [ , 3] と同義
# 3行目の1-3列目を抽出
# 出力はベクトルに変換される
x [3, 1:3]


# x [3, ] と同義
# 3行目4列目を行列として抽出
x [3, 4, drop = FALSE]

# 列ないし行名での抽出
colnames (x) <- paste ("C", 1:4, sep = "")
rownames (x) <- paste ("R", 1:3, sep = "")
x

x [ c ("R1", "R3"), c ("C2", "C3") ]
x

# 列を抽出
subset(x, select = 2:3)

#  subset引数を使うことで柔軟な出力がえられる
# 合計が10を超える行を取り出す
subset (x, subset = rowSums(x) > 10)




  ## ----- SECTION 070  行列を結合する
(x <- matrix (1:6, nrow = 2))

# 行列の下に1行追加
rbind (x, 7:9)

# 右に1列追加
cbind (x, 8:9)

# 要素数が足りない場合はリサイクルされる
rbind (x, 0)

cbind (x, 0)


# 追加しようとするベクトルの要素数が適合しない場合は切り詰めて警告が表示される
rbind (x, 1:7)


# 行列を結合
(y <- matrix (7:12, nrow = 2))
rbind (x, y)

rbind (1:3, 4:6)


# 列名を明示的に設定した行列
x <- cbind (c1 = 1:3, c2 = 4:6 )
x

# 引数がシンボルとして意味があれば列名として利用（deparse.level = 1はデフォルト）
cbind (x, 4:6, deparse.level = 1)#この場合 4:6 はラベル化されない

# シンボル以外でも列名に設定する
cbind (x, 4:6, deparse.level = 2)

# 引数をラベルとはしない（この場合はデフォルトと同じ結果）
cbind (x, 4:6, deparse.level = 0)





  ## ----- SECTION 071 行列をベクトルに変換する
(x <- matrix (1:6, nrow = 2) )

as.vector( x )


# 次元属性を削除する
dim (x) <- NULL
x

# 構造を確認
str (x)





  ## ----- SECTION 072 対角行列を作成する
# デフォルトでは対角成分は1
(x <- diag (3))

# 対角成分を指定
(x <- diag (1:5))

  # ちなみに行列を指定すると対角成分が使われる
  diag(matrix(1:9, nrow = 3))





  ## ----- SECTION 073 三角行列を作成する

(x <- matrix (1:9, nrow = 3))

# 行列の左下を抽出
lower.tri (x) # 対角成分はデフォルトでは「FALSE」

# 「TRUE」と判断された成分に0を代入して上三角行列を作成
x [ lower.tri (x) ] <- 0
x

# 同じ行列をもう一度用意し
y <- matrix (1:9, nrow = 3)
# 対角成分を除いた上三角行列を作成
y [ lower.tri (y, diag = TRUE) ] <- 0
y

# 下三角行列を作成する
y <- matrix (1:9, nrow = 3)
y [ upper.tri (y) ] <- 0
y






  ## ----- SECTION 074 転値行列を作成

(x <- matrix (1:8, ncol = 2))

# 転置する
t (x)
(y <- data.frame (a = 1:3, b = LETTERS[1:3]))

# データフレームも転置可能だが、データ形式が変換される
t (y)






  ## ----- SECTION 075 列や行ごとの和や周辺和を求める
(x <- matrix (1:6, nrow = 2))

# 行合計
rowSums (x)

# 列合計
colSums (x)

# 周辺和
addmargins (x)

# 列合計を行として追加
addmargins (x, 1)

# 行合計を列として追加
addmargins (x, 2)
# 合計ではなく平均
addmargins (x, FUN = mean)

# 行と列の範囲を限定して合計を求める
(x <- matrix (1:9, ncol = 3))
# mは行数nは列数
.colSums(x, m = 3, n = 2)
.rowSums(x, m = 3, n = 2)




  ## ----- SECTION 076 固有値分解・特異値分解を適用する

(x <- matrix (c (4, 1, 1, 4), nrow = 2))

(y <- eigen (x))

# 固有値
y$values
# 対応する固有ベクトル（正規化されている）
y$vectors

# 特異値分解
mat <- matrix (c (1,0,0,0,1,0,
 0,1,0,1,0,1,
 0,1,0,0,0,0,
 0,1,0,0,0,0,
 0,0,1,0,0,1,
 1,1,1,1,0,0,
 0,0,1,2,1,0,
 1,1,0,0,0,0), nrow = 8, byrow = T)

# 特異値分解を行う
mat.svd <- svd (mat)
# 特異値
mat.svd$d

# 対応する左特異値ベクトル
mat.svd$u

# 対応する右特異値ベクトル
mat.svd$v

#もとの行列を復元
mat2 <- mat.svd$u %*% diag(mat.svd$d) %*% t( mat.svd$v)
# 確かに同一か
all.equal (mat, mat2)




  ## ----- SECTION 077 疎な行列を効率的なデータ構造に変換する

# 基本パッケージをロードする
library ( Matrix )

# 0 以外の成分のある行番号を指定
i <- c (1,3:8)
# 0 以外の成分のある列番号を指定（9列目は2回指定）
j <- c (2,9,6:10)
# 0 以外の成分をベクトルとして指定
x <- 1:7

(A <- sparseMatrix (i, j, x = x))


summary (A)
str (A)


# 疎な行列
(B <- as (x, "sparseMatrix"))


summary (B)


str (B)



  ## ----- SECTION 078 BLAS の導入

# sudo apt-get install libblas-dev liblapack-dev libatlas-base-dev
# ./configure --with-blas

# 以下はオプション指定の例です
# ./configure --with-blas='-L/usr/lib64/atlas -latlas -lptf77blas -lpthrea' --with-lapack='-L/usr/lib64/atlas -llapack -lptcblas'

A <- matrix (runif (1000 * 1000), 1000, 1000)
B <- matrix (runif (1000 * 1000), 1000, 1000)
system.time (A %*% B)

