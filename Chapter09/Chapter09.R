
# 改訂3版  2016年03月03 日


############################################################
#         第9章ファイルとデータベース         #
############################################################






  ## ----- SECTION 122
# コネクションを作成
con <- file (description = "test.txt", open = "wt")
isOpen (con, rw = "wt")
cat ("ファイルを作成\n", file = con)
# コネクションを閉じる
close (con)
# ファイルを確認する
file.show ("test.txt")
# ファイルを削除
unlink ("test.txt")

# R News を受信
con <- url ("https://cran.ism.ac.jp/src/base/NEWS")
# 不定形の文字列なので「readLines」関数を利用
NEWS <- readLines(con)
close (con)
# 長いテキストなので冒頭だけ確認
head (NEWS)
rm (NEWS)




  ## ----- SECTION 123 テキストファイルのデータを読み込む
# 以下のカンマ区切りのファイル「data.csv」があったとする
file.show ("Chapter09/data.csv")
## Id,Name,Sex,Grade
## 1,山田,男,60
## 2,加藤,男,70
## 3,佐藤,女,80
## 4,鈴木,男,85
## 5,山下,女,90


# コネクションを作成
con <- file (description = "Chapter09/data.csv", open = "wt")
isOpen (con, rw = "wt")
cat ("Id,Name,Sex,Grade\n1,山田,男,60\n2,加藤,男,70\n3,佐藤,女,80\n4,鈴木,男,85\n5,山下,女,90\n", file = con)
# コネクションを閉じる
close (con)
# ファイルを確認する
file.show ("data.csv")


# テキストファイルを読み込む汎用的な関数
# ファイル名（およびパス）と列名の有無、列の区切りを指定する
(x <- read.table (file = "Chapter09/data.csv", header = TRUE, sep = ","))


# カンマ区切りファイルであれば「read.csv」関数の方が簡単である
(x <- read.csv ("Chapter09/data.csv"))

unique (count.fields("Chapter09/data.csv", sep = ","))

# unlink ("data.csv")

# 以下のカンマ区切りのファイル「data2.csv」があったとする
# コネクションを作成
con <- file (description = "Chapter09/data2.csv", open = "wt")
isOpen (con, rw = "wt")
cat ("2013年01年01月現在\n記録者,石田基広\n\n1,'山田','男',60\n2,'加藤','男',70\n3,'佐藤','女',80\n4,'鈴木','男',85\n5,'山下','女',90\n", file = con)
   # コネクションを閉じる
close (con)

# このデータでは最初に2行，記録者のコメントがあり、空行を挟んで4行目からがデータ
# この場合ヘッダ（列名）がなく、また文字の引用符がシングルクオートになっている
file.show ("data2.csv")
# ヘッダや文字区切りなどを明示的に指定する
(x2 <- read.csv ("Chapter09/data2.csv", skip = 3, header = FALSE, quote = "'" ))

# unlink ("Chapter09/data2.csv")


# 変数名を指定する
x2.name <- c ("ID","NAME","SEX","GRADE")
(x2 <- read.csv ("Chapter09/data2.csv", skip = 3, header = FALSE, quote = "'",
                 col.names = x2.name ))

# 以下のタブ区切りのファイル「data.tsv」があったとする
# コネクションを作成
con <- file (description = "Chapter09/data.tsv", open = "wt")
isOpen (con, rw = "wt")
cat ("Id\tName\tSex\tGrade\n1\t山田\t男\t60\n2\t加藤\t男\t70\n3\t佐藤\t女\t80\n4\t鈴木\t男\t85\n5\t山下\t女\t90\n", file = con)
# コネクションを閉じる
close (con)

file.show ("Chapter09/data.tsv")

# この場合は「read.delim」関数を使えばよい
(x3 <- read.delim ("Chapter09/data.tsv"))

# unlink ("Chapter09/data.tsv")


# コネクションを作成
con <- file (description = "Chapter09/raw.txt", open = "wt")
isOpen (con, rw = "wt")
cat ("これはテキストファイルです\n1 2 3 4 5\n", file = con)
# コネクションを閉じる
close (con)

