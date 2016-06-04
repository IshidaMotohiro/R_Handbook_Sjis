# 改訂第3版　2016年2月17日

############################################################
#                   第4章ベクトルの操作                    #
############################################################




  ## ----- SECTION 034 文字列ベクトルを作成する

# 空の文字列を作成
x <- character ()
x
length(x)

# 空白の文字列を生成
x <- character (1)
x
# 「vector」関数を使った空の文字列の作成
x1 <- vector ("character", 1)
x1
x2 <- "ABC"
x2

# 引用符はシングルコーテションでもかまわない
y <- 'ABC'
y

# 引用符とスペースを含む文字列
x <- "\"A\" \"B\" \"C\""
x
length(x)

# プロットのキャプションなどに使うと
# バックスラッシュは表示されない
cat (x, "\n")
# "A" "B" "C"
plot (1:10, main = x)

# 3つの文字列を要素とするベクトル
(y <- c ("A", "B", "C"))
cat (y, "\n")
length (y)

LETTERS

letters

month.name

month.abb

LETTERS [1:10]
noquote (LETTERS)




  ## ----- SECTION 035 文字列を規則的に合成したベクトルを作成する
# デフォルトでは間にスペースを挟む
paste ("ID", 1:10)

# 「sep」引数を指定してスペースを省く
paste ("ID", 1:10, sep = "")
paste0("ID", 1:10)

# 1つの文字列（要素数1のベクトル）にまとめてしまう
paste ("ID", 1:10, sep = "", collapse = ",")

FeMa <- c ("女", "男")
FeMa

outer (FeMa, 1:5, paste, sep = "の")


# ベクトルを指定すると、足りない方が必要なだけ繰り返し使われる
paste (c ("F", "M"), 1:8, sep = "")

# NAは単なる文字列に変換されるので注意
paste0("html://base.com/", c("f1.html", NA,"f3.html"))



library(stringr)
str_c ("html://base.com/", c("f1.html", NA,"f3.html"))
str_join ("html://base.com/", c("f1.html", NA,"f3.html"))


  ## ----- SECTION 036 文字列オブジェクトの文字数を数える

x <- character()
nzchar(x)
length(x)

x <- ""
# 「x」が空かどうかを確かめる
nzchar (x)
nchar (x)

y <- "R逆引き"
# デフォルトでは文字数
nchar (y)
# 「type」引数でバイト単位
nchar (y, type = "bytes")
# 「type」引数で表示幅単位
nchar (y, type = "width")

# 要素が複数ある場合はそれぞれの文字数が返る
(z <- c (x, "ABC"))
nchar (z)
# 要素に欠損値「NA」が含まれる場合には注意
z.na <- c (x, NA)
nchar (z.na)
is.na (z.na)





  ## ----- SECTION 037 指定位置の文字列を抽出する
x <- "R逆引き"
y <- "ハンドブック"

# 2文字目から3文字目を抽出
substr (x, start = 2, stop = 3)

# 2つの文字列を対象に、それぞれ2文字から5文字目、4文字から7文字目を抽出
substr (c (x, y), start = c (2, 5), stop = c (4, 7))

# 代入による置き換え。この操作は元のベクトルを変更する
substr (x, start = 2, stop = 3) <- "X"
x

# 複数のベクトルは、一度単独のオブジェクトにまとめる
z <- c (x, y)
substr (z , start = c (2, 5), stop = c (4, 7)) <- c ("X", "Y")
z

# 第1引数にc()関数を直接指定することはできない。以下はエラーになる
# substr (c (x, y), start = c (2, 5), stop = c (4, 7)) <- c ("X", "Y")


z <- "RアールSアール"
substr (z, 2, 5)

# 2文字目から5文字目を置き換える？
substr (z, 2, 5) <- "="
z
# 右辺が1文字なので1文字だけ置き換えられた


# stringrパッケージを使った処理
# install.packages("stringr")
library(stringr)
# 位置を指定して抽出
str_sub(z,2,5)
# パターンを指定して抽出
str_extract(z, pattern = ".S.")
# ".S." はSとその前後にある任意の文字を指定する正規表現

x <- "R逆引き"
substring (x, first = 2, last = 3)

# 　アルファベット大文字
(str1 <- paste (LETTERS [1:10], collapse = ""))

