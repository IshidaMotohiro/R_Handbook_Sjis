# 第3版  2016年 06 月 18 日

############################################################
#                 第７章 リスト／配列／表                  #
############################################################



  ## ----- SECTION 097 リスト処理の基礎

.Platform

# 線形回帰を行う
lm1 <- lm ( Sepal.Length ~ Sepal.Width, data = iris )
summary (lm1)

is.list (lm1)
# オブジェクト「lm1」はリスト構造
str (lm1)




  ## ----- SECTION 098 リストを作成する
(myList <- list (x = 1:5, y = data.frame (a = 1:5, b = LETTERS[1:5]),
                 z = matrix(1:9, nrow = 3)))
# 要素をリストとして取り出す
myList [1]

# myList$x # 上と同じ
# myList ["x"] # 上と同じ
# 要素をベクトルとして取り出す
myList [[1]]

myList$y$b

# リストの「y」要素の「b」要素
myList$y$b
# 上記は以下と同じ
myList [[2]][[2]]
# myList [[ c(2, 2)]] としてもよい

# 2つ目の添字に単独の [ ] を使った場合
myList [[2]][2]

# 5個の乱数を4列生成
(z <- lapply(rep(5, 4), rnorm))
#リストの各要素を列とする配列に変換
(z2 <- do.call(cbind, z))


# 学生データを再帰的なリストとして生成
students <- list (id1 = list (
  name = "鈴木",
  sex = "男",
  grades =list ( 国語 = 52 , 数学 = 55, 英語 = 58)),
  id2 = list (
    name = "佐藤",
    sex = "女",
    grades = list ( 国語 = 71, 数学 = 73, 英語 = 77)),
  id3 = list (
    name = "山田",
    sex = "女",
    grades = list ( 国語 = 90, 数学 = 92, 英語 = 99)))

# 
install.packages ("rlist")
library (dplyr) ; library (rlist)
# リストから名前を取り出す
students %>% list.map(name)

# リストから名前と性別を取り出す
students %>% list.select (name, sex)

# 表示形式指定して取り出す
students %>% list.iter (cat (name, ":", sex, "\n"))

# 条件を指定して取り出し、その結果の表示形式を指定する
students %>% list.filter (grades$国語 > 70) %>%
  list.iter (cat (name, ":", sex, ":", grades$国語 ,"\n"))



  ## ----- SECTION 099 リストをベクトルに変換する
(myList <- list (x = 1:3, y = LETTERS[1:3],
                 z = as.factor (letters[1:3])))

unlist( myList )


unlist (myList, use.names = FALSE)


# 因子の場合
(myList2 <- list (x = as.factor (letters [1:3]),
                  y = as.factor (letters [2:4]) ) )

 # 因子のカテゴリは統合される
 unlist (myList2)

 # リストにリストが含まれている場合
(myList3 <- list (x = 1:2, y = list (10:13, letters [1:3])))

 # 再帰的に展開する
unlist (myList3)

# リストの各要素ごとに、それらが含む要素を
#  独立したベクトルとして抽出してリスト化
(myList4 <- unlist (myList3, recursive = FALSE))

str (myList4)




  ## ----- SECTION 100 リストの要素ごとに演算を行う

(x <- list (A = 40:60, B = 50:70, C = 60:80))
# 各要素の分位点を計算
sapply (x, fivenum)

# 出力のチェックを行う
vapply (x, fivenum )

# 出力の照合を兼ねて、形式を調整する
vapply(x, fivenum, c ("最小値" = 0, "第一分位点" = 0,
                      "中央値" = 0, "第三分位点" = 0, "最大値" = 0))


# リストの要素にさらにリストが含まれてる
(X <- list (first = list (a = 9,
     b = list (c = 25, d = c("奥のリスト要素1", "同じく") )),
     second = "外のリスト") )

# 数値クラスの要素だけ平方根「sqrt」を求めて
 # 該当要素を簡易出力(「unlist」)する
rapply (X, sqrt, classes = "numeric" )
 # sapply(X, sqrt) # はエラー


# もとのリストを、該当する要素を演算で置き換えた結果を返す
rapply (X, sqrt, classes = "numeric", how = "replace")