file.show ("Chapter09/raw.txt")

(x <- readLines ("Chapter09/raw.txt"))
length (x)

(y <- unlist (strsplit (x [2], " ")))

(z <- as.numeric (y))




  ## ----- SECTION 124 テキストファイルへデータを書き込む
# タブ区切りのファイル「data.tsv」の読み込み（前項参照）
file.show ("Chapter09/data.tsv")
## Id Name Sex Grade
## 1 山田 男 60
## 2 加藤 男 70
## 3 佐藤 女 80
## 4 鈴木 男 85
## 5 山下 女 90

(x3 <- read.delim ("Chapter09/data.tsv"))

# タブ区切りファイルから読み込んだデータフレームをカンマ区切りで保存する
write.table (x3, file = "Chapter09/saved.csv", sep = ",")

# 作成されたファイルを確認する
file.show ("Chapter09/saved.csv")

# 行番号の列が左に追加されている他，文字列に引用符が加わっているのでこれらを削除する
write.csv (x3, file = "Chapter09/saved.csv", quote = FALSE, row.names = FALSE)
file.show ("Chapter09/saved.csv")





  ## ----- SECTION 125 エクセル形式でデータを読み込み／書き込みする

# パッケージのインストール
install.packages ("readxl")
library (readxl)

dat <- read_excel ("Chapter09/Book1.xls")
dat
class (dat)
str(dat)
Encoding(dat$Name)

dat <- iconv(dat, from = "UTF-8")
Encoding(dat$Name)

library (dplyr); library(magrittr)
dat %<>% mutate (Name = iconv(Name, from = "UTF-8"), Sex = iconv(Sex, from = "UTF-8"))
Encoding(dat$Name)



# パッケージのインストール
install.packages("XLConnect")

library(XLConnect)

# 本書付録ファイルを読み込む
dat1 <- readWorksheetFromFile("Chapter09/XLConnect.xlsx", sheet = 1)
head (dat1)

# ファイルを直接操作する
wb <- loadWorkbook("XLConnect.xlsx")
dat2 <- readWorksheet(wb, sheet = 1)

# 通常のデータフレームと同じ操作ができる
dat2[1, 1]

# データを変更
dat2[1, 1] <- 888
# 変更をファイルに反映
saveWorkbook(wb)




# データベース風にエクセル・ファイルにアクセス
install.packages ("RODBC")
library (RODBC)
getwd ()

# エクセル・ファイルにコネクションを開く
con <- odbcConnectExcel ("Book1.xls", readOnly= FALSE)
# ファイルの概要を表示
sqlTables (con)
# データベースからデータフレームを作成
(x <- sqlQuery (con, "select * from [Sheet1$]"))

is.data.frame(x)

# データベース風に抽出も可能
 sqlQuery (con, 'select Grade from [Sheet1$] where Grade > 70')

 sqlQuery (con, "update [Sheet1$] set Sex = 'F' where Sex = '女'")

# エクセル・ファイルとのコネクションを切る
odbcClose (con)

# install.packages ("rJava")
# install.packages ("XLConnect", dep = TRUE)

library (XLConnect)
wb <- loadWorkbook ("Chapter09/XLConnect.xlsx", create = TRUE)
createSheet (wb, name = "mtcars")
createName (wb, name = "name.mtcars", formula = "mtcars!$C$5", overwrite = TRUE)
writeNamedRegion (wb, mtcars, name = "name.mtcars")
saveWorkbook (wb)
mtcar2 <- readWorksheet(wb, "mtcars") # ワークシートの読み込み
remove(wb)                                                        #  処理の終了



  ## ----- SECTION 126   データベースを操作する
library (RSQLite)