substr (str1, c(2, 5), c(3, 6))

substring (str1, c(2, 5), c(3, 6))

unlist (strsplit (x, "逆"))



  ## ----- SECTION 038 特定の文字を区切りとして文字列を分割する
x <- "R逆引き"
# 同機能の別関数「substring」
substring (x, first = 2, last = 3)
substring (c (x, y), first = 2)
# アルファベット大文字
str1 <- paste(LETTERS, collapse = "")
# 「substr」の場合は位置ベクトルの一部を利用
substr (str1, c (2,5), c (3,6))
# 「substring」の場合は位置ベクトルをすべて利用
substring (str1, c (2,5), c (3,6))

x <- "R逆引き"
# 「.」は正規表現ですべての文字を指定したことになる
strsplit (x, ".")
# すべての文字が区切り文字に利用されるので文字の数だけ「""」が表示される
# 「fixed」引数を指定して「.」を文字通りに解釈する
strsplit (x, ".", fixed = TRUE)
# 「x」に「.」は含まれていないので分割されない
# リストをベクトル化する。なお「split」引数名を省略した
unlist (strsplit (x, "逆"))

# stringrパッケージを使う
library(stringr)
str_split(x, "逆")
# B を区切り文字とするが分割数は3個に限定
str_split("ABCABCABCABCABC", "B", n = 3)

  ## ----- SECTION 039  文字列を指定の長さに切り詰める

z <- c ("R逆引きハンドブック", "石田基広")
# 「width」は表示幅。日本語では1文字を2とカウント
# 日本語で奇数幅を指定すると切り捨てられる

strtrim (z, width = 2)
strtrim (z, width = 3)
strtrim (z, width = c(4, 2))

# stringrパッケージを使う
library(stringr)
# 文字列ベクトルの切り取り位置をベクトルで指定
# 位置は文字数で指定
str_sub(z, c(1,1), c(2,1))




  ## ----- SECTION 040  文字列を指定したパターンで検索する
jp.str <- c ("山本山太郎", "山田太郎", "山田幸之", "本山幸之助")
# 「山田」を検索し、添字番号を出力
(j <- grep ("山田", jp.str))
jp.str[j]

# 添字番号ではなく文字そのものを出力
grep ("山田", jp.str, value = TRUE)

# 文字列の最初が一致．Perl 互換の検索
(j <- grep ("^本山", jp.str, perl = TRUE))

# UTF-8環境（MacやLinux）では以下でもよい
# (j <- grep ("\\<本山", jp.str))
# 文字列の最後が一致
(j <- grep ("幸之$", jp.str))
# 以下でもよい
(j <- grep ("幸之\\>", jp.str))

# stringrパッケージ
# "本山"で始まるパターンを含む要素番号
str_detect(jp.str, pattern = "^本山")
# 一致を含む文字列を取り出す
str_subset(jp.str, pattern = "^本山")




# 検索文字列の一致した位置と長さ
(x <- paste (c (LETTERS, LETTERS), collapse = "") )

# 最初に一致した位置とその長さ
regexpr ("BCD", x)

# 一致したすべての位置とそれぞれの長さ
gregexpr ("BCD", x)

# URLを含む文字列
str <- "これはhttp://cran.r-project.org/で、あれはhttp://www.google.co.jp/です。"
# URLを取り出す単純な例
# tmp <- gregexpr ("https?://.+/(.+/)*?", str)
tmp <- gregexpr ("https?://.+?/(.+/)*?", str, perl = TRUE) # 荒引健氏による修正
# tmp <- gregexpr ("https?://[^/]+/([^/]+/)*?", str, perl = TRUE)
# （URLが / で終わることが前提） 荒引健氏による修正  http://d.hatena.ne.jp/a_bicky/

substring(str, tmp[[1]], tmp[[1]] + attr (tmp[[1]], 'match.length') -1)

alice <- "Alice was beginning to get very tired of sitting by her sister on the bank,
and of having nothing to do:"
alice.vec <- unlist (strsplit (alice, split = "[[:space:]]+|[[:punct:]]+"))
head (alice.vec)

table (alice.vec)



  ## ----- SECTION 041 文字列を指定したパターンで置換する
jp.str <- c ("石田基広", "石田太郎", "山田太郎", "幸村幸雄")
# 「石」を「山」に置換
sub ("石", "山", jp.str)

