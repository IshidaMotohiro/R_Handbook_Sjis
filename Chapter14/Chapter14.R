# 第3版  2016年 06 月 22 日

############################################################
#                      第14章 Rの応用                      #
############################################################



  ## ----- SECTION 205  直前の処理結果を表示する

# 直前の実行結果は自動的に保存される
x <- 1:10
x

.Last.value

y <- .Last.value
y





  ## ----- SECTION 206  ガベージコレクションを実行する

# ガベージコレクションを行う
 gc ();gc ()





  ## ----- SECTION 207  バッチ処理を実行する

# 以下はOSのターミナルで実行します
## R CMD BATCH --vanilla batch.R result.txt





  ## ----- SECTION 208  Rの出力をLaTeXフォーマットに変換する

Sweave ("Sweave.Rnw", encoding = "CP932") # ファイルの文字コードを指定。 Mac / Linux では "UTF-8" を指定

## 同封の Sewave.Rnw ファイルを利用して下さい
## % Sweave サンプル%

## \documentclass{jsarticle}
## \usepackage{ascmac}
## \begin{document}
## \section {正規乱数の平均と分散 1}
## \begin{verbatim}
## <<echo=TRUE>>
## \end{verbatim}
## コードと出力の両方を取り込む

## <<echo=TRUE>>=
## set.seed(123); x <- rnorm(100)
## mean(x); var (x)
## @
## すなわち平均\Sexpr{format(mean (x), digits = 2)}
## は分散\Sexpr{format(var (x), digits = 2)} です。
## \section {正規乱数の平均と分散 2}
## \begin{verbatim}
## <<echo=TRUE,results=hide>>
## \end{verbatim}
## コードのみを取り込む
## <<echo=TRUE,results=hide>>=
## set.seed(123); x <- rnorm(100)
## mean(x); var (x)
## @
## \section {正規乱数の平均と分散 3}
## \begin{verbatim}
## <<echo=FALSE>>
## \end{verbatim}
## 出力のみを取り込む
## <<echo=FALSE>>=
## set.seed(123); x <- rnorm(100)
## mean(x); var (x)
## @
## 画像を作成する
## \begin{figure}[h]
## \begin{center}
## \setkeys{Gin}{width=1.0\textwidth}
## <<echo=TRUE,fig=TRUE,width=7,height=4>>=
## hist(x)
## @
## \caption{$x$のヒストグラム}
## \label{fig1}
## \end{center}
## \end{figure}

## 表の作成
## \begin{center}
## <<echo=FALSE,results=tex>>=
## library (xtable)
## xtable (summary (cars),
## caption = "頻度表",
## label = "table1")
## @
## \end{center}
## \end{document}





  ## ----- SECTION 209  日付や時刻をデータとして扱う
# 「Date」クラスのオブジェクト
as.Date ("2014-01-28")

as.Date ("2014/01/28")

(d1 <- as.Date ("1/28/2014", format = "%m/%d/%Y"))

(d2 <- as.Date ("02/03/2014", format = "%m/%d/%Y"))

class (d1)

as.numeric (d1)

# 引き算
d2 - d1

difftime (d2, d1, units = "hours")

 # 指定の長さの日付けオブジェクトを生成する
year1 <- seq (as.Date ("2000-12-1"), by = "days", length = 50)
# 平均値
mean (year1)

# 最大値と最小値
max (year1); min (year1)

# 期間内の各曜日の数
table (weekdays (year1))



# POSIX規格のオブジェクト
(p1 <- as.POSIXct ("2014-01-28 01:0:0") )

(p2 <- as.POSIXct ("2014/02/03 23:0:0") )

class (p1)

p2 - p1

max (p2, p1); min (p2, p1)

# リスト形式のオブジェクトとして作成
(p3 <- as.POSIXlt ("2014-01-28 01:0:0") )

(p4 <- as.POSIXlt ("2014-02-03 23:0:0") )

class (p3); is.list (p3)

p4 - p3

names (p3)

p3$year; p3$mday; p3$wday

max (p3, p4); min (p3, p4)

# 日付入力の関数
strptime ("2014-02-03 23:0:0", format = "%Y-%m-%d %H:%M:%S")

# 一部の指定はロケール依存
strptime ("2014-Feb-03 23:0:0", format = "%Y-%b-%d %H:%M:%S")

# ロケールを変更
lct <- Sys.getlocale ("LC_TIME"); Sys.setlocale ("LC_TIME", "C")