drv <- dbDriver ( "SQLite")
# sqlite3.exe とデータベースファイル「test.db」
# のあるフォルダを「myDB」とする
setwd ("C:/myDB")
# データベースにアクセス
# test.db が存在しない場合は作成される
con <- dbConnect (drv, dbname = "Chapter09/test.db")
# テーブルを表示
# test.dbにテーブルがまだ存在しない場合はエラー
dbReadTable (con, "test")


# 「iris」データフレームをデータベースに登録
dbWriteTable (con, value = iris, name = "iris" )
# [1] TRUE
# 登録されたデータを確認
dbReadTable (con, "iris")


  # 2014 年12月現在 データフレームに含まれるドットはアンダースコアに変換されず、
  # そのまま変数名に残されるようになっています。そのため記載のコードは動きません
   #  # 条件を抽出してみる
   # dbGetQuery (con, "select * from iris where Petal_Width > 2")

# 条件を抽出してみる(修正版)
dbGetQuery (con, 'select * from iris where "Petal.Width" > 2')

   # # 「Petal_Width」フィールドの平均を求める
   # #  dbGetQuery (con, "select avg (Petal_Width) from iris")

# 「Petal_Width」フィールドの平均を求める(修正版)
dbGetQuery (con, 'select avg ("Petal.Width") from iris')

# データベースとの接続を切る
dbDisconnect (con)




  ## ----- SECTION 127  文字コードを指定してファイルを読み込む
# UTF-8で作成されたファイルをWindows版Rで読み込む
x <- read.table ("Chapter09/utf8.csv", sep = ",", header = TRUE, fileEncoding = "UTF8")
# 利用できる文字コードを確認する
iconvlist ()






  ## ----- SECTION 128  インターネット上のファイルを読み込む
# ネットワーク・アドレスを指定してファイルを取得 (サーバーが構築されていない場合はエラーになります)
(x <- read.csv ("http://192.168.0.2/~ishida/url.csv"))

# ファイルをダウンロードしたい場合
download.file ("http://192.168.0.2/~ishida/url.csv",
                destfile = "url.csv")





  ## ----- SECTION 129  オブジェクトを保存する／読み込む
x <- LETTERS [1:5]
y <- data.frame (x = letters [1:5], y = 1:5)
# オブジェクト「x」と「y」をバイナリ形式で保存
save (x, y, file = "xy.RData")
# オブジェクトを削除
rm (x,y)
x;y 

# オブジェクトの読み込み
load ("xy.RData")
x; y

(z <- month.name) # R組み込みの月名のデータ

# ワークスペースのオブジェクトを保存
save.image ()
# ワークスペースのオブジェクトをすべて破棄
rm (list = ls())
 
# 「.RData」の読み込み
load (".RData")
x; y; z

dput (x, file = "x.R")
file.show ("x.R")     # ファイルの中身
(x <- dget ("x.R")) # オブジェクトを再現

  # オブジェクトの構文をテキスト化
dump ("x", file = "x.R")
file.show ("x.R")     # ファイルの中身

source ("x.R")




  ## ----- SECTION 130 ファイルやディレクトリを操作する
# ファイルを作成
file.create ("hoge.txt")
# ファイルの情報を確認
file.info ("hoge.txt")

# ファイルが存在するか
file.exists ("hoge.txt")

# ファイル名の変更
file.rename ("hoge.txt", "foo.txt")

# ファイルを削除
file.remove ("foo.txt")

# (x <- unlink ("foo.txt") ) も可能

# フォルダを作成
dir.create ("tmp")
file.create ("tmp/hoge.txt")

# パスの綴りからファイル名を抽出
basename ("tmp/hoge.txt")

# フォルダごと削除(なので注意)
# unlink ("tmp", recursive = TRUE)




  ## ----- SECTION 131  一時的なフォルダやファイルを作成する
# 一時ファイルを作成
tmp <- tempfile()
# 「cat」関数を使って文字列を入力
cat (file = tmp, "1 2 3 4 5 6 7 8 9", "1.1 .2 .3", sep = "\n")
# 読み込んでみる
(x <- readLines (tmp))

# スペースで切り分けて数値に変換する
as.numeric (unlist (strsplit (x, split = " " )))