#「nchar」関数で文字数を数えた結果で置きかえる
rapply (X, nchar, classes = "character", how = "replace")

# 「charater」以外の要素はデフォルト（「deflt」）として
# 「"No character"」で置き換える
rapply (X, nchar, classes = "character",
        deflt = "No character", how = "list")






  ## ----- SECTION 101 配列（Array）オブジェクトの基礎
# 髪と眼の色の対応
HairEyeColor

# R組み込みのTitanic号のデータを使用
is.array (Titanic)

str (Titanic)

Titanic

 # 「Class」が「1st」で「Sex」が「Female」での年齢と生存を出力
Titanic [1, 2, , ]
Titanic ["1st", "Female", , ]




  ## ----- SECTION 102 配列オブジェクトを作成する

(x <- array (1:12, dim = c (3, 4)))

# 行列と変わらない
class (x)

attributes ( x )

# 次元を指定しない場合
(x <- array (1:12))

class (x)

# 次元属性を指定
(y <- array (1:12, dim = c (2, 2, 3)))

# クラスは配列
class (y)

# 次元属性を確認
attributes (y)

str (y)

# 添字を使ってアクセスする
# 配列の「1枚目の表」
y [ , , 1]

# 配列の「2枚目の表」
y [ , , 2]

# 配列の各「表」の1行目
y [ 1, , ]

# 配列の各「表」の1列目
y [ , 1, ]

# 配列に名前を付ける
N <- list (R = paste ("ROW", 1:2, sep = ""),
           C = paste ("COL", 1:2, sep = ""),
           T = paste ("TAB", 1:3, sep = ""))
dimnames (y) <- N
y

# 配列の要素「T」の名前を確認
dimnames (y) $T
# dimnames (y$T) はエラーになるので注意

y [ , , c ("TAB1", "TAB2") ]

# 配列からの条件抽出
y [ y > 5 ]

## [1] 6 7 8 9 10 11 12
# 配列の要素の置き換え
y [ y > 5 ] <- 0
y

   # library(rlist)
   # list.map(y, y > 5)



  ## ----- SECTION 103 配列の次元ごとに計算する

(y <- array (c (rep (1, 6), rep (2, 6), rep (3,6), rep (4,6)),
             dim = c (2, 3, 4)) )
# 各行の合計(1+1+1)+(2+2+2)+(3+3+3)+(4+4+4)が2行
apply (y, 1, sum) # apply (y, c(1), sum) でもよい

# 各列の合計(1+1)+(2+2)+(3+3)+(4+4)が3列
apply(y, 2, sum)

# 「表4枚」それぞれの合計
apply (y, 3, sum)

# 各「表」のセルごとに合計(1+2+3+4)が1枚
apply (y, c (1, 2), sum)

# 行を表ごとに合計(1+1+1)、(2+2+2)、(3+3+3)、(4+4+4)が2行
apply (y, c (1, 3), sum)

# 列を表ごとに合計(1+1)、(2+2)、(3+3)、(4+4)が4列
apply (y, c (2, 3), sum)

 # apply(y, 2:3, sum) # 同じ
 # 関数に引数を追加
 apply (y, 1, "*", 5) # apply (y, 1, `*`, 5) でもよい


 (x <- array (1:8, c (2,2,2)))

 # 要素の抽出
 x [3:6]

 # 要素の置換
 x [3:6] <- 0
 x






  ## ----- SECTION 104 配列に周辺度数を追加する

# 2行3列の表を二つ用意
(y <- array (c (rep (1, 6), rep (2, 6)), dim = c (2, 3, 2)) )

# 各「表」ごとに周辺度数を追加
addmargins (y)
# 最後の出力は二つの「表」の対応するセルごとの合計


# 列合計だけ追加
addmargins (y, margin = 1)

# 行合計だけ追加
addmargins ( y, margin = 2)

# 対応するセルを合計した表を一つ追加
addmargins (y, margin = 3)

# 行と列それぞれの合計を表示
addmargins (y, margin = c (1, 2))

# addmargins (y, margin = 1:2) #でも同じ





  ## ----- SECTION 105 多次元配列を2次元に変換する