st1 <- strptime ("2014-Feb-03 23:0:0", format = "%Y-%b-%d %H:%M:%S")
st1

strftime (st1, format = "%Y年%m月%d日 %H時%M分%S秒")

# ロケールをもとに戻す
Sys.setlocale ("LC_TIME", lct)

as.Date ("Friday April 26 2011", format = "%A %B %d %Y")

# ロケールを変更
lct <- Sys.getlocale("LC_TIME"); Sys.setlocale("LC_TIME", "C")

as.Date ("Friday April 26 2011", format = "%A %B %d %Y")

# ロケールをもとに戻す
Sys.setlocale("LC_TIME", lct)






  ## ----- SECTION 210  コンソールの表示幅を調整する

# 表示幅のデフォルトを確認
options ("width")

# options()$width や
# getOption ("width") としてもよい
rnorm (10)

 # デフォルトを変更
opt <- options (width = 50)
rnorm (10)

# デフォルトに戻す
options(opt)





  ## ----- SECTION 211 集合演算を実行する

(x <- LETTERS [1:7] )

(y <- LETTERS [3:10])

# 集合の和
union (x, y)

# 集合の積
intersect (x, y)

# 集合の差
setdiff (x, y)
# 引数の順番を入れ替える
setdiff (y, x)

x [1]; is.element (x [1], y)


is.element ("A", y)

x [5]; is.element (x [5], y)






  ## ----- SECTION 212  関数の最大化／最小化について

like <- function (x) {
  function (p) {
    xn <- length (x)
    xs <- sum (x)
    p^xs * (1-p)^(xn - xs)
  }
}
x <- c (1,1,0,0,0)
(like (x)) (0.5)

(xo <- optimize (like (x), c (0, 1), maximum = TRUE))

plot (like (x), from = 0, to = 1, lwd = 2, cex.lab = 1.6,
      xlab = "確率", ylab = "尤度")
lines (c (xo$maximum,xo$maximum), c (0, xo$objective), lwd = 2)

# 正規分布の対数尤度を返す関数
like2 <- function (x) {
  function (p) {
    m <- p [1]
    s <- p [2]
    sum (dnorm (x, mean = m, sd = s, log = TRUE))
  }
}


# 平均 50 標準偏差にしたがう乱数
z <- rnorm (100, mean = 50, sd = 10)
# 実際の平均と標準偏差
mean (z); sd (z)

# パラメータを対数尤度で推定する
optim (c (30,5), like2 (z), control = list (fnscale = -1))





  ## ----- SECTION 213  オブジェクトのスコープを調べる

search () # 実行状況によって変化します

# 説明のため一度作業スペースのすべてのオブジェクトを削除
rm (list = ls ())
(x1 <- 1:5)

(x2 <- LETTERS [1:5])

ls ()

(z <- data.frame (x1 = x1, x2 = x2) )

# x1とx2を削除
rm (x1, x2)
x1
x2

search()

# 「attach」すると、「z」環境が追加され、「x1」と「x2」が用意される
attach (z)
search()

x1
x2

#「z」が検索パスに挿入されている
search ()

# 定義した覚えのないオブジェクトにアクセスできる
pi

# 作業スペースに「pi」はない
ls ()

find ("pi")

# 「pi」は「base」パッケージのオブジェクトなので検索パスの先にある
get ("pi", envir = baseenv() )

# グローバル環境を遡らないとアクセスはできない
get ("pi", envir = globalenv(), inherits = FALSE )







  ## ----- SECTION 214 環境を確認する

environment ()

sys.frame ()

 
################
# 環境とフレーム
func1 <- function (x) {
  cat ("func1の環境\n")
  print (environment ())
  cat ("func1の親環境\n")
  print (parent.env (environment ()) )
  cat ("func1のフレーム番号\n")
  print (sys.nframe())
  cat ("func1のフレーム名\n")
  print (sys.frame (sys.nframe()))
  cat ("func1の親フレーム\n")
  print (parent.frame () )
  func2 (x) # ここで別の関数「func2」を呼び出す
}

func2 <- function (x) {
  cat ("func2の環境\n")
  print (environment ())
  cat ("func2の親環境\n")
  print (parent.env (environment ()) )
  cat ("func2のフレーム番号\n")
  print (sys.nframe())
  cat ("func2のフレーム名\n")
  print (sys.frame (sys.nframe()))
  cat ("func2の親フレーム\n")
  print (parent.frame () )
  func3 (x) # ここで別の関数「func3」を呼び出す
}

