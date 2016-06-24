# 第3版    2016年06月18日

############################################################
#                 第2章 オブジェクトの基礎                 #
############################################################





  ## ----- SECTION 015  オブジェクトの基礎
x <- 10

help("reserved")

# オブジェクトの中身を確認
x
# オブジェクト名は半角アルファベットと数値が使える
x1 <- 1
# オブジェクトの中身を確認
x1

# オブジェクト名は数値で始まってはいけない
# 以下はエラーになる
1x <- 1
# ひらがな漢字などの全角文字も利用はできる
あ <- "あ"
あ
#[1] "あ"

# オブジェクト名に半角スペースを挟むことはできない
x 1 <- 1


# 記号を使うこともできるがアンダーバーを頭に置くことは
# できないなどの制限もある
.var <- 1e5 # 1e5 は 100000 のこと
.var

# 以下はエラーになる
_var <- 1e5

# クオートすると半角スペースを使うことができる
`name with space` <- "ABC" # バッククオート
'name with space' <- "DEF" # ダブルクオート
"name with space" <- "GHI" # シングルクオート

# オブジェクトとして利用する場合もクオートで囲む
`name with space`

# 以下はエラーになる
name with space





    # SECTION-016 オブジェクトのタイプとデータ構造

sum (1:10)
sum (c(1, 3, 5, 7, 9))




    # SECTION-017 オブジェクトのタイプとデータ構造
x <- 1
typeof (x)
# 「x」に数値の1を代入する
x <- 1
# オブジェクト「x」のモードを確認する
mode (x)

# オブジェクト「x」のタイプを確認する
typeof (x)
# オブジェクト「x」のストレージモードを確認する
storage.mode (x)
# 「moji」に文字を代入する
moji <- "あ"
# オブジェクト「moji」のモードを確認する
mode (moji)

x <- 8L
typeof(x)

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
typeof(y)

x [1]
x [c (1, 2)]
x [c (1, 3)]
x [c (2, 3)]
y [2:3]




  ## ----- SECTION 018 クラスとオブジェクト

class (x)
# 「x」に数値の1を代入する
x <- 1
# オブジェクト「x」のモードを確認する
mode (x)
# オブジェクト「x」のタイプを確認する
typeof (x)
# オブジェクト「x」のモードを変更する
mode (x) <- "integer"
# 変更後のオブジェクト「x」のタイプを確認する
typeof(x)
# オブジェクト「x」のストレージモードを確認する
storage.mode (x)

# 「moji」に文字を代入する
moji <- "あ"
# オブジェクト「moji」のモードを確認する
mode (moji)
# オブジェクト「moji」のモードを変更する
mode (moji) <- "integer"

# オブジェクト「moji」の中身が強制的にNAに変換されている
moji
# 変更後のオブジェクト「moji」のタイプを確認する
typeof (moji)

methods (print)
# 通常の文字オブジェクト
x <- "A"
print (x)

# 独自のメソッドを定義
print.str <- function (x ){
  cat ("x = ", x, "; charToRaw (x) = ", charToRaw (x), "\n");
}
# オブジェクトのクラスを設定
class (x) <- "str"
# メソッドを呼び出す
print (x)




  ## ----- SECTION 019 オブジェクトの生成
# Rは数値や文字などをデータとしてメモリに展開する
# 単独の値（スカラー）をオブジェクトに代入
x <- 1
# 代入結果を参照する
x
# 実際にはベクトルなので添字を指定できる
x [1]
# 複数の値をまとめて1つのオブジェクトに代入
(y <- 1:10)
# 代入式全体を丸括弧で囲んでおくと代入結果が表示される

# 右辺と左辺を逆にすることもできないこともない
(c ("A", "B") -> z)

# 以下は代入の別の方法
(x = 1)
(`<-` (z, 1))
(assign ("z", 1))

# 複数の命令を1行にまとめる
x <- 1:100; mean (x)





  ## ----- SECTION 020  オブジェクトの属性の確認・変更
# ベクトルを生成
z <- 1:12
# 名前属性はなし（NULL）
names (z)
# 名前属性を設定
attr (z, "names") <- LETTERS[1:12]
z

names(z)

# names (z) <- LETTERS[1:9] でも同じ
# クラス属性を確認
class (z)
# 4行3列の次元を設定
attr (z, "dim") <- c (4,3)
# dim (z) <- c (4,3) でも同じ
z


# 次元に名前属性を与える
attr (z, "dimnames") <- list (row = c ("r1", "r2", "r3", "r4"),
                              col = c ("c1", "c2", "c3"))
# dimnames (z)<- list (row = c("r1", "r2", "r3", "r4"),
# col = c ("c1", "c2", "c3"))
# としても同じ
z
attributes (z)


# 名前属性は不要なので削除する
attr (z, "dimnames") <- NULL
attributes (z)

class (z)

x <- 1:10
attr (x, "dim") <- c(3, 3)

dim (x) <- c (3, 3)




  ## ----- SECTION 021 言語オブジェクトの作成
# 文字列を表現式オブジェクトに変更する
x <- parse (text = "a * b * c")
x
mode (x)

# 言語オブジェクトであるか
is.language (x)
# 実行（評価）してみる
# 表現式「x」内の「a,b,c」は定義されていない
eval (x)

# 「eval」関数内で「a,b,c」の値を指定する
eval (x, list (a = 1, b = 2, c = 3))

# 表現式オブジェクトを文字列に変換
x1 <- deparse (x)
x1
mode (x1)

#####
# 表現式オブジェクトを直接作成
y <- expression (a * b * c)
y
mode (y)
eval (y, list (a = 1, b = 2, c = 3))


#  表現式をリストとして表示してみる
y <- as.list (y); is.list (y)


#  全体の構造 `*` ([`*` (a, b)] , c)
str (y[1])

#  最初の要素は演算子 `*` 
y [[1]] [1]
#  その第１引数
y [[1]] [2]

# 第一引数は入れ子でやはり演算子がある
y [[1]] [[2]][1]
# 最初の演算子「y [[1]] [1]」の第２引数
y [[1]] [3]

#####
# 呼び出しオブジェクトを作成
z <- call ("+", 7, 8)
z

mode (z)
# 言語オブジェクトであるか
is.language (z)

eval (z)

# 呼び出しオブジェクトは名前オブジェクトを要素とするリスト構造
z [[1]] ; class (z[[1]])
z [[2]]
z [[3]]

# 言語オブジェクトであるか
is.language (z [[1]])
# 定数2は言語オブジェクトではない
is.language (z [[2]])
# 名前オブジェクト
is.name (z [[1]])

# 定数は名前オブジェクトではない
is.name (z [[2]])
# タイプを調べる
typeof (z [[1]])
typeof (z [[2]])

# 演算子を「+」から「*」に変更
z [[1]] <- as.name ("*")
eval (z)  # 計算式は「7*8」に変わる
# [1] 56

# 表現式を文字列に変換
z1 <- deparse (z)
z1





  ## ----- SECTION 022 オブジェクトなどのメモリ管理 

# 空のオブジェクトを作成
x <- character ()
x
object.size (x)  # Widnowsの64bit版での実行結果
x <- "石田基広"
# 代入後のサイズを確認
object.size (x)

# ワークスペース全体のメモリ使用量
object.size (ls)
# 単位をキロバイトに変更して表示
print (object.size (ls), units = "Kb")
gc ()


# メモリの再割り当て

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
