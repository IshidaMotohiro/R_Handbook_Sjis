
# 改訂第3版  2016年02月27日


############################################################
#                    第８章 関数の作成                     #
############################################################




  ## ----- SECTION 109 関数作成の基礎
div <- function (x, y) {
     x / y
}

(y <- div (9, 3))

# 引数は順番通りに割り当てられる
div (2, 4)

# 名前付き引数を指定すると順番は任意
div (y = 2, 4)

div <- function (x, y) x / y

div <- function (x, y) {
  return (x / y)
}

# return の応用
div <- function (x = 1, y = 1) {
  if(y == 0) {
    print ("0除算はできません")
    return (0) # 0 ならばここで終了
  }
  x / y
}

div(5, 0)





  ## ----- SECTION 110 関数オブジェクトを定義する
# 関数を定義する
foo <- function(){
  x <- "最初の関数"
  return (x)
}
# クラスを確認する
class (foo)

# タイプを確認する
typeof (foo)


# 実行してみる
foo ()


# 引数を加えた関数の定義
foo <- function (x) x^2

# 引数なしで実行するとエラー
foo ()

# 引数を指定する
foo (x = 3)


#  無名関数
(function(x,y){x/y}) (6,3)

# ラムダ記法

library (dplyr)

iris %>% filter (Species == "setosa") %>% boxplot() %>% NROW()

iris %>% filter (Species == "setosa") %>% {
  boxplot(.)
  NROW(.)
}

iris %>% 
{
  n <- sample(1:10, size = 1)
  H <- head(., n)
  T <- tail(., n)
  rbind(H, T)
} %>%
  summary

n; H; T

iris %>% filter (Species == "setosa") %T>% boxplot() %>% NROW()

iris %>% cor (Sepal.Length, Sepal.Width)

library(magrittr)
iris %$%  cor (Sepal.Length, Sepal.Width)


# リストを用意
x <- list(A = 1:10, B = 11:20, C = 21:30)



  ## ----- SECTION 111 引数のデフォルト値を設定する
# 仮引数の2つにデフォルト値を設定する
foo <- function (x, y = 2, z = 3) {
  x + y * 10 + z * 100
}
# 引数を確認する
formals (foo) # リスト形式

args (foo) # 定義に近い形式

function (x, y = 2, z = 3)

formalArgs (foo) # 仮引数を出力

body (foo) # 関数本体


# 実行してみる
#「x」に1「y」に2を指定。「z」はデフォルト値の3
foo (1, 2)
#「x」に1,「y」と「z」はデフォルト値の2と3
foo (1)

# x 引数を指定しない#以下にエラー x + y * 10 : 'x'が見つかりません
foo (y = 1)

 # 以下は実行可能
foo (y = 1, 1, 3)


 # ドット引数を使用する
fooDot1 <- function (x, y = 1, ...) {
  print (list(...))
  print ("##############")
  print (list(...)[[1]])
  print ("##############")
  x + y
}

fooDot1 (1, 2, "リスト1", "リスト2")


fooDot2 <- function (x, y = 1, ...) {
  print (..1)
  print (..3)
  x + y
}

fooDot2 (1, 2, "A", "B", "C")






  ## ----- SECTION 112  引数をチェックする

# 仮引数の一方にデフォルト値を設定する
foo <- function (x, y = 1) {
  x + y
}
# x 引数を指定しない
foo (y = 1)


# 引数の有無をチェックをする
foo <- function (x, y = 1) {
  if (missing (x)) stop ("x引数を指定してください")
  else x + y
}
foo (y = 1)


# 引数の値をチェックをする
foo <- function (x, y = 2) {
  stopifnot(x > 0, y >= 0)
  log(x, base = y)
}

foo (0, 1)
foo (1, 0)

foo (8, 2)


# 実引数をチェックする
fooM <- function (x = c ("A", "B", "AB", "O")) {
  x <- match.arg (x)
  cat (x , "型の割合：\n")
  switch (x, A = "四割", B = "二割", AB = "一割", O = "三割")
}

fooM ("D")
# 引数は「A, B, AB, O」のいずれかに限るためエラー

fooM ("A")

# 引数の部分マッチを利用する
fooP <- function(x){
    tmp <- pmatch(x, c("desk", "dog", "donuts"))
    c("机","犬","ドーナッツ")[tmp]
}

# 曖昧
fooP ("d")
# deで始まる候補は1つ
fooP ("de")
# doは曖昧
fooP ("do")
fooP("don")
# 途中文字列とのマッチは行われない
fooP ("nut")







  ## ----- SECTION 113 関数から複数の値を返す

foo <- function(x = 1, y = 1){
  tmp <- c (x, y, x + y, x -y , x *y, x / y)
  names (tmp) <- c ("x", "y", "+", "-", "*", "/")
  return (tmp)
}
# 「x」はベクトルとして複数の計算結果を含んでいる
 (x <- foo (1, 2))