func3 <- function(x) {
  cat ("func3の環境\n")
  print (environment ())
  cat ("func3の親環境\n")
  print (parent.env (environment ()) )
  cat ("func3のフレーム番号\n")
  print (sys.nframe())
  cat ("func3のフレーム名\n")
  print (sys.frame (sys.nframe()))
  cat ("func3の親フレーム\n")
  print (parent.frame () )
  return (x)
}




# 関数を実行してみる  #  出力は実行環境に依存します
func1 (1)

# 関数のタイプ
typeof (func1)

# データフレームに「attach」関数を適用すると新しい環境として扱われる
z <- data.frame (x1 = 1:5, x2 = 6:10)
attach (z)

# 環境「z」に数値ベクトル 1:3 を指すオブジェクト inZ を追加
assign ("inZ", 1:3, pos = "z")
# assign ("inZ", 1:3, envir = parent.env (environment ())) でもこの場合は同じ
ls () # を実行しても、GlobalEnv に inZ オブジェクトはない

# オブジェクトの環境を確認
find ("inZ")

# 環境を指定してオブジェクトを確認
get ("inZ", pos = "z")

# get ("inZ", envir = parent.env (environment ())) でも同じ





  ## ----- SECTION 215  環境を指定してオブジェクトに代入する

x <- 0

# 関数内で「x」を生成
func1 <- function () {
  x <- 88
  print (x)
}
func1 ()

# グローバル環境の「x」は変更されない
x

 # 環境を遡って代入
func2 <- function () {
  x <<- 88
  print (x)
}
func2 ()

x

# 環境を遡って代入
func3 <- function () {
  assign("x", 123, parent.frame())
  print (x)
}
func3 ()

x

# ただし入れ子の途中に同じオブジェクトがある場合
func4 <- function () {
  x <- "func4" # func4関数内部で定義した x
  (function () {x <<- 3.14})() # 無名関数を使ってグローバル環境の x を変更したい
  print (x) # func4 内部のxは3.14 に変更されるが
}
x <- 0 # グローバル環境のオブジェクトを再定義
func4 ()

x # 変更されていない

# このような場合は assign 関数と globalenv 関数を使う
func5 <- function () {
  x <- "func5"
  (function () {assign("x", 3.14, globalenv())})()
  print (x) # 無名関数によって3.14 に変更される
}
x <- 0 # グローバル環境のオブジェクトを再定義
func5 ()
x # 変更されている





  ## ----- SECTION 216 デバッグを実行する

func <- function (x) {
  a <- x
  b <- 2
  browser (text = "x < 1", expr = x < 1)
  print (a + b)
}
func (4)

func (0)



func1 <- function (x) {
  cat ("func1内部\n")
  func2 (x)
}
func2 <- function (x) {
  cat ("func2の環境\n")
  func3 (x)
}
func3 <- function(x) {
  cat ("func3の環境\n")
  return (x + 1)
}

y <- "A"
func1 (y)


traceback ()

debug (func1)
func1 (y)


undebug (func1)

trace (func3, edit = TRUE)

body (func3)

func1(y)

untrace (func3)

func4 <- function (x) {
  a <- x
  print (a)
  b <- a + 1
  print (b)
  print (a + b)
}

func4 (5)

trace (func4, browser, at = c (3, 5))

func4 (5)

as.list (body (func4)) 
untrace (func4)


## note the differences
(2+3)
{2+3; 4+5}
(invisible(2+3))
{invisible(2+3)}





  ## ----- SECTION 217  R本体のデバッグ(C言語ソースを追う)

vector 
length

install.packages ("pryr")
library(pryr)
show_c_source(.Internal(length(x)))



  ## ----- SECTION 218   コードの実行速度を確認する
system.time ({x <- rnorm (100000); mean(x)})

#install.packages ("rbenchmark")
library (rbenchmark)

benchmark ({x <- rnorm (100000); mean(x)})# replications = 1000 

# 出力のtest欄は「｛」と、コードをまとめる波括弧になってしまっていますが
# 実行結果の出力に問題はありません


# 指定されたサイズの行列の列平均を求める関数「colMeans」と
# 「apply」関数に「mean」関数を適用した結果を比べる

means.1 <- function (n, m) colMeans (array (rnorm (n * m), c (m, n)))
means.2 <- function (n, m) apply (array (rnorm (n * m), c (m, n)), 2, mean)

