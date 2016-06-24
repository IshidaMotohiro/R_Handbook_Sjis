# 第3版  2016年 06 月 18 日

############################################################
#                  第６章 データフレーム                   #
############################################################





  ## ----- SECTION 080 データフレームを作成する

# 列ベクトルを用意
x <- 1:10
y <- LETTERS [1:10]

(xy <- data.frame (x, y))

# データフレームの列にアクセス
xy [ , 1]


# 文字は因子に変換されている
xy [ , 2]



# ここでは最初の列名をid、次の列名をnameとし、
# データは上で作成したベクトルx,yを指定
(xy2 <- data.frame (id = x, name = y))

# データフレームの列に名前を使ってアクセス
xy2$id

xy2$name

# 列とするベクトルの長さが異なる場合
# リサイクルされる
x <- 1:5
y <- LETTERS [1:10]
(xy2 <- data.frame (x, y))



# 列どうしが整数倍の関係ではない場合(列とするベクトルの長さが異なる場合)
x <- 1:10
y <- LETTERS [1:3]
xy2 <- data.frame (x, y)

y <- LETTERS [1:5]
(xy2 <- data.frame (x, y))





  ## ----- SECTION 081 データフレームに列名と行名を追加／変更する
# 列ベクトルを用意
x <- 1:10
y <- LETTERS [1:10]

(xy <- data.frame (x, y))


rownames (xy) <- letters [1:10]
colnames (xy) <- c ("Id", "Names")
xy





  ## ----- SECTION 082 データフレームの列にアクセス

# Rの基本データ「iris」
head (iris)

is.vector (iris$Petal.Length)


# 列をベクトルとして抽出する
iris [ , 3]

# 上とは異なり出力は列数1のデータフレームとなる
iris [3]

# 2,3行から1および5列だけ表示
iris [2:3, c (1, 5)]

# ある列だけにアクセスしたい
mean (Petal.Width)

# 「iris$」を指定する
mean (iris$Petal.Width)

df <- data.frame (X = 1:3, Y = c("A","B","C"))

# 検索パス一覧を確認
search ()

# データフレームの各列へのアクセスを容易にする
attach (iris)
search ()

# 「iris」環境内のオブジェクト
ls (iris)
ls(pos = ".GlobalEnv")

# objects( iris ) としてもよい
# 「Petal.Width」オブジェクトを含む環境
find ("Petal.Width")

# 「iris$」なしでアクセス可能になる
mean (Petal.Width)

# Petal.Width を変更してしまう
Petal.Width [1] <- 88
head (Petal.Width)

# 実際にはグローバルスペース「.GlobalEnv」に同名のオブジェクトが作成される
ls ()
find ("Petal.Width")

# グローバル環境のPetal.Widthにアクセス
head (get ("Petal.Width", pos = ".GlobalEnv",inherits = FALSE ))
# attachしたirisは変更されていない
head (get ("Petal.Width", pos = "iris",inherits = FALSE)) 




iris$Sepal.Length[1:5]


# 「iris」環境を削除
detach (iris)

# ワークスペースにはオブジェクトが残っている
find ("Petal.Width" )

# 「with」関数を使う
with (iris, {    
   print (mean (Petal.Length))
   print (sd (Petal.Length)) 
})


# 「with」関数を使う
with (iris, {
    c (mean (Petal.Length),
          sd (Petal.Length))
})


head (iris$Sepal.Length)
head (iris  $  Sepal.L)

library (dplyr)
iris %>% select(-Species) %>% colMeans 


  ## ----- SECTION 083 データフレームに要素を追加する
# 列ベクトルを用意
x <- 1:5
y <- LETTERS [1:5]

(xy <- data.frame (x, y))

# 列名と行名を設定
rownames (xy) <- letters [1:5]
colnames (xy) <- c ("Id", "Names")
xy

# 行を追加。変数の水準が一致していないとエラーになる
rbind (xy, c (26, "Z"))

xy$Names

# 「data.frame」関数を使う
xy2 <- rbind (xy, data.frame (Id = 26, Names = "Z"))
## あるいは以下の方法を使う

## 変数の水準を変更する
# levels (xy$Names) <- c(levels(xy$Names), "Z")
# rbind (xy, c(26, "Z"))
# 「Z」水準が追加された
xy2$Names


# 新規の列「newData」を追加
xy2$newData <- letters [1:6]
xy2
# 新規に追加した列は因子に変換されない
str (xy2)

# 列を追加する別の方法
cbind (xy2, data.frame (newData2 = 11:16))

# 同名の列を指定すると区別がつかないので注意
cbind (xy2, data.frame (newData = 11:16) )