# リストを返す関数
foo <- function (x = 1, y = 1){
  list ("+" = x + y, "-" = x -y , "*" = x *y, "/" = x / y)
}
(x1 <- foo(1, 2))
attributes(x1)
str(x1)


# コンソールへの表示を抑制する
foo <- function (x = 1, y = 1){
  invisible (list ("+" = x + y, "-" = x -y , "*" = x *y, "/" = x / y))
}
# 実行結果が直接は表示されない
foo (1, 2)
# 全体を括弧で囲む
(foo (1, 2))






  ## ----- SECTION 114 エラーを処理する

foo <- function (x) {
  if (x < 0) stop ("x < 0")
  print ("x > 0") #
}

foo (1)

foo (-1)


# 2回目でループが中断される
for (i in c (1, -1, 1, -1, 1)){
     cat (i ,"を実行\n")
     foo (i)
     }



# 「try」を使う。5回最後まで実行される
for (i in c (1, -1, 1, -1, 1)){
  cat (i ,"を実行\n")
  try (foo (i))
}



# 「try」を使う。5回最後まで実行される
for (i in c (1, -1, 1, -1, 1)){
  cat (i ,"を実行\n")
  try (foo (i), silent = TRUE)
}



# 「tryCatch」では、エラーで停止する前に「finally」で指定された処理を行う
(x <- tryCatch (log ("A"), finally = print ("適切な引数を指定してください") ) )


# 「error」引数で「condition」オブジェクトを表示する
(x <- tryCatch (log ("A"), error = function (e) str (e) ,
                finally = print ("適切な引数を指定してください") ) )


# エラー表示を調整する
(x <- tryCatch (log ("A"), error = function (e) conditionMessage (e),
                 finally = print ("適切な引数を指定してください") ))






  ## ----- SECTION 115  引数を取り出して利用する
# 引数をそのまま取り出す
fooS1 <- function (x) {
  arg = substitute (x)
  cat ("引数は \'", deparse (arg), "\'\n")
  cat ("実行結果は", eval (arg), "\n")
}
fooS1 (log (1))

# 引数が文字列の場合
fooS1 ("log (1)")

# 引数をそのまま取り出す
fooS2 <- function (x) {
  arg <- substitute (x)
  cat ("引数は \'", deparse (arg), "\'\n")
  if (is.language(arg)) {#is.expression(arg)
    cat ("言語式の実行結果は", eval (arg), "\n")
  } else if (is.character(arg)){
    cat ("文字列の実行結果は", eval (parse (text = arg)) , "\n")
  } else {
    cat ("実行不能", "\n")
  }
}

# 式を指定する
fooS2 (log(1))

# 式を文字列として指定する
fooS2 ("log(1)")





  ## ----- SECTION 116  関数をベクトル化する

# 2つの引数をハイフンを挟んで繋げる関数
f <- function (x = 1:3, y) c (x, "-", y)
f (y = 5)

# 「f」関数をベクトル化した関数を作成
vf <- Vectorize (f, SIMPLIFY = FALSE)

# もとの関数では2つの引数を前後で単に繋げる
f (1:3, 1:3)

# ベクトル化関数では引数の要素ごとに繋げる
vf (1:3, 1:3)

# デフォルト引数はベクトル化せず、「y」引数の要素ごとに繋げる
vf (y = c("A","B","C"))






  ## ----- SECTION 117  警告を抑制する
x <- c (1, 0, -1, 0)
log (x)

suppressWarnings (log (x))


# 警告を表示するだけの関数
warn <- function() warning ("!!警告!!")
warn()

# 何も表示しなくなる
suppressWarnings (warn ())

(op <- options ("warn"))

warn2 <- function() {
  cat ("警告の前\n")
  warning ("!!警告!!")
  cat ("警告の後\n")
}
warn2()

options (warn = 1)
warn2()

options (warn = 2)
warn2()

# デフォルトに戻す
options (op)
getOption ("warn")




  ## ----- SECTION 118  条件分岐を設定する
x <- 0
if (x > 0) log (x) else print ("x > 0 としてください")

x <- c (1, 0, -1)


# 複数要素のベクトルで実行
# ここで 1 以上の要素についてのみ計算したいが
(y <- if (x > 0) log (x) else "x > 0 としてください")

# 実際にはベクトルの要素3つをすべてにlog関数を適用した結果を返す
y

x <- 0
# 複数の条件分岐
if (x > 0) {
  cat (x, "の対数を求めます\n")
  log (x)
} else if ( x < 0){
  cat (x, "の対数は求められません\n")
} else {
  cat (x, "が指定されましたので中断します\n")
}