within (
        benchmark (
                   replications = rep (100, 3),
                   means.1 (100, 100),
                   means.2 (100, 100),
                   columns = c ('test', 'elapsed', 'replications')),
        {average = elapsed/replications} )







  ## ----- SECTION 219   パッケージを作成する
func <- function(x) {
  cat ("func内部\n")
  return (x + 1)
}

# オブジェクトxを追加
x <- data.frame (X = 1:3, Y = LETTERS [1:3])

# パッケージの雛形を自動生成
package.skeleton (name = "MyFirst", list = c ("func", "x"))

x <- 1
prompt (x)

file.show ("x.Rd")







  ## ----- SECTION 220  S3クラスを定義する

(x <- data.frame (x1 = 1:3, x2 = 10) )

# オブジェクトXを「temp」クラスと定義
class (x) <- "temp"
# 「temp」クラスの出力メソッドを定義
print.temp <- function (x){
  print (x$x1 * x$x2)
}

print (x)
# print 関数の中身
print


methods (plot) # 出力は実行状況に依存します



# S3クラス・メソッドとして確認する
getS3method (f = "print", class = "temp")
function (x){
  print (x$x1 * x$x2)
}
getAnywhere (print.temp)








  ## ----- SECTION 221   S4クラスを定義する

#「family」クラスを定義
family <- setClass ("family", representation (mother = "character",
                                    father = "character",
                                    children = "numeric"),
          prototype (mother = "母", father = "父", children = 0))

# オブジェクトを作成
fm1 <- family(mother = "花子", father = "一郎", children = 3)
# fm1 <- new ("family", mother = "花子", father = "一郎", children = 3)# 旧来の方法
fm1@father

slot (fm1, "father")

# 「print」関数は「S4」ではない
isS4 (print )

setGeneric ("print")
# 「print」関数が「S4」の総称関数となる
isS4 (print)

# S4の「print」総称関数にはまだメソッドがない
print (fm1)
# 「print」メソッドを独自に定義
setMethod ("print", signature (x = "family" ), function (x) {
                                        # 父親と母親だけ表示
  print (c (x@mother, x@father))
} )

print (fm1)

# 「family」クラスを継承するクラスを定義する
setClass ("family2", representation (childNames = "character"),
          contains = "family", prototype (children = 2,
            childName = c ("A子","B男") ))

chld1 <- new ("family2", mother = "花子", father = "一郎",
              childNames = c ("月子","雪夫"))
# まったく新しい標準総称関数の定義 父親の表示をデフォルトの関数と設定する
setGeneric ("member", useAsDefault = function (x) {print (x@father)})

 
# デフォルトのメソッドを利用している
member (chld1)

# 「family2」オブジェクトに「member」オブジェクトが
# 適用された場合のメソッドを改めて定義
setMethod ("member", signature (x = "family2" ),
           def = function (x) {
             print (c (x@father, x@mother, x@childNames))
           })

# 新しいメソッド
member (chld1)

# 標準総称関数の定義その２：エラーチェクを行う非標準的総称関数
setGeneric ("member", def = function (x) {
  value <- standardGeneric ("member")
  if (!is.character (value)){
    stop ("エラー1：返り値が不正です")
  }
})

# 仮に次のように数値を返すメソッドを定義すると
setMethod ("member", signature (x = "family2" ),
           def = function (x) {
             1
           })


# エラーとなる
member (chld1)

# 検証用の関数を定義する
# 母と父の名前がセットされているかをチェック
setValidity ("family2", function (object) {
  if (nchar (object@mother) < 1 | nchar (object@father) < 1 )
    return (FALSE)
})

# 以下はエラーが返されるようになる
chld2 <- new ("family2", mother = "", father = "",
              childNames = c ("月子","雪夫"))

# なおS4クラスのコピーは，別の新しいオブジェクトを作成する
chld1
chld3 <- chld1

chld3@mother <- "乱子"
chld3@father <- "文太"
chld3
# 変更はもとのオブジェクトには及ばない
chld1








  ## ----- SECTION 222   ReferenceClassを定義する

# helloクラスを定義
hello <- setRefClass ("myS5",
                      fields = list (name = "character"),
                      methods = list (
                        initialize = function (name = NULL){
                          "初期化のメッセージ"
                          if(is.null(name)) {
                              cat ("初期化します\n")
                              initFields (name = "デフォルト値")
                          }else {
                              name <<- name
                          }
                        },
                        reply = function () {
                          "自己紹介を返す関数"
                          cat ("わたしは", name, "です\n")
                        },
                        change = function (newName){
                          "nameフィールドを書き換えます"
                          name <<- newName
                        }
                        )
                      )
                      
                      