# 「data.frame」関数を使うと列名の重複を調整してくれる
data.frame (xy2, data.frame (newData = 11:16) )

library (dplyr)
x <- 1:5
y <- LETTERS [1:5]
(xy <- data.frame (X = x, Y = y))

# 行を追加(ただし水準が一致しないので警告が表示され文字列に変換される)
xy %>% bind_rows (data.frame (X = 6, Y = "Z"))

# 「bind_cols」関数で列を追加
# xy %>% bind_cols (21:25) はエラーとなる
xy %>% bind_cols (data.frame (Z = 21:25))



  ## ----- SECTION 084 データフレームを結合する

(x <- data.frame (a = 1:3, b = c ("A", "B", "C"), x1 = 11:13))

(y <- data.frame (a = 2:4, b = c ("B", "C", "D"), y1 = 21:23))


# デフォルトでは重複する要素のある行のみ出力
xy1 <- merge (x, y)
str(xy1)

dplyr::inner_join(x, y, by = c("a", "b")) # に相当

xy2 <- dplyr::inner_join(x,y, by = c("a", "b"))
# b列の因子水準が異なるので文字列に変換されている
str(xy2)

# 「x」列を基準に結合
merge (x, y, all.x = TRUE)
dplyr::left_join(x,y, by = c("a", "b"))

# 「y」列を基準に結合
merge (x, y, all.y = TRUE)
dplyr::right_join(x,y, by = c("a", "b"))



# 両方の列要素を網羅した結合
merge (x, y, all = TRUE)
dplyr::full_join(x, y)

# 列名が異なる場合
(nameData <- data.frame (
                         first = c ("太郎", "次郎", "ジョン",
                           "三郎", "四郎", "マン" ),
                         last = c ("山田", "加藤", "スミス",
                           "江藤", "鈴木", "ゴールド")))


(nationData <- data.frame(
                          name = c ("山田", "加藤", "スミス"),
                          nation = c ("日本", "日本", "米国")))


# 2つのデータフレームの対応する列名を指定する
merge (nameData, nationData, by.x = "last", by.y = "name")





  ## ----- SECTION 085 データフレームから一部を抽出する

# Rに組み込みの大気汚染データ
head (airquality)

# 「Temp」変数が80を越えているデータの「Ozone」と「Temp」列を抽出
subset (airquality, subset = Temp > 80,
      select = c (Ozone, Temp))

library(dplyr) #を使う場合
airquality %>% select(Ozone, Temp) %>% filter(Temp > 80)
  
  
# 「Day」変数が1と一致するデータの「Temp」列を除いて抽出
subset (airquality, subset = Day == 1,
      select = -Temp)

airquality %>% select(-Temp) %>% filter(Day == 1) # 「dplyr」の場合

# 「Ozone」と「Wind」列までを抽出
subset (airquality, select = Ozone:Wind)

airquality %>% select(Ozone:Wind) # 「dplyr」の場合





  ## ----- SECTION 086 データフレームの列を変換する

# 「cars」データ。スピード「speed」はマイル、距離「dist」はフィート
head (cars)

# speed を 1.609 km/h に、距離を 0.3048 m に単位変換
cars2 <- transform (cars, speed = speed * 1.609,
                    dist2 = dist * 0.3048)
head (cars2)

library (dplyr)
cars %>% mutate(speed = speed * 1.609, dist2 = dist * 0.3048) %>% head # 「dplyr」の場合





  ## ----- SECTION 087 因子ごとに組み合わせを作成する
# 奇数と偶数のベクトルを用意
odd <- seq (1,5, by = 2)
even <- seq (0,4, by = 2)

# 奇数と偶数の組み合せを作る
(x1 <- expand.grid (odd = odd, even = even) )

# 作成されたオブジェクトはデータフレーム
is.data.frame (x1)
# [1] TRUE

# 次元属性を省いて返す
(x2 <- expand.grid(odd = odd, even = even, KEEP.OUT.ATTRS = FALSE))

str (x1)
str (x2)

object.size (x1) - object.size (x2)#出力は利用環境に依存します


# 血液型と性別、人数の組み合わせ
expand.grid (blood = c ("A", "AB", "B", "O"),
        sex = c ("F", "M"), freq = 0)





  ## ----- SECTION 088 データフレームの列や行ごとの合計を求める

(x <- data.frame (x1 = 1:6, x2 = 1:6, x3 = 1:6,
                  g = LETTERS [1:3] ))


# 単純な列ごとの合計
rowSums (x [, -4])

   # 以下 3 行、書籍未記載
   # library (dplyr)
   # x %>% rowwise() %>% summarise(X = sum(x1:x3))# 現行のdplyr バージョン(0.43) では rowwise() は期待通りに動かないこと多いので注意