# 「石」あるいは「山」を「川」に置換
sub ("[石山]", "川", jp.str)

# 「石田」あるいは「山田」を「佐藤」に置換
sub ("石田|山田", "佐藤", jp.str)

# 「幸」を「鈴」に置換
sub ("幸", "鈴", jp.str)

# 「幸」を「鈴」に一括置換
gsub ("幸", "鈴", jp.str)

y <- "abcDA"
# 一致したパターンを大文字に変える
gsub ("(ab)", "\\U\\1", y, perl = TRUE)
# 最初の参照を大文字に、2つ目の参照を小文字に変える
gsub ("(ab)c(DA)", "\\U\\1 \\L\\2", y, perl = TRUE)

(z <- paste ("ID", 1:10, sep = ""))
# 最後の数字を削除する
gsub ("[0-9]$", "", z)
# 2桁以上ある場合
gsub ("[0-9]+$", "", z)

# stringr パッケージを使う
library(stringr)
# あをアに、うをウに置換した2つの実行例が出力される
str_replace_all("あいうえお", c("あ","う"), c("ア","ウ"))

# stringiパッケージで指定された文字をすべて置換
stringi::stri_replace_all_fixed("あいうえお", c("あ","う"), c("ア","ウ"), vectorize_all = FALSE)

jp <- "山本"
# Windowsでの文字コードはCP932
# ここで使われている漢字はそれぞれが２バイト
 charToRaw(jp)

# ところが文字コードがUTF-8に変換される
(jp2 <- gsub("山","川",jp))
# 漢字がそれぞれが３バイトになっている
charToRaw(jp2)

# fixed = TRUEを指定するとCP932として処理される
(jp3 <- gsub("山","川",jp, fixed = TRUE))
 charToRaw(jp3)

 
 # stringi パッケージで複数の文字列を同時に置換する
 x1 <- c("織田信長", "豊臣秀吉", "徳川家康")
 # 織田を藤原に、豊臣を木下に、徳川を松平に置換
 stringi::stri_replace_all_fixed(x1, c("織田","豊臣", "徳川"), c("藤原", "木下", "松平"), vectorize_all = FALSE)

 
 
  ## ----- SECTION 042  文字列の文字コードを確認する/指定の文字コード体系に変更する

#文字列の文字コードを確認。以下はWindows環境での出力
charToRaw ("ぁあいぃうぅ")
#　[1] 82 9f 82 a0 82 a2 82 a1 82 a4 82 a3
# 2つ目の「あ」はShift-Jis(CP932)では16進法で「82 a0」

# UTF-8での文字コード
# 「あ」はUTF-8では16進法でe3 81 82
# 「enc2utf8」関数で文字列の文字コードをUTF-8変換して表示
charToRaw (enc2utf8 ("ぁあいぃうぅ") )

# 指定した文字列の文字コード体系を変更する
y <- iconv ("あ", from = "CP932", to = "UTF-8")
# charToRaw(enc2utf8("あ") ) と同じ
# UTF-8での文字コードに変換されている
charToRaw (y)

# stringi パッケージを利用
stringi::stri_escape_unicode(y)


# Unicode(UCS-2)でのコードを確認する
# install.packages ("Unicode") # 最初にインストールする
library ("Unicode")
# 先ほどUTF-8に変換したオブジェクト「y」を利用する
as.u_char (utf8ToInt (y))
# UCS-2による「あ」のコード

# 文字コードが不明の場合
library(rvest)
# 推測してくれる
x1 <- "日本語"
x2 <- iconv(x1, to = "UTF-8")
guess_encoding(x1)
guess_encoding(x2)

x <- data.frame (Id = c ("もも", "くり", "かき"))
write.table (x, file = "x.csv", fileEncoding = "UTF-8")
getwd()

# コネクションを開く
out <- file ("utf8.csv", "w", encoding = "UTF-8")
write.table(x, out)
# コネクションを閉じる
close (out)






  ## ----- SECTION 044 因子を作成する
x <- c ("A", "B", "C")
(x <- rep (x, 3))
# 因子化
(y <- factor (x))

# 通常の添字指定
y [1:2]

y [2]
# 別ラベルを付ける
(y <- factor (x, label = "alphabet"))
str (y)
# 水準数を確認
nlevels (y)