# フィールド一覧を参照する
hello$fields ()

# メソッドの一覧を表示する
hello$methods ()

# オブジェクトを初期化
obj1 <- hello$new ()
# obj1 <- hello() も可(R 3.0.0以降)

# メソッドの説明を参照する
hello$help ("reply")


# 実行してみる
obj1$reply ()

# メソッドの説明を参照する
hello$help ("change")

# 実行して変更を確認
obj1$change ("鈴木")
obj1$reply ()
# アクセッサーを追加
hello$accessors ("name")

# メソッドの一覧を再表示する
hello$methods ()

# アクセッサーを使ってみる
 obj1$getName ()

 
# アクセッサーを使って「Name」フィール
obj1$setName ("佐藤")
obj1$reply ()

# メソッドを追加
hello$methods (
  message = function (toYou) {
    "初対面の挨拶を返す"
    cat (toYou, "さん，初めまして\n")
  })

# メソッドの説明を参照する
hello$help ("message")

# メソッドを実行
obj1$message ("後藤")

# 名前を指定して初期化
obj2 <- hello$new("山田")
obj2$reply()

# 参照クラスのオブジェクトをコピーする
obj3 <- obj1
# フィールドは「obj1」と同じ
obj3$reply()

# 「obj1」の「Name」フィールドを変更してみる
obj3$setName ("渕上")
obj3$reply()

# コピーもとの「obj1」の「Name」フィールドも変更されている
obj1$reply()

# 参照ではなく複製を作成して代入
obj4 <- obj1$copy()
obj4$reply()

# 「obj1」の「Name」フィールドを変更してみる
obj4$setName ("釘宮")

# コピーもとの「obj1」の「Name」フィールドに新たな変更は及んでいない
obj1$reply()




  ## ----- SECTION 223   R コマンダー

install.packages ("Rcmdr")
library (Rcmdr)




  ## ----- SECTION 224   Excel から R を利用

install.packages(c("rscproxy", "rcom"),
                 repos="http://rcom.univie.ac.at/download", lib = .Library)
library(rcom)
comRegisterRegistry()


install.packages(c("Rcmdr", "RcmdrPlugin.HH"),
                 lib = .Library, dependencies = TRUE);
# Rcmdrの不足パッケージを追加
library(Rcmdr) # 画面の指示に従ってインストール
# さらに以下を入力
install.packages(c("RcmdrPlugin.mosaic", "ENmisc"),
                 lib = .Library, dependencies = TRUE);




  ## ----- SECTION 225   日本語テキストを解析する

# http://mecab.sourceforge.net/ より MeCab0.996をダウンロードしてインストール
# http://rmecab.jp/wiki/index.php?RMeCab
#
install.packages ("RMeCab", repos = "http://rmecab.jp")
library (RMeCab)
res <- RMeCabC ("ご飯を食べた", 0)
unlist (res)

# 活用語は原型に戻す
res <- RMeCabC ("ご飯を食べた", 1)
unlist (res)

# フォルダ内の全テキストを解析
res <- docDF ("data/doc", type=1, N=1 )
res

res <- Ngram ("yukiguni.txt", type = 1)
res


# RMeCabの関数一覧
browseURL("http://rmecab.jp/wiki/index.php?RMeCabFunctions")




  ## ----- SECTION  226  欧米語のテキストマイニング

## install.packages("tm")

library (tm)

(txt <- system.file ("texts", "txt", package = "tm"))

(ovid <- VCorpus (DirSource (txt),
                 readerControl = list (language = "lat")))

texts <- c ("Alice was beginning to get very tired of sitting by her sister on the bank,",
            "and of having nothing to do:")
Alice <- VCorpus (VectorSource (texts))

Alice # print (Alice)に同じ

summary (Alice)

inspect (Alice)

as.character (Alice [[1]])

lapply (Alice, as.character)

reut21578 <- system.file("texts", "crude", package = "tm")
#  install.packages ("XML") # 必要であればインストール


reuters <- VCorpus (DirSource(reut21578),
                  readerControl = list(reader = readReut21578XMLasPlain))# 
inspect (reuters)

tm_filter(reuters , FUN = function (x) any (grep ("co[mn]?pany", context(x))))


reuters <- tm_map (reuters, stripWhitespace)
reuters <- tm_map (reuters, content_transformer(tolower))


reuters <- tm_map (reuters, removeWords, stopwords("english"))
reuters <- tm_map (reuters, stemDocument)

