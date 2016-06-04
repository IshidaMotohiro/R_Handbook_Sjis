# 改訂第3版　2016年2月16日

############################################################
#                   第3章 ベクトルの基礎                   #
############################################################






  ## ----- SECTION 023 ベクトルの基礎知識
x <- c (1, 3, 5, 7, 9)
# 2 番目の要素
x  [1]
# 3番目から5番目の要素
x  [3:5]
# 3番目と5番目の要素
x  [c (3, 5)]
# 2番目と4番目を除いて抽出
x  [-c (2,4)]

# 以下では「double」がもっとも表現力が豊か
(z1 <- c (1.1, 1, TRUE) )
typeof (z1)
# 以下では「complex」がもっとも表現力が豊か
(z2 <- c (1+1i, 1.1, 1, TRUE) )
typeof (z2)
# 「character」がもっとも表現力が豊か
(z3 <- c ("i", 1+1i, 1.1, 1) )
typeof (z3)



x <- c(1, 3, 5, 7, 9)
# ベクトルの要素には名前を付けられる
names (x) <- c("A", "B", "C", "D", "E")
x
# 名前を添字に使える
x [c ("A", "C")]


# コロンを使うと連続した整数を初期化できる
x <- 1:10
# 各要素に1を足す
x + 1
# まとめて合計を計算
sum (x)

x <- 1:10
# 5より大きいか
x > 5
# 5より大きな要素を抽出
x [ x > 5 ]




  ## ----- SECTION 025 数値ベクトルを初期化する
# 空の数値オブジェクトを用意する
# 以下は 4 種類の基本オブジェクトを作成
(xNum <- numeric ())
(xInt <- integer ())
(xDou <- double ())
(xCom <- complex())

# それぞれのタイプを確認する
typeof (xNum)
typeof (xInt)
typeof (xDou)
typeof (xCom)

# 5個の0を要素とするベクトルを作成
(x <- integer (5))

# 複素数の場合
# 1 + i だと i が別のオブジェクトとして扱われる
(x <- 1+1i)

# 複数の値をまとめて1つのオブジェクトに代入
(y <- 1:10)


# 16進法表現
(z <- 0xF)
class (z)
typeof (z)

# 16進法表現では指数を指定できる
0xAP2
0xAP3


(y <- complex (real = 1, imaginary = 1))
(y <- complex (real = 1:3, imaginary = 1:3))
(y <- complex (real = 1, imaginary = 1))




  ## ----- SECTION 026

# 1から5までの自然数の数列をオブジェクトxに作成
(x <- 1:5)
# 「seq」関数を使った数列の作成
(x <- seq (from = 1, to = 5, by = 1))
# 引数名は省略可能
(x <- seq (1, 5, 1))
# 引数が1つのときは終項と見なされる（初項=1、公差=1）
(y <- seq (5))
# 「along.with」引数で指定された要素数となる数列を返す
(x <- seq (10, 20, along.with = 1:5))
# 2つ間隔をおいた数列
(x <- seq (1, 10, by = 2))
# 公差をマイナス指定
(x <- seq (1, -10, -2 ))
# 整数以外にも適用できる
(y <- seq (0, 1, 0.2))


sequence (1:3)
# sequence (1：3) は以下の出力を結合したのと同じ結果となる
seq_len (1); seq_len (2); seq_len (3);

sequence (c (5, 2))
# sequence (c (5, 2)) は以下の出力を結合したのと同じ結果となる
seq.int (5); seq.int (2)

# 文字列が数字を表す場合には数値として見なされる
sequence (c ("5", "2"))

(z <- sequence (5))
(z <- seq_len (5))
(z <- seq.int (5))




  ## ----- SECTION 027  要素を繰り返した数列を作成する
# オブジェクトの中身を繰り返す
x <- c (1, 3, 7)
rep (x, 3)
# 同じだがR内部での処理が効率的
rep.int (x, 3)
# 全体の長さ 10 になるまで繰り返す
rep (x, length = 10)


rep (1:3, each = 3)
rep (1:3, times = 3)
rep (1:3, length.out = 10, each = 3)
# 1 を 5 回、10 を 1 回
rep (c (1, 10), c (5, 1))





  ## ----- SECTION 028 ランダムな数値ベクトルを作成する
# サイコロを 1 回ふる
sample (1:6, 1)
# 数列の並べ
sample (1:6)


# サイコロを 10 回ふる
sample (1:6, 10)

# 復元抽出を指定
sample (1:6, 10, replace = TRUE)

# 抽出確率を操作し、目が大きいほど抽出されやすくする
sample (1:6, 10, replace = TRUE, prob = 1:6 )
# 各要素に抽出確率を指定
sample (1:6, 10, replace = TRUE, prob = rep (c (1/10, 5/10), c (5, 1)))





  ## ----- SECTION 029 数値ベクトルを区間分割する

x <- 1:15
y <- cut (x, breaks = c (0, 5, 10, 15) )
# 頻度表にする
table (y)