# 行ごとの合計
colSums (x [, -4])
x %>% select(-g) %>% summarise_each(funs(sum)) # dplyr の場合

# g列の水準ごとの合計を求める
rowsum (x [ , -4], group = x$g)





  ## ----- SECTION 089 データフレームの列ごとに関数を適用する

# 「アヤメ」データを使用
head (iris)

# データフレームの列ごとに関数を適用
apply (iris[, -5], 2, mean)
apply (iris[, 1:4], 2, mean)
apply (iris[1:4], 2, mean)

# 結果をリストで返す
lapply (iris [ , -5], mean)

# 結果をベクトルで返す
sapply (iris [ , -5], mean)

# 結果をリストで返す
sapply (iris [ , -5], mean, simplify = FALSE)

# library(dplyr) の場合(出力は省略)
iris %>% select(-Species) %>% summarise_each(funs(mean))

#「fivenum」関数は5つの要約統計量を出力する
vapply (iris [, -5], fivenum,
        FUN.VALUE = c (Min. = 0, "1st Qu." = 0, Median = 0,
          "3rd Qu." = 0, Max. = 0))

# 出力の名前は任意に指定できる
vapply (iris [1:4], fivenum,
        c("最小値" = 0, "第一分位点" = 0, "中央値" = 0,
          "第三分位点" = 0, "最大値" = 0))

# 以下はエラーになる
vapply (iris [, -5], fivenum, c ("最小値", "中央値", "最大値"))


mapply (sum, 0:5, 10:15, 100:105)
word <- function(C,k) paste (rep.int (C,k), collapse = '')
mapply (word, LETTERS[1:6], 6:1)





  ## ----- SECTION 090 データフレームから欠損値を取り除く
# 「ニューヨークの大気の測定結果」データを使用
head (airquality)

airCC <- complete.cases (airquality)
air2 <- airquality [airCC, ]
# 5,6行目が削除されている
head (air2)

# library(dplyr) の場合(出力は省略)
# airquality %>% filter(complete.cases(.)) %>% head



  ## ----- SECTION 091 データフレームの列を分解統合する
# 「植物成長」データの最初と最後それぞれ3行
head (PlantGrowth, 3); tail (PlantGrowth, 3)

(PG <- unstack (PlantGrowth, formula = weight ~ group))
head (PG, 3); tail (PG, 3)

PG0 <- stack (PG)
head (PG0, 3); tail (PG0, 3)


# 「trt2」水準を省いて復元
PG1 <- stack (PG, select = -trt2)
head (PG1, 3); tail (PG1, 3)





  ## ----- SECTION 092 縦長形式のデータフレームを横長形式に変換する

# R組み込みのインドメタシン血漿濃度データ
summary (Indometh)

# 「time」の水準別に個体ごとの「conc」を記録したデータ
head (Indometh, 10) # これは縦長のデータ

# 「time」の水準ごとに独立した列を取った横長データを生成
(wide <- reshape (Indometh, v.names = "conc", idvar = "Subject",
                  timevar = "time", direction = "wide") )

reshape (wide, idvar = "Subject", varying = list (2:12),
         v.names = "conc", direction = "long")

# 「times」に対応するのがカテゴリ変数「subj」
(test <- data.frame (name = c ("加藤","佐藤","鈴木"),
                     subj = c ("国語","国語","国語",
                       "英語","英語","英語",
                       "数学","数学","数学"),
                     cred = c (80, 70, 60, 85, 75, 65, 75, 65, 55)))

# 「timevar」にはカテゴリ変数も指定できる
(test.re <- reshape (test, v.name = "cred", idvar = "name",
                     timevar = "subj", direction = "wide"))

# 元に戻す(デフォルトで行名が設定される)
reshape(test.re)
# reshape (test.re, v.names = "cred", direction = "long")

(tst <- data.frame (id = LETTERS [1:5],
                    x_1 = 1:5, x_2 = 6:10, x_3 = 11:15))

reshape (tst, v.name = "dataX", varying = list (2:4), direction = "long")

install.packages ("tidyr")
library (tidyr) # を使う
# 縦長データを横長に変換
spread (Indometh, key = time, value = conc)

# 横長データを縦長に変換
gather (iris, key = oldCols, value = Values, -Species)



  ## ----- SECTION 093 データフレームを分割する
# 「アヤメ」データフレームを「Species」の水準ごとに分割
(iris.splt <- split (iris, iris [5]))

# Species列を抽出する必要がなければ以下のように実行
# (iris.splt <- split (iris [-5], iris [5]))