as.character (reuters [[1]])

dtm <- DocumentTermMatrix (reuters)
inspect (dtm[1:5, 100:105])

findAssocs (dtm, "opec", 0.8)


inspect (removeSparseTerms (dtm, 0.4))



 inspect (DocumentTermMatrix (reuters, list (dictionary  = c ("prices", "crude", "oil"))))


 
   ## ----- SECTION  227  「tm」パッケージで日本語文書行列を操作する

 library (RMeCab)
 x <- docMatrix2 ("doc")
 
 
 # install.packages("slam") # 必要ならばインストール
 library(slam)
 x.sparse <- as.simple_triplet_matrix( t(x) ) # 転置してから変換
 
 x.sparse2 <- as.DocumentTermMatrix (x.sparse, weighting = weightTf ) 
 library (tm)
 inspect (x.sparse2 [1:3, ] ) # 1-3行目を確認
 
 # 6割の文書で出現しているタームを残す
 inspect(removeSparseTerms(x.sparse2, 0.4))
 
 # 行列の相関係数をもとに抽出
 findAssocs(x.sparse2, "数学", 0.3)
 
 # install.packages("topicmodels")
 library (topicmodels)
 x.sparse <- as.simple_triplet_matrix( t(x) ) # 転置してから変換
 x.sparse2 <- as.DocumentTermMatrix (x.sparse, weighting = weightTf ) #
 topic.mod <- LDA(x.sparse2, control = list(alpha = 0.1), k = 5)
 getterms (topicmod)
 
 


  ## ----- SECTION 228 Emacs でのRの利用


(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)