# 一時ファイルを削除
unlink (tmp, recursive = TRUE)

# 一時フォルダを作成
td <- tempfile ()
dir.create (td) # 一時フォルダを作成

# 以下３つの関数で一時フォルダにファイルを作成
cat ("私は真面目な学生です。\n", file = paste (td, "D1", sep="/"))
write ("彼女は数学科の良い学生です。", file = paste (td, "D2", sep="/"))
writeLines ("彼女は難しい数学を学んでいます。", con = paste (td, "D3", sep="/"))

# それぞれのファイルを読み込む
scan (file = paste (td, "D1", sep="/"), what = character () )

readLines (paste (td, "D2", sep="/"))

# 一時フォルダを中身ごと削除
unlink (td, recursive = TRUE)
# テキストファイルを偽装する
x <- textConnection ("1, 2, 3, 4, 5")
readLines (x)

readLines (x)


# 末尾に追加
pushBack (c ("6", "7"), con = x)

# 追加された要素数
pushBackLength (x)

# 1つずつ読む
readLines (x, 1)

readLines (x, 1)

# 末尾まで読み込まれた
readLines (x, 1)

# 数値として読む
x <- textConnection ("10, 20, 30, 40, 50")
(y <- scan (x, sep = ","))


sum (y)

close (x)

# csvファイルを偽装する
z <- textConnection (c ("Id,Value", "A,1.1","B,2.1","C,3.1"))
 
(z1 <- read.csv (z) )

close (z)






  ## ----- SECTION 132 キーボードやクリップボードからデータを読み込む
# 以下はキーボードから入力する
# Enterキーで入力終了
x <- scan ()

x

# 文字列を入力する場合
x <- scan (what = "")

x

# 複数のデータ型を入力する場合
x <- scan (what = list(A = "", B = integer(0), C = double(0)) )

x

# 次のようなファイルがあるとする
file.show ("scan.txt")

(y <- scan ("scan.txt") )

# 次のようなファイルがあるとする
file.show ("scan2.txt")

# 2列目の文字列を除いて読み込み
(y <- scan ("scan2.txt", what = list(a = 0, NULL, b = 0) ) )

# 行列に変換
(ab <- cbind(y$a, y$b))


# 以下のような入力も可能
x <- read.table (stdin(), header = TRUE)

x

# GUIでデータを入力
fix (x)
# (y <- edit(x)) # でも良い

# GUIでファイルを選択
x <- read.csv (file.choose())
# クリップボードからの読み込み
# WindowsやUbuntu
read.table("clipboard")
 # Mac
 # read.table (pipe ('pbpaste'))



# スクリプトやコード片に「scan」関数を挟む
cat ("ブラケットで挟む")
{
    x <- scan()
}
x + 1





  ## ----- SECTION 133   Rの作業内容をネットワーク越しにやり取りする
# 保存する側．「Sys.Date」関数で日付を使ったファイル名を作成
(fileName <- paste (format (Sys.time (), "%Y-%m-%d-%H-%M"),
                    ".rda", sep = ""))

save.image (file = fileName )
# もしもアップロードもRで行うならば
# install.packages("RCurl")
# library (RCurl)
# ftpUpload (fileName, "ftp://192.168.0.1/~ishida/www/",
#             userpwd = "login:password")
# 受信側の処理
x <- load (url ("http://192.168.0.1/~ishida/2011-01-07-10-58.rda") )






  ## ----- SECTION 134 Rのスクリプトコードを読み込む
 file.show ("test.R")
## # 足し算を返す
## foo <- function(x,y) {
##       cat(x, " + ", y, " = ", x + y, "\n")
## } 
 source ("test.R")
 foo (1, 2)






  ## ----- SECTION 135  SPSSなどで作成したファイルを読み込む
 # パッケージをインストール
 install.packages ("foreign")
 library (foreign)
 # SPSSファイルを読み込む
 read.spss ("file.sav", use.value.labels = FALSE)