# 指定された水準数を指定の数だけ繰り返す
(x <- gl (3, 5, labels = c ("上", "中", "下")))

(x <- gl (3, 5, labels = c("上", "中", "下")))
# 水準を追加する。ただし「"他"」に属するデータはない
levels (x) <- c ("上", "中", "下", "他")
x
# データのない水準は削除
x [, drop = TRUE]





  ## ----- SECTION 044  因子の水準に並び順を定義する
# 水準が3で、それぞれ要素が5個のベクトル
# 水準には並び順がある
(x <- gl (3, 5, labels = c ("あ", "い", "う")) )
levels (x)
# 因子の並び順が分散分析などでは参照水準として利用される
head (iris)

levels (iris$Species)
x.aov <- aov (Petal.Length ~ Species, data = iris)
# 係数表を確認
# この段階で参照水準（ベース）は"setosa"
summary.lm (x.aov)


# 参照の先頭水準の先頭（ベース）を入れ替える
iris$Species <- relevel (iris$Species, "virginica" )
levels (iris$Species)
# もう一度係数表を確認
# 参照水準が変更されている
y.aov <- aov (Petal.Length ~ Species, data = iris)
summary.lm (y.aov)


# 水準ラベルを明示的に変更する.
levels (iris$Species) <- list (virginica = "virginica",
	setosa = "setosa",
	versicolor = "versicolor" )
levels (iris$Species)

#　# もう一度係数表を確認
#  
z.aov <- aov (Petal.Length ~ Species, data = iris)
#  summary.lm (z.aov)

# 水準を平均値の大きさで並びかえる
w <- reorder (iris$Species, iris$Sepal.Width, mean)
levels (w)
w.aov <- aov (iris$Petal.Length ~ w)
summary.lm (w.aov)





  ## ----- SECTION 046  使われていない因子の水準を削除する

# irisデータから「versicolor」品種を除いた部分集合を抽出
iris.sub <- iris [iris$Species != "versicolor", ]
# しかし水準としては残っている
levels (iris.sub$Species)
# 使われていない水準を削除
iris.sub <- droplevels (iris.sub)
levels (iris.sub$Species)





  ## ----- SECTION 047
# 並び順とは別に大小関係がある
# insectデータの因子水準には大小関係はない
head (InsectSprays)

levels (InsectSprays$spray)
is.ordered (InsectSprays$spray)
str (InsectSprays$spray)

ins <- aov (count ~ spray, data = InsectSprays)
summary (ins)

summary.lm (ins)
contrasts (InsectSprays$spray)


# 大小関係を導入する
InsectSprays$spray <- ordered (InsectSprays$spray,
	levels = c("A", "B", "C", "D", "E", "F"))

levels (InsectSprays$spray)
is.ordered (InsectSprays$spray)
str (InsectSprays$spray)

ins <- aov (count ~ spray, data = InsectSprays )
summary (ins)

summary.lm (ins)

contrasts (InsectSprays$spray)





  ## ----- SECTION 048 因子の水準を自由に組み合わせる
(a <- gl (2, 4, 8, labels = c ("treat", "ctrl")))
(b <- gl (2, 1, 8, labels = c ("M", "F")))
# aとbの組み合わせを作成
(a.b <- interaction(a, b))
levels (a.b)

# 結合順序を替える
(a.b2 <- interaction (a, b, lex.order = TRUE))
levels (a.b2)





  ## ----- SECTION 049 因子の水準ごとに関数を適用する
# 「あやめ」データ
head (iris)


# 「aggregate」関数はデータフレームを返す
(x <- aggregate (iris[1], iris[5], mean))

# なお前節で因子の順序を変更している場合、テキストとは出力順が異なることがあります。
#　その場合は、一時的に変更されているirisオブジェクトをもとに戻すため　rm(iris)　を実行してください。

# 複数列に適用
(x <- aggregate (iris[1:4], iris[5], mean))

(x <- aggregate (iris [1:4], iris [5], range))

#「tapply」関数はグループ分けに利用されたオブジェクトと同じ次元の配列を返す
# 睡眠データ
sleep
attach (sleep) # データ列を登録し、個別のベクトルとして扱う
ave (extra, group)