(require 'auto-complete)
(require 'auto-complete-config)    ; 必須ではないですが一応
(global-auto-complete-mode t)

(require 'ess-site)
(setq ess-ask-for-ess-directory nil)
(setq ess-pre-run-hook
	'((lambda ()
	(setq default-process-coding-system '(sjis . sjis))
	)))
(defun ess:format-window-1 ()
	(split-window-horizontally)
	(other-window 1)
	(split-window)
	(other-window 1))
(add-hook 'ess-pre-run-hook 'ess:format-window-1)

(require 'popup)
(require 'ess-R-object-popup) 






  ## ----- SECTION 229  C言語との連携について

## 同封のファイル simple.c  を利用して下さい
/* もっとも単純な方法 simple.c */
  void foo(int *x, double *y, double *z)
{
  *z = *x + *y;
}


# R CMD SHLIB simple.c


 # R で実行する
dyn.load ("simple.dll")
is.loaded ("foo")

simple <- function (x = 10, y = 3.14){
  .C ("foo", x = as.integer(x), xy = as.double(y), foo = as.double(0))$foo
}

(simple ())

dyn.unload ("simple.dll")


## 同封のファイル my_list.c  を利用して下さい
/* リストを作成する my_list.c */
                                        #include <R.h>
                                        #include <Rdefines.h>
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





# R CMD SHLIB my_list.c

# Rの側での利用
dyn.load("my_list.dll")
is.loaded ("myList")

x <- .Call ("myList", x = "山田", y = 10L, z = pi)
x

dyn.unload("my_list.dll")


## 同封のファイル df_make.c  を利用して下さい
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



# R CMD SHLIB df_make.c

# Rの側での利用
dyn.load("df_make.dll")
is.loaded ("dfMake")

test <- function (x = "山田", y = "佐藤", z = "加藤" ){
  tmp <- .Call ("dfMake", x, y, z)
  return (tmp)
}
x <- test()
x

dyn.unload ("df_make.dll")





  ## ----- SECTION 230   「Rcpp」パッケージについて

install.packages ("Rcpp")
library (Rcpp)
install.packages ("inline")
library (inline)


 # 関数定義を文字列オブジェクトとして保存
 # 単に合計を返すだけのプログラム
defSum <- '
     int i, nx;
     double *rx = REAL (x), *rans;
     SEXP ans;
     nx = length (x);
     PROTECT (ans = allocVector (REALSXP, 1));
     rans = REAL (ans);
     for (i = 0; i < nx; i++) {
     rans [0] += rx [i];
     }
     UNPROTECT (1);
     return (ans);
     '
                                        # コンパイルする
mySum <- cfunction (sig = signature (x = "numeric") , body = defSum)
x <- mySum (c (1.1, 1.2, 1.3))
x


## 同封のファイル RcppList.cpp  を利用して下さい
/* RcppList.cpp ソースファイル */
#include <Rcpp.h>
RcppExport SEXP test (SEXP x, SEXP y, SEXP z){
  return Rcpp::List::create(Rcpp::Named("string") = x,
       Rcpp::Named("integer") = y,
       Rcpp::Named("numeric") = z);
}

同封のファイル RcppDataFrame.cpp  を利用して下さい
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

## 同封のファイル Makevars.win  を利用して下さい
PKG_CXXFLAGS=$(shell Rscript -e "Rcpp:::CxxFlags()")
PKG_LIBS=$(shell Rscript -e "Rcpp:::LdFlags()")
CLINK_CPPFLAGS=$(shell Rscript -e "Rcpp:::Cxx0xFlags()")


fx <- cfunction (signature (x = "integer", y = "numeric" ) ,
                 body = '
     return wrap (as<int>(x) * as<double>(y)) ;
     ', Rcpp = TRUE, includes = "using namespace Rcpp;" )



  ## ----- SECTION 231 関数のバイトコンパイル

# 速度を確認するためベンチマーク用のパッケージを導入
# install.packages ("rbenchmark")
library (rbenchmark)
# ベクトルの要素をすべて足し算するだけの関数 (sum)
f <- function (x) {
  s <- 0.0
  for (y in x){
    s <- s + y
  }
}

# バイトコンパイルを行うパッケージ
library (compiler)

# 関数のバイトコンパイル版
fc <- cmpfun (f)

# 正規乱数を作成し
z <- rnorm (10000)

# それぞれを実行してベンチマークを測ってみる
benchmark (
           f = f (z),
           fc = fc (z),
           replications = 10^(1:3),
           order = c ('replications', 'elapsed'))






  ## ----- SECTION 232 並列処理について

# install.packages ("simpleboot")
library (simpleboot)

# ガンマ乱数を用意
x <- rgamma (10000, 1)
# ブートストラップ法で中央値の信頼区間を求める
system.time (
             xb <- one.boot (x, median, R = 1000)
             )


names (xb)

quantile (xb$t)



# 並列処理版
library (parallel)
# 並列処理に適用する関数を定義
func <- function (){
  one.boot (x, median, R = 250)
}

# まず利用しているコンピューターのコア数を調べる
(mc <- detectCores ()) 

# system ("egrep \"^processor\\s:\\s[0-9]+$\" /proc/cpuinfo")# Linux でコア数を確認する方法
# クラスタの初期化
cl <- makeCluster (mc)
# クラスタごとに boot ライブラリをロード
clusterEvalQ (cl, library (simpleboot))

# 作業スペースの変数をエクスポート
clusterExport (cl, "x")
system.time (
             xbc <- clusterCall (cl, func)
             )

# 明示的にクラスタのワーカープロセスを終了
stopCluster (cl)
# 出力のリストは四つの要素からなるが、その最初の要素名を確認
names (xbc [[1]])

# 分位点
quantile (c (xbc [[1]]$t, xbc [[2]]$t,xbc [[3]]$t, xbc [[4]]$t))






  ## ----- SECTION 233  関数の単体テストを行なう

# install.packages("testthat", dependencies = TRUE)

library(testthat)



# 引数ベクトルの要素の掛け算を求める関数（のつもり）
myProd <- function (x) {
  tmp <- 0 # 0乗算になるので最終結果は常に0
  for (i in x){
    tmp <- tmp * i
  }
  return (tmp)
}

# 正しい解は 3628800
prod (1:10)

## 誤った値を指定して検証してみる
expect_equal (prod (1:10), 3628808)


devtools::use_testthat ()

## このフォルダ内にあるsampleフォルダをRStudioのプロジェクトとして読み込んでください．
## 具体的には，メニューの[File] -> [New Project] から [Existing Directory] を選び，Chapter04/sample フォルダを選択します

context ("Hello World function")
test_that ("check a string:",{
  expect_match (hello (), "hello")
} )

devtools::test ()

test_that ("check a string:",{
  expect_match (hello (), "Hello, world!")
} )

lengthChar <- function (char) {
  length (char)
}


context ("lengthChar function")

x <- "this is test."
test_that ("check length of string:",{
  expect_equal (lengthChar (x) , 13)
} )

lengthChar <- function (char) {
  nchar (char)
}

devtools::test ()


   ## ----- SECTION 234  WEBスクレイピング  

# install.pacakges ("rvest")
library (rvest)
# URIを直接指定できる
x <- read_html ("http://rmecab.jp/R/sample.html")

# //p という指定で、html内のPタグがすべて抽出される
x %>% html_nodes (xpath = "//p") %>% html_text %>% iconv(from = "UTF-8")

# pタグのgreenクラスに指定された文字列
x %>% html_nodes (xpath = "//p[@class = 'green']") %>% html_text () %>% 
  iconv (from = "UTF-8")

# 上の略記
x %>% html_nodes (".green") %>% html_text () %>% 
  iconv (from = "UTF8")

# pタグのredアイディーに指定された文字列
x %>% html_nodes (xpath = "//p[@id = 'red']") %>% html_text () %>% 
  iconv (from = "UTF-8")

# その略記
x %>% html_nodes ("#red") %>% html_text () %>% 
  iconv (from = "UTF-8")


# divタグ
x %>% html_nodes ("div") %>% html_text () %>% 
  iconv (from = "UTF-8")

# divタグの入れ子になったdivタグの値
x %>% html_nodes (".inDiv") %>% html_text () %>% 
  iconv (from = "UTF-8")


# 別の指定方法
x %>% html_nodes ("#divRoot .inDiv") %>% html_text () %>% 
  iconv (from = "UTF-8")

# Spanタグ内のtitleに設定された値を取る
x %>% html_nodes (".inSpan") %>% html_attr ("title") %>% 
  iconv (from = "UTF-8")


# その別の方法
x %>% html_nodes ("#divRoot li span.inSpan") %>% html_attr("title") %>% 
  iconv (from = "UTF-8")

# html 内にあるtableがすべて取り出され、リストとして返される
x %>% html_table %>% `[[`(1) 

# クラスを指定(Windowsでは文字化け)
x %>% html_node (".myTable") %>% html_table

# 表の属性を取り出す
x %>% html_node (".myTable") %>% html_attr ("border")


## 文字化け対策
library (readr)

# 列名は化ける
x %>% html_node(".myTable") %>% html_table %>% type_convert ()

# あらかじめ列名だけ変換しておくか、そもそも日本語を使わない(後者推奨)
x2 <- x %>% html_node (".myTable") %>% html_table 
colnames (x2) <- iconv (colnames (x2), from = "UTF-8")
x2 %>% typeconvert


# 以下はラムダ記法を応用している（341ページ参照）
x %>% html_node (".myTable") %>% html_table %T>% {
  colnames (.) <- iconv (colnames (.) , from = "UTF-8")
}%>% readr::type_convert ()


# WEB地図の作成
# LinkData からデータを取得

source("http://linkdata.org/api/1/rdf1s2679i/R")

# 「leaflet」パッケージを利用
install.packages ("leaflet")
library (leaflet)
Hakone_tozen_railway_train_station %>% leaflet %>% addTiles () %>% 
  addMarkers ( ~ long, ~ lat, popup =~ station)

## JSONやXMLデータの取得

library (xml2)
x <- read_xml ("https://u10sme-api.smrj.go.jp/v1/prefectures.xml")
x

# 「xml_find」関数にxpathを指定して、そのノードの要素を取り出す
xml_find_one (x, "//name") %>% xml_text

xmlfindall (x "//name") %>% xmltext

install.packages ("jsonlite")
library (jsonlite)
j <- fromJSON ("https://u10sme-api.smrj.go.jp/v1/prefectures.json")
names (j)
names (j)

class (j$prefectures)

j$prefectures



  ## ----- SECTION 235  「Shiny」パッケージでWEBアプリケーションを作成する


install.packages ("shiny")


# ui.R
library(shiny)
shinyUI(fluidPage(
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", # スライダー部品に「bins」という名前を付けた
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot") # プロットに「distPlot」という名前を付けた
    )
  )
))

# server.R
library(shiny)
shinyServer(function(input, output) {
  output$distPlot <- renderPlot({
    # generate bins based on input$bins from ui.R
    x <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    # draw the histogram with the specified number of bins
    hist(x, breaks = bins, col = 'darkgray', border = 'white')
  })
})




# ui.R その2
library(shiny)
shinyUI(fluidPage(
  # Application title
  titlePanel("Old Faithful Geyser Data"),
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins", # スライダー部品に「bins」という名前を付けた
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
        # ラジオボタンを追加 
        radioButtons("radio", label = h3("Select color"),
                     choices = list("black" = 1, "red" = 2,
                                    "green" = 3), selected = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot") # プロットに「distPlot」という名前を付けた
    )
  )
))