# 以下は「else」の前で改行しているのでエラーになる
if (x > 0) {
  cat (x, "の対数を求めます\n")
  log (x)
}# elseの前で改行してみる
else {
    cat (x, "の対数は求められません\n")
}

 # たとえば全体を括弧でくくるとエラーは防げる
{
  if (x > 0) log (x)
  else print ("x > 0 としてください")
}

x <- c (9, 4, 0, -4)
x

# 期待通りに動くが、警告がでる
ifelse(x >= 0, sqrt(x), NA)

# 警告を回避する
sqrt (ifelse(x >= 0, x, NA))
# 以下はエラー 
sqrt (ifelse(x >= 0, x, "計算できません"))

# 「switch」関数
# 第1引数「C」に対応する要素が抽出される
switch ("C", A = "a", B = "b", C = "c", D = "d")

# 第2引数に続く引数群から2番目が選択
switch (2, "A", "B", "C")

# 該当する要素名がない場合、名前なしの要素がデフォルトとして返る
switch ("F", A = "a", B = "b", C = "c", D = "d", "DEFAULT")

switch (2, "A", "B", "C")

switch (5, "A", "B", "C", "DEFAULT")
# 5 番目の要素はないので NULL が返る
# 要素番号で指定した場合デフォルト値で使えない


#  書籍には未掲載のコード例
a <- b <- 8; x <- "+"
switch (x,
        "+" = {cat (a, " + ",  b,  " = "); a + b },
        "-" = {cat (a,  " - " , b,  " = "); a - b },
        "*" = {cat (a,  " * ",  b,  " = "); a * b },
        "/"  = {cat (a,  " / ",  b,  " = "); a / b },        
        {cat ("加減乗除のみ可能です "); 0 }
        )







  ## ----- SECTION 119 ループ（繰り返し）を設定する
x <- LETTERS

# 添え字を使ったループ
for (i in 1:length (x)){
  print (x[i])
}

# この例では添字は不要
for (i in x){
  print (i)
}


x <- NULL; length (x)

# 以下は1,0というベクトルと誤解されるので2回実行されてしまう
for (i in 1:length (x)){
  print (x[i])
}

# そこで「seq」を使って添字ベクトルを指定する
(y <- LETTERS [1:5] )

# 添え字ベクトルは「seq」関数を使う
seq_along (y)

# これを応用する
x <- NULL; length (x)
seq_along (x)
# integer(0)

# 以下のようにすると意図しない実行を回避できる
for (i in seq_along(x)){ # この場合出力はない
  print (x[i])
}

 # for (i in seq(x)){ # この場合出力はない
 #  print (x[i])
 # }


# 「while」文の利用
x <- 5
while ( x > 0){
  x <- print(x) - 1 # xを出力してから1を引いてxを更新
}

 # 「repeat」文の利用
x <- 5
repeat {
  if (x > 0) x <- print(x) - 1
  else if (x <= 0) break
}


replicate(10, {x <- rnorm(100); summary(x)})


  ## ----- SECTION 120  ループを中断する
x <- 5
while (x > 0) {
  x <- print(x) - 1 # x を出力してから 1 引く
  if (x > 3) next # 3 以上の間はここで中断
  else if (x == 2){
    break # 2 になったらループを中止
  }
}




 ## ----- SECTION 121  「do.call」関数を使ってコードを実行する


# リストを用意
x <- list(A = 1:10, B = 11:20, C = 21:30)
 
# リストの要素AをX軸に、残りの要素のいずれかをY軸にしたグラフィックス
par(mfrow = c(2,1))
for (i in 2:3) {
     tmp <- c(names(x)[1], names(x)[i])
     do.call ("plot",
              list(x[[1]] ~ x[[i]],
                   main = deparse (substitute(y ~ x,
                       list (y = tmp[1], x = tmp[2]))),
                   xlab = tmp[1], ylab = tmp[2]))
 }


for (i in 2:3) {
 plot (x[[1]] ~ x[[i]])
}




## ----- SECTION 高階関数

Reduce (`+`,c(1,2,3))

Reduce (`+`,c(1,2,3), accumulate = TRUE)

Reduce (`+`,c(1,2,3), c(10,20,30))

Map(`+`, c(1, 2, 3), c(10, 20, 30))
Map(`+`, 1, c(10, 20, 30))
Map(`+`, c(1, 2, 3), 10)
Map(`+`, c(1, 2, 3), c(10, 20))


Filter (function(x) x > 0, c(-2,-1,0,1,2))

Find (function(x) x > 0, c(-2,-1,0,1,2))

# 「purrr」パッケージ
library (purrr)

# reduce (c (1, 2, 3), `+`)
c (1, 2, 3) %>% reduce (`+`)

# ラムダ記法を使う
c(1, 2, 3) %>% map(~ . + 1)

# Filterに対応
c (-2, -1, 0, 1, 2) %>% keep ( ~ .> 0)