# attach せずに実行する方法
# detach(sleep)
# with (sleep, ave (extra, group))

# 複数の因子でグループ分け
head (CO2)

levels (CO2$Type); levels (CO2$Treatment)

# 「Type」,「Treatment」の組み合わせごとに平均値を求める
(z <- tapply (CO2$uptake, CO2 [c ("Type", "Treatment")], FUN = mean) )
(y <- tapply ( iris [, 1], iris [5], mean))

mode (y)
# データフレームに変換
as.data.frame (as.table (y), responseName = "mean" )


# 簡素化を抑制するとリスト・モードの配列を返す
(y2 <- aggregate( iris [1], iris [5], mean, simplify = FALSE) )

mode (y2)

# 「ave」関数で、データフレームと同じ行数のベクトルとして出力
uptake.m <- ave (CO2$uptake, CO2 [c ("Type", "Treatment")], FUN = mean )
# 水準の組み合わせに使われた添え字番号
index <- tapply (CO2$uptake, CO2 [c ("Type", "Treatment")] )
# 水準の組み合わせの名前を取得
index.fac <- interaction (CO2$Type, CO2$Treatment)
data.frame (index = index, factor = index.fac, mean = uptake.m)

# 「by」関数はカテゴリごとに演算を適用する
# 第1引数はデータフレーム、第2引数にグループ化因子を指定
(iris.by <- by (iris [1:4], iris [5], colMeans) )

# 配列であることを確認
is.array (iris.by)





  ## ----- SECTION 050 論理値の基礎
x <- c (TRUE, TRUE)
y <- c (FALSE, FALSE)

# 論理値は文脈によっては1ないし0として扱われる
z <- c (FALSE, TRUE, 1)

# ベクトルの最初の要素だけが判定される
x || y

# ベクトルの要素ごとに比較が行われる
x | y
x && y
x & y

# 要素数が合わない場合、短かい方がリサイクルされる
# ただし倍数になっていない場合は警告が表示される
x & z

!x # 論理値の反転






  ## ----- SECTION 051 論理ベクトルを作成する
# 空の論理オブジェクト
x <- logical ()
x
length(x)
mode (x)

# 要素数1の論理オブジェクトを生成
(x1 <- vector ("logical", 1) )

(x2 <- TRUE)
(x3 <- T)
(x4 <- c (TRUE, FALSE, T, F))

# 0 以外の数値は「TRUE」に変換されます
(y <- 0:5)

(y2 <- as.logical (y))

# 文字列は「F」と「T」を除き「NA」に強制変換されます
(y3 <- as.logical (LETTERS))


  ## ----- SECTION 052 論理ベクトルを計算する
(x <- 1:10)
# 論理演算の結果
(y <- x > 5 )
sum (y)
any (y)
which (y)


(mat <- matrix (1:9, nrow = 3))

(mat > 5)

(mat > 5) * 1






  ## ----- SECTION 053 空のベクトルを初期化する

# 空のベクトルを初期化
x <- vector ()
length( x )
mode (x)
str (x)
is.null (x)

(y <- vector (mode = "character", length = 3))
(y <- vector ("numeric", 3))
(y <- vector ("double", 3))
(y <- vector ("integer", 3))
(y <- vector ("complex", 3))
(y <- vector ("raw", 3))

# 初期化の効率性
# 正規分布に従う乱数を用意
tmp <- rnorm (10000)
# 代入用のベクトルを用意。初期の要素数は1個
z1 <- 0.0

# 代入のたびにベクトルを拡張する
system.time (
 for(i in seq_along (tmp)){
  z1 [i] <- tmp [i]
 }
)
# 実行結果は環境によって異なります

# 生成した乱数と同じサイズのベクトルを用意
z2 <- vector ("double", length (tmp))

system.time (
 for(i in seq_along (tmp)){
  z2 [i] <- tmp [i]
 }
)




  ## ----- SECTION 054 ベクトルの要素数を取得・変更する
(x <- 1:5) 
NROW (x)
length (x)

# 要素数を広げる
length (x) <- 10
x
# 要素数を切り詰める
length (x) <- 6
x




  ## ----- SECTION 055  ベクトルの要素に名前を付ける
(x <- 1:5)
(names (x) <- LETTERS [1:5])
# 「B」という名前の付いた要素
x [names (x) == "B"]