# ラベルを付ける
y <- cut (x, breaks = c (0, 5, 10, 15), labels = c ("上", "中", "下") )
# 頻度表にする
table (y)

z <- rnorm (1000, mean = 50, sd = 10)
# 四分位数で分割
z1 <- cut (z, breaks = quantile(z) )
# 最小値が1個欠けた頻度が表示されている
table (z1)

# 最小値を含ませる
z2 <- cut (z, breaks = quantile(z), include.lowest = TRUE)
table(z2)


# 最大値が欠けている
z3 <- cut (z, breaks = quantile(z), right = FALSE )
table (z3)

# 最大値を含ませる
z4 <- cut (z, breaks = quantile(z), include.lowest = TRUE,
     right = FALSE )
table (z4)





  ## ----- SECTION 030  標本などのベクトルを標準化する

# 疑似データ
x <- c (0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
# 平均値と標準偏差を表示
mean (x)
sd (x)

# 標準化する
xs <- scale (x)
# オブジェクト「xs」の中身は標準化の結果と
# 標準化前の平均値と標準偏差を表示
xs

# 標準化後の平均値と標準偏差を表示
mean (xs)
sd (xs) # 警告がでます





  ## ----- SECTION 031  数値クラスを変更する

# デフォルトでは実数クラスと扱われる
x1 <- 10
typeof (x1)

# 数値の最後にLを付加
x2 <- 10L
typeof (x2)
identical (x1, x2)

# 型を整数型に変更する
x1 <- as.integer (x1)
identical (x1, x2)

# 15を実数および整数として初期化
y1 <- 15
y2 <- 15L
identical (y1, y2)

# 型を実数型に変更する
y2 <- as.double (y2)
identical (y1, y2)




  ## ----- SECTION 022  数値を文字列に変更する

x <- 1:10
# 結果は複数の文字列からなるベクトル
as.character (x)
# 入力コードそのものを表示する
deparse (x)

y <- c (1, 10, 100, 1000, 10000)
format (y)

# 表示桁数を揃えるためのスペースを削除する
format (y, trim = TRUE)
# 3桁ごとに区切りを指定
format (y, big.mark = ",", trim = TRUE)

# 小数点の表示桁数を指定
z <- seq (0, 1, 0.1)
# 小数点第3位まで表示
format (z, nsmall = 3)


# 科学書式を使う
format (2^8-1, scientific = TRUE)

# デフォルトの小数点表示幅
getOption ("digits")
# 書式情報を表示する
(x <- 1234567890); format.info (x)

(x <- 1.234567890); format.info (x)

(x <- 123456.7890); format.info (x)
(x <- 1234567.890); format.info (x)

(x <- 1e8); format.info (x)

(x <- 1e-123); format.info (x)


x <- 0.12345678901234567890; x
op.old <- options(digits = 22) ; x
# デフォルトの桁数に戻す
options (op.old); x

# 「sprintf」関数を利用する
z1 <- pi * 10 ^ (-5:4)
sprintf ("%.5f", z1)

sprintf ("%e", z1)





  ## ----- SECTION 033 数値を比較する


(x <- 10)
(y <- as.integer (10))
# xとyはクラスは異なる
identical (x, y)
# xとyは数値としては等しい
x == y

# 小数点を含む計算
(x <- .1+.1+.1+.1+.1+.1+.1+.1+.1+.1)
# 厳密には1ではない
sprintf ("%.16f", x)
(y <- 1)

# 浮動小数点誤差のため等しくない
x == y

# ほぼ等しいか
all.equal (.1+.1+.1+.1+.1+.1+.1+.1+.1+.1, 1.0)


# ただしif文では使わないこと
all.equal (pi, 355/113)
if (all.equal (pi, 355/113) ) print ("eqaul")

# 「identical」関数を使う
identical (all.equal (pi, 355/113), TRUE)

# ベクトルの比較
x3 <- c (1L, 2L, 3L)
x4 <- c (1, 2, 4)

x3 == x4
all.equal (x3, x4)
all.equal (x3, x4, tolerance = 0.5)

(x <- 2.3 - 1.3)
sprintf ("%.16f", x)

if (x >= 1) print ("x >= 1") else print ("x < 1")


ifelse (x >= 1, "x >= 1", "x < 1") # 同じ処理

if (zapsmall (x) >= 1) print ("x >= 1") else print ("x < 1")



# ベクトル、配列、行列を作成
(x <- 1:9)

(y <- array(1:9, dim = c (3,3)))

(z <- matrix (1:9, nrow = 3, byrow = TRUE ))

# 対応する数値の比較
x == y; x == z; y == z

# 以下は真になる（ただし警告が出る）ので注意
if (y == z) TRUE else FALSE

# 全部が一致するか
if (all (y == z)) TRUE else FALSE

# 一部でも一致するか
if (any (y == z)) TRUE else FALSE