(x <- array (1:12, dim = c(2, 2, 3)))

N <- list (sex = c ("F", "M"), course = c ("理系", "文系"),
           class = c ("A", "B", "C"))
dimnames (x) <- N

x

# フラットな表を作成する
ftable (x)

# R組み込みのTitanic号データ
Titanic

# 各次元の名前を確認
dimnames (Titanic)
# フラットに変換
ftable (Titanic)


# 最初の3つの次元を行変数に適用
ftable (Titanic, row.vars = 1:3)

# 最初の2つの次元を行変数に適用し、列変数は変数名で指定
ftable (Titanic, row.vars = 1:2, col.vars = "Survived")


# 行変数の順番を入れかえる
ftable (Titanic, row.vars = 2:1, col.vars = "Survived")

# 列側に複数の次元名を指定
ftable (Titanic, row.vars = 2:1, col.vars = c("Age", "Survived"))





  ## ----- SECTION106 配列を転置する
# 前節の最初に作成したオブジェクト「x」を利用します
x <-  array (1:12, dim = c(2, 2, 3),
               dimnames = list (sex = c ("F", "M"),
                   course = c ("理系", "文系"),
                   class = c ("A", "B", "C")))
x

# デフォルトの転置。次元を逆にする
aperm (x)
# aperm (x, c (3, 2, 1))# と同じ

# 表の行と列を入れかえる
aperm (x, c (2, 1, 3) )

# 列を表に分ける
aperm (x, perm = c (3, 1, 2))






  ## ----- SECTION 107 頻度表を作成する
set.seed (123)# 乱数を設定
# サイコロを100回振った結果をシミュレーション
x <- sample (1:6, 100, rep = TRUE)
(y <- table (x))

class (y); str (y)

# 3が出た回数を除いて出力
table (x, exclude = 3)

xt <- table (x)
# データフレームに変換する
as.data.frame (xt)

# 連続量を区間分割した表を作成
x <- rnorm (100)
head (x)

(y <- cut (x, breaks = quantile (x),
    include.lowest = TRUE))

(z <- table (y))

# 部分抽出する
z [1]

z [[1]]







  ## ----- SECTION 108 分割表を作成する

set.seed (123) # 乱数をセットする
# 男女別進路調査データと仮定する
x <- data.frame (sex = sample (c ("男","女"), 50, rep = TRUE),
                 course = sample (c ("理","文"), 50, rep = TRUE))
head (x)

# 分割表を作成
(y <- xtabs (~ sex + course, data = x))

# 周辺合計を加える
addmargins (y)
# 分割表を作成する別の方法
# ただしラベルを付加するには「deparse.level」引数が必要
table (x$sex, x$course, deparse.level = 2)

# すでに頻度集計されたデータフレーム
(z <- data.frame (Freq = c (11, 14, 14, 11),
                  Sex = rep (c ("女", "男"), 2),
                  Course = c ("理", "理", "文", "文") ) )

xtabs (Freq ~ ., data = z)

# 2種類の集計がある場合
(z2 <- data.frame (合格 = c (5,6,7,8), 不合格 = c (8,7,6,5),
                   性別 = rep (c ("女", "男") ,2),
                   進路 = c ("理", "理", "文", "文")))
# 合格、不合格ごとに次元を分けて集計
(z3 <- xtabs (cbind (合格, 不合格) ~ ., data = z2))

# 合格に限った表を抽出
(z4 <- z3[  ,  ,  1]) # z3 [,,"合格"] でも良い

# 分割表を割合で表現
 # 行での割合
 prop.table (z4, 1)

 # 列での割合
 prop.table (z4, 2)


 # 総合計での割合
 prop.table (y)


 prop.table (z3)

 prop.table (z4)




  ## ----- SECTION 109  表をLaTeXやHTMLの形式で出力する
(x <- data.frame (sex = rep (c ("男", "女"), 2),
                  dir = rep (c ("理", "文"), 2)))

 #  install.pacakges ("xtable")

 library (xtable)

 (y <- xtable(x) )
 # HTMLフォーマットで出力する
 print ( y, type = "html")

 # ファイルに出力する
 print(y, file = "table.tex")