x <- 1:5
names (x) <- LETTERS [1:5]
(y <- 5:9)

(names (y) <- LETTERS [5:9])
# 名前付きオブジェクトの演算
x + y
# 長さが同じ場合、最初のベクトルの名前だけが使われる






  ## ----- SECTION 056  ベクトルから要素を抽出する
# 添字を使って抽出
x <- LETTERS
x [1:10]

x [c (1, 3, 5)]
# [1] "A" "C" "E"
x [seq (1, 26, 2)]

# 指定された添字の要素置換
(x[1:10] <- letters [1:10])
# 指定された添字の要素を除外
x <- x [-(1:15)]
x


# x を数値ベクトルに変更
x <- -5:5
length(x)

# 条件指定で抽出
x [x > 0]
# 論理演算子「&」と「|」を使う
x [x < -2 & x > 2 ]
x [x < -3 | x > 3 ]

# 条件によって値を変える
x [x < 0 ] <- NA
x


# [ ]演算子を使う
z <- 1:5
names (z) <- LETTERS [1:5]
z

z [3]

z [[3]] # 

z [ names (z) == "B" ]

names (z) == "B"

z [names (z) == c ("B", "D")]

z [names (z) %in% c ("B", "D")]

names (z) %in% c ("B", "D")

z [ !(names (z) %in% c ("B", "D"))]




  ## ----- SECTION 057 ベクトルから条件に適合する添字を取得する
(x <- rep (c (TRUE, FALSE), 3))
# 要素にTRUEが1つでも含まれるか
any (x == TRUE)
# 要素がTRUEの添字番号
which (x == TRUE)

# アルファベット「K」を含む要素番号
which (LETTERS == "K")

# 最大値最小値の添字
y <- 5:10
which.max (y)
which.min (y)




  ## ----- SECTION 058 ベクトルの要素を並べ替える
# 1から10をランダムに並べたベクトル
# ここでは乱数の種を指定します
set.seed (1)
(x <- sample (10) )
# ソートされていないか
is.unsorted (x)
# ソートする
sort (x)

sort (x, decreasing = TRUE) # 降順
rank (x)

set.seed (2)
(z <- sample (20) )
sort (z) [9] ; sort (z) [11]


set.seed (2)
(z <- sample (20) )
# 通常のソート
sort (z)
# もとベクトルをソートした時に9番目の値を基準に前後に振り分け
sort.int (z, partial = 9 )
# 9番目と11番目の値を基準に前後に振り分け
sort.int (z, partial = c (9,11) )
# 9番目と18番目の値を基準に前後に振り分け
sort.int (z, partial = c(9,18) )

set.seed (1)
(x <- sample (10) )
# 昇順に並べ替えた場合の添字
order (x)
sort.list (x)
# 添字を使って並べ替える「sort(x)」に同じ
x [order(x)]




  ## ----- SECTION 059  ベクトルの要素を置き換える
(x <- c (1:5, NA))
# 3番目の要素を30に置き換える
replace (x, 3, 30)
# 2番目と3番目をそれぞれ置き換える
y <- replace (x, c (2, 3), c (20, 30))
y

# 添字を使って置き換える
x [c (2, 3)] <- c (22, 33)
x

# NAを0で置き換える
x [is.na (x) ] <- 0
x
# 以下でも同じ
# replace (x, is.na (x), 0)




  ## ----- SECTION 060 ベクトルに要素を追加する
(x <- 1:5)
# 末尾に結合
(y <- c (x, 7:10))
# 5の後に6を挿入
(z <- append (y, after = 5, 6))




  ## ----- SECTION 061 ベクトルの要素の重複を調べる
(x <- c (1:5, 3:7, 5:10))
(y <- duplicated (x))
# 重複している場所
which (y)
# 重複出現している要素
x [y]
sum (y)


z <- c (1, 2, 2, 2, 5, 5, 5, 5, 8, 2)
# 同じ数値が繰り返される回数
(z1 <- rle (z))

# 復元する
(inverse.rle (z1))





  ## ----- SECTION 062  ベクトルの要素の重複を削除する
x <- c (1, 2, 2, 2, 5, 5, 5, 5, 8, 2)
unique (x)

# 削除対象から一部の要素を外す
unique (x, incomparables = 2 )