# 第2引数に条件式を指定
(iris.splt2 <- split (iris, iris$Sepal.Length > 5))

# もとに戻す
(iris.splt3 <- unsplit (iris.splt2, f = iris$Sepal.Length > 5))




  ## ----- SECTION 094 データフレームを並べ替える

set.seed (123)

x <- sample (1:5, 100, rep = TRUE)
y <- sample (1:5, 100, rep = TRUE)
alph <- sample (LETTERS, 100, rep = TRUE)
x.y <- data.frame (name = alph, x = x, y = y)
head (x.y)

x.y2 <- x.y [ order (x.y$name, x.y$x, x.y$y), ]
head (x.y2, 10)

# 282ページで紹介する「dplyr」パッケージはデータ処理を効率化するための関数が
# 多数備わっていますが、並べ替えは「arrange」関数を使います。
library (dplyr)
x.y %>% arrange(name,x,y)

# 降順
# name列を降順にする(他の列は昇順) 
x.y %>% arrange(desc(name),x,y) %>% head

# すべての列を降順にする
x.y %>% arrange(desc(name),desc(x),desc(y)) %>% head



  ## ----- SECTION 095 高速・効率的なデータ操作を可能にする「dplyr」パッケージ


# データパッケージにインストール
# install.packages("hflights")
library(hflights)
# 227,496行21列のデータ
dim(hflights)

head (hflights)

library(dplyr)


# データフレームを拡張したデータ構造に変換
hflights_df <- tbl_df(hflights)
hflights_df
class (hflights_df)


# 条件に適合する行を抽出
filter(hflights_df, Month == 1, DayofMonth == 1)

filter(hflights_df, Month == 1 | Month == 2)

# 指定された列を軸に並べ替える
arrange(hflights_df, DayofMonth, Month, Year)

# 指定された列だけを抽出
# ここではYear列からDayOfWeek列までを抽出
select(hflights_df, Year:DayOfWeek)

# 既存の列から変換して新規列を追加
mutate(hflights_df,
   gain = ArrDelay - DepDelay,
   speed = Distance / AirTime * 60)


# 煩雑なデータ操作
# 指定の変数でグループ化
a1 <- group_by(hflights, Year, Month, DayofMonth)
# 列を取り出す
a2 <- select(a1, Year:DayofMonth, ArrDelay, DepDelay)
# 遅延時間と到着時間の平均をグループごとに要約
a3 <- summarise(a2,
   arr = mean(ArrDelay, na.rm = TRUE),
   dep = mean(DepDelay, na.rm = TRUE))
# それぞれの平均値に条件付けて抽出
(a4 <- filter(a3, arr > 30 | dep > 30))

# 処理を %.% 演算子で並列 
hflights %.%
   group_by(Year, Month, DayofMonth) %.%
   select(Year:DayofMonth, ArrDelay, DepDelay) %.%
   summarise(
     arr = mean(ArrDelay, na.rm = TRUE),
     dep = mean(DepDelay, na.rm = TRUE)
   ) %.%
   filter(arr > 30 | dep > 30)



   ## ----- SECTION 096 高速・効率的なデータ操作を可能にする「dplyr」パッケージ
# ggplot2::diamonds をデータフレームに変換
library (ggplot2)
head(diamonds)

install.packages ("data.table")
library (data.table)
## data.tableに変換
dia <- data.table(diamonds)
head (dia)

class(dia)
# 行の指定(通常のデータフレームと同じ)
dia [1:3, ]

# 列の指定は変数名を引用符なしで使う
dia [1:3, color]

# 複数の列はリストで指定する
dia [1:3, list(color, price)]

# 列番号を指定する場合
dia [1:3, c(3, 7), with = FALSE]


# キーを指定してソートした状態にする
setkey (dia, color)
head (dia)

## 複数のキーを設定
setkey (dia, cut, color)
head (dia)


## 検索する
dia [J("Fair", "J")]


## データフレームとの速度の比較
install.packages ("rbenchmark")

library (rbenchmark)
benchmark ("data frame" = { invisible (diamonds [diamonds $ cut == "Fair" &&
                                                   diamonds $ color == "J", ] ) },
           "data table" = { invisible (dia [J("Fair", "J")]) })

## グループ別集計
dia [, mean (price), by = cut]

tracemem(diamonds)
## コピーが生成される
diamonds [ diamonds $ cut == "Fair" && diamonds $ color == "J", "price"] <- 0

tracemem(dia)
## data.table での値の変更には := を使う
 ## data.table は参照渡しであるためコピーは発生しない
dia [J("Fair", "J"), price := 0]
## 
dia <- copy(dia[J("Fair", "J"), price := 0])

