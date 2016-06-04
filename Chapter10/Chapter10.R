
# 改訂第3版  2016年3月3日

############################################################
#               第10章 基本統計解析                #
############################################################




  ## ----- SECTION 136 基本統計関数について

# 正規分布
# 累積確率、いわゆる分布
pnorm (-1.96)

pnorm (1.96, lower.tail = FALSE)

# 確率密度
dnorm (-1.96)

dnorm (1.96)

# 分位点関数
qnorm (0.025)

qnorm (0.975)

# 三角関数
# 45度はラジアンでは # 45 * (pi/180) ; pi/4
sin (pi/4); 1/ sqrt (2)

cos (pi/4); 1/ sqrt (2)

tan (pi/4);


asin (1/ sqrt (2)); pi/4

acos (1/ sqrt (2)); pi/4

atan (1)

atan2 (1,1)

(x <- seq (-pi, pi, 0.5))

sin (x)

# グラフを描く
plot (sin, -pi*2, pi*2)
plot (cos, -pi*2, pi*2)

# 対数
# 底が10
log10 (10)

log(10, base = 10)

# 底が2
log2 (8)

log (8, base = 2)

# 底は自然対数
(Napier <- exp (1))

log (Napier)

log (Napier, base = Napier)


log (-1:3)

# 1を加算した値の対数をとる
(x <- log1p (-1:3))

# 真数に戻す
exp (x)

# 真数に戻して1を減じる
expm1 (x)


# 二項係数（組み合わせ）
choose(5, 2)

gamma (5 + 1) / ( gamma (2 + 1) * gamma (5 - 2 + 1))


# ベータ関数
a <- 2; b <- 2
beta (a, b)


# ガンマ関数
(gamma (a) * gamma (b) ) / gamma (a + b)
# 階乗
factorial (10)

gamma (10 + 1)


# 複素数を初期化
z1 <- 3 + i

# 3 + i はエラーになる。i がオブジェクトと判断されるため
z1 <- 3 + 1i
# z1 <- 3 + 1i
# 実数部を出力
Re (z1)

# 虚数部を出力
Im (z1)


# 極形式
z2 <- 3 + 2i
# 複素数の絶対値
Mod (z2)

# sqrt(3^2 + 2^2)
# 偏角
Arg (z2)

# tanh(2/3)
# 複素共役
Conj (z1)




  ## ----- SECTION 137   乱数の利用

# 毎回ランダムな結果がえられる
rnorm (3)

rnorm (3)

# 種を設定する

set.seed (1)

rnorm (3)
rnorm (3)


# 再び種を設定する
set.seed (1)

rnorm (3)
rnorm (3)

# 現在の設定を確認

RNGkind ()

# RNGkind ("Wich")




  ## ----- SECTION 138   要約統計量を求める
# 「iris」データの要約
summary (iris)


# カテゴリを数値で表わしたデータは注意
(x <- data.frame (ID = 1:5, Grade = c(5,6,7,8,9),
                  Sex = c (1,2,1,2,1)))

summary (x)

# 因子と設定し直す
x$ID <- as.factor (x$ID)
x$Sex <- as.factor (x$Sex)
summary (x)

# Gradeを性別ごとに要約する
tapply (x$Grade, x$Sex, summary)

# 平均値
aggregate (. ~ Species, FUN = mean, data = iris)
# aggregate (iris [-5], iris [5], mean)

# 「dplyr」を使う
library (dplyr)
iris %>% group_by (Species) %>% summarise_each (funs(mean))

# 中央値
aggregate (. ~ Species, FUN = median, data = iris)
# aggregate (iris [-5], iris [5], median)


# 分散
aggregate (. ~ Species, FUN = var, data = iris)
# aggregate (iris [-5], iris [5], var)


# 標準偏差
aggregate (. ~ Species, FUN = sd, data = iris)
# aggregate (iris [-5], iris [5], sd)


# 平均絶対偏差 median absolute deviatio
aggregate (. ~ Species, FUN = mad, data = iris)
# aggregate(iris [-5], iris [5], mad)

# 四分位偏差
aggregate (. ~ Species, FUN = IQR, data = iris)
# aggregate (iris [-5], iris [5], IQR)

 # 値を小さい方から順に並び替えた時の、「75パーセンタイルと25パーセンタイルの間隔」の
 # ことで、代表性が高いと考えられる全体の中央付近の50%を含む範囲を示す。

# 分位点
aggregate (. ~ Species, FUN = quantile, data = iris, 
           probs = c(0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1))
# aggregate (iris [-5], iris [5], quantile,
#           probs = c(0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1))

aggregate (. ~ Species, data = iris, FUN = fivenum)


# データフレームにグループ別に求めた統計量を新規列として追加する
head (chickwts)
# chiclwtsデータフレームに新規に追加
chickwts$tmp <- ave (chickwts$weight, chickwts$feed, FUN = rank)
head(chickwts, 20)





  ## ----- SECTION 139  数値を丸める
round (1234.56789)
round (1234.56789, digits = 2)


# 四捨五入にならない
round (1234.5)
round (123.45)

round (123.45, digits = 1)
round (123.5)
round(123.45)

# 引数より大きい最小の整数
ceiling (1234.5)


# 引数より小さい最大の整数
floor (1234.5)


# 0 に近い最大の整数へ切り下げ
trunc (1234.9)


# 有効桁数を指定
x <- c (123.4, 123.45, 123.456, 1234.567)
signif (x, digits = 5)

(x <- 2.3 - 1.3)

# 厳密には1ではない
sprintf ("%.16f", x)

# したがって1との比較は偽になる
if (x >= 1) print("x >=1") else print("x<1")
# このような場合に「zapsmall」が使えることがある
if (zapsmall (x) >= 1) print("x >=1") else print("x<1")


x1 <- c(1234567890, 0.1)
x2 <- c(1234567890, 0.0)
(x1 - x2) == 0

zapsmall(x1, digits = 9) - x2 == 0
zapsmall(x1, digits = 10) - x2 == 0



  ## ----- SECTION 140 データから欠損値を取り除く

# 欠損値の扱い
x <- c (5, 5, 5, NA, 5)
mean (x)

# 欠損値を省いたデータ数で平均値を求める
mean (x, na.rm = TRUE)

# あるいは「na.omit」関数を適用
mean (na.omit (x) )

# 欠損値がある場合のデフォルトの動作
options ("na.action") # getOption ("na.action") でも良い

na.omit (x)

na.exclude (x)


na.pass (x)

na.fail (x)


(y <- data.frame( x = c(1, NA, 3, 4), y = c(5, NA, 6, NA)))

complete.cases (y)
y [ complete.cases(y), ]

# 組み込みのデータ「cars」を使用する
# 50行のデータ
nrow (cars)

# 最初の10行のd「dist」列をNAに変更
cars$dist [1:10] <- NA

# 回帰分析をしてみる
lm1 <- lm (dist ~ speed, data = cars)
# 有効データ数は40で自由度は38
# なお残り2は推定されたパラメータの数
summary (lm1)

# 欠損値がある場合はエラーとして実行を中止する
opt <- options (na.action = "na.fail")
#
lm1 <- lm (dist ~ speed, data = cars)

# オプションをもとに戻す
options (opt)


# 欠損値を置き換える
# さきほどdist列の冒頭をNAに変更している
cars
cars$dist [ is.na(cars$dist)] <- 88
cars



  ## ----- SECTION 141  正規性の検定を行う
# 「women」データから身長と体重を利用
# シャピロ・ウィルク検定
shapiro.test (women$height)

shapiro.test (women$weight)

# コルモゴロフ・スミルノフ検定
ks.test (women$height, "pnorm",
         mean (women$height), sd = sd (women$height))

ks.test (women$weight, "pnorm",
         mean (women$weight), sd = sd (women$weight))

# Q-Qプロットを作成
qqnorm (women$height)
qqline (women$height)

x <- ecdf (women$height)
plot (x)

# plot.ecdf (women$height) と一度に実行してもよい
# 理論的な累積確率と比較する
y <- seq(min (women$height), max (women$height) + 1)
lines(y, pnorm(y, mean = mean(women$height), sd = sd (women$height) ),
       col = "red", lty = 3)
knots(x)







  ## ----- SECTION 142 等分散性の検定を行う
# 2つのグループの睡眠時間の差
# データの先頭を表示
head (sleep)

var.test (extra ~ group, data = sleep)

ansari.test (extra ~ group, data = sleep)

mood.test (extra ~ group, data = sleep)

# 複数のグループ間の分散の検定
# 殺虫剤の効果について、Sprayの種類ごとのcount数を箱ヒゲ図で描く
plot (count ~ spray, data = InsectSprays)
bartlett.test (count ~ spray, data = InsectSprays)

# ノンパラメトリックな方法
fligner.test (count ~ spray, data = InsectSprays)







  ## ----- SECTION 143  t検定で平均を比較する
# 睡眠データの先頭を表示
head (sleep)

# グループIDごとの平均値
by (sleep [,1], sleep [,2], mean)
# 対応のあるデータだが仮に独立とする

# 標本平均と母集団の平均の比較
t.test (sleep$extra [sleep$group == 1], mu = 1)
t.test ()


# 2つのグループの睡眠時間の差
# 等分散性の検定
var.test (extra ~ group, data = sleep)


# 等分散性を仮定したt検定
t.test (extra ~ group, var.equal = TRUE, data = sleep)

# 等分散性を仮定しないウェルチのt検定
t.test (extra ~ group, data = sleep)

# alternative = "less" 最初のグループの方がより小さい
# 対立仮説 group1 < group2 が採択される
t.test (extra ~ group, alternative = "less", data = sleep)

# alternative = "greater" 最初のグループ方がより大きい
# 対立仮説 group1 > group2 は採択できない
t.test (extra ~ group, alternative = "greater", data = sleep)

# 対応のあるデータだと仮定する
t.test (extra ~ group, paired = TRUE, data = sleep)


# ちなみにdplyrでは以下のように実行する
library (dplyr)
sleep %>%   t.test (extra ~ group, data = .)






  ## ----- SECTION 144 ノンパラメトリックな検定で平均を比較する

## 月ごとのオゾン量データの先頭を表示
head (airquality)

# 箱ヒゲ図を描いてみる
boxplot(Ozone ~ Month, data = airquality)

## ウィルコクソンの順位和検定
wilcox.test(Ozone ~ Month, data = airquality, 
            subset = Month %in% c(5, 8)) ## 5月と8月を比較

## クラスカル・ウォリスの順位和検定
kruskal.test (Ozone ~ Month, data = airquality,
     subset = Month %in% c(5, 6, 7) ) ## 5月、6月、7月を比較








  ## ----- SECTION 145 比率の検定を行う
# 1群の場合
# 100回中30回成功したとき、成功確率は0.5とみなせるか
prop.test (30, 100, p = .5)

# 近似でなく正確な確率
binom.test (30, 100, p = 0.5)

# 複数の群の場合
# 成功回数
x <- c (3, 3, 7, 12)# c (83, 90, 129, 70) # c (86, 93, 136, 82)
# 試行回数
n <- c (86, 93, 136, 82)

# 4つの試行での成功回数の割合は異なるか
prop.test (x, n)


# 分割表として与えられている場合
tbl <- matrix (c (83, 3, 90, 3, 129, 7, 70, 12),
               byrow = TRUE, ncol = 2)
tbl
prop.test (tbl)





  ## ----- SECTION 146  独立性の検定（カイ二乗検定・Fisherの検定）を行う
# 以下のような分割表があったとする
(mat <- matrix (c (229, 286, 98, 58), byrow = TRUE, nrow = 2))

# カイ二乗検定
chisq.test (mat)

# イェーツの補正を行わない
chisq.test (mat, correct = FALSE)

# Fisherの正確確率
fisher.test (mat)

# 対応がある場合
(myTest <-
 matrix(c(794, 86, 150, 570),
        nrow = 2,
        dimnames = list("最初の調査" = c("支持", "不支持"),
          "2回目の調査" = c("支持", "不支持"))))

mcnemar.test (myTest)

# 二項検定を行う
binom.test (c (86, 150))

# binom.test (86, 86 + 150)  # でもよい
# binom.test (150, 86 + 150)


(1/5) / (4/5) == (1/4)

(229/286) / (98/58)
(229/98) / ( 286/58)






  ## ----- SECTION 147 相関係数を求める／検定する
# 米国人女性の身長体重データ
head (women)

# 相関行列を求める
cor (women)
cor.test (women$height, women$weight)
# 以下のようにも実行できる
# cor(women$height, women$weight)





  ## ----- SECTION 148  分散分析を行う

## 照明と作業効率
p.141 <- c (6,3,4,5,2, 7,5,6,7,5, 8,7,8,9,8)
p.141.cond <- gl (3, 5, lab = c("low","middle","high"))
(p.141.df <- data.frame (light = p.141, cond = p.141.cond) )

# データの分布を箱ヒゲ図で確認
boxplot (light ~ cond, data = p.141.df)
# 繰り返し数を確認
replications (light ~ cond, data = p.141.df)

# 多群の分散比の検定（パラメトリックな方法）
bartlett.test (light ~ cond, data = p.141.df)

# 多群の分散比の検定（ノンパラメトリックな方法）
fligner.test (light ~ cond, data = p.141.df)

# 1因子分散分析（パラメトリックな方法）
oneway.test (light ~ cond, data = p.141.df,
             var.equal = TRUE)

 # 以下は同じ結果
 aov1 <- aov (light ~ cond, data = p.141.df)
 # 分散分析表を出力
 summary (aov1)

 summary.lm (aov1)


# 1因子分散分析（ノンパラメトリックな方法）
kruskal.test ( light ~ cond, data = p.141.df)          
# 対応のある1因子分散分析（対応のない2因子分散分析）
# 同一個人が3つの照明水準について1回ずつ計3回測定したとする
subj <- rep(paste("sub", 1:5, sep = ""), 3)
# 個人を特定するランダム項を追加
(p.141.df2 <- cbind( p.141.df, subj))


# 対応のある1因子分散分析
aov2 <- aov( light ~ cond + Error (subj), data = p.141.df2)
# aov2 <- aov( light ~ cond + Error (subj/cond), data = p.141.df2)
summary (aov2)
# 対応のある1因子分散分析（ノンパラメトリックな方法）
friedman.test (light ~ cond | subj, data = p.141.df2)

# 対応のない2因子分散分析として実行
summary (aov (light ~ cond + subj, data = p.141.df2))





# 対応がない2因子分散分析（固定因子モデル）
p.154 <- c(8,10,11, 16,14,15, 2,3,4, 6,6,3, 11,12,8, 11,9,7)
A <- rep(paste("A", 1:3, sep = ""), each = 3, length = 18)
B <- gl(2, 9, lab = c("B1", "B2"))
(p.154.df <- data.frame (val = p.154, A = A, B = B))
# 繰り返しを確認
replications (val ~ A * B, data = p.154.df)

aov3 <- aov (val ~ A * B, data = p.154.df)
summary (aov3)
# 各水準の効果
model.tables (aov3, "means", se = TRUE)




# 対応がある2因子分散分析とする
p.167 <- c(6,9,11, 14,13,15, 3,4,5, 6,7,5, 11,13,10, 9,8,7)
A <- rep(paste("A", 1:3, sep = ""), each = 3, length = 18)
B <- gl(2, 9, lab = c("B1", "B2"))
S <- rep(paste("S", 1:3, sep = ""), 3, length = 18)
(p.167.df <- data.frame(val = p.167, A = A, B = B, S = S))


with (p.154.df, 
      interaction.plot (A, B, val)
      )

# 繰り返しを確認
 replications (val ~ A * B * S, data = p.167.df)
## A B S A:B A:S B:S A:B:S
## 6 9 6 3 2 3 1


# 被験者の繰り返しを誤差項として計算
aov4 <- aov (val ~ A * B + Error (S/(A*B)), data = p.167.df)
summary (aov4)


getOption ("contrasts")

aov1 <- aov (light ~ cond, data = p.141.df)
summary.lm (aov1)


# コントラストを変更
old.op <- options (contrasts = c ("contr.helmert", "contr.poly"))
aov2 <- aov (light  ~ cond, data = p.141.df)
summary.lm (aov2)

mean (p.141.df$light)

# コントラストをもとに戻す
options (old.op)






  ## ----- SECTION 149  多重比較を行う
# 各群の平均値の多重比較
pairwise.t.test (chickwts$weight, chickwts$feed)

# 手法を選択
pairwise.t.test (chickwts$weight, chickwts$feed,
                 p.adjust.method = "bonferroni")

aov1 <- aov (weight ~ feed, data = chickwts)
TukeyHSD (aov1)






  ## ----- SECTION 150  回帰分析を行う
# 車の速度とスピードを回帰分析
# 単回帰帰分析をしてみる
lm1 <- lm (dist ~ speed, data = cars)
# 要約
summary (lm1)

coef (lm1)

fitted (lm1)

residuals (lm1)

all.equal (cars$dist - residuals(lm1), predict (lm1))

speed2 <- cars$speed + runif (length (cars $ speed))

predict (lm1, data.frame (speed = speed2))

# モデル診断 4枚表示されるのであらかじめ画面を4分割する
par (mfrow = c (2,2))
plot (lm1)


# 重回帰帰分析をしてみる
# スイスの出生率と経済社会動向データ
head (swiss)

# 多重回帰 すべての変数で回帰
lm2 <- lm(Fertility ~ ., data = swiss)
# 要約
summary (lm2)

# 係数を出力
coef (lm2)

# モデル診断
par (mfrow = c (2,2))
plot (lm2)


# 回帰を連続的に適用する
## dplyr::do を使う

library (dplyr)
mtcars %>% group_by(cyl) %>%
  do(
    carslm = lm (mpg ~ wt, data = .)
  ) %>% summarise(summary(carslm)$r.squared)

## purrr::mapを使う
library (purrr)
mtcars %>%
  split(.$cyl) %>%
  map(~ lm(mpg ~ wt, data = .)) %>%
  map(summary) %>%
  map_dbl("r.squared")

# モデルのアップデート
# 項を追加
lm3 <- update(lm2, .~. + I (Education^2) )
summary (lm3)

# 項を減らしてアップデートする
lm4 <- update (lm3, .~. - Examination )
summary (lm4)

# ステップワイズに変数を選択する
step (lm4, direction = "backward" )


# scope引数で指定された項から1つを加えてあてはめる
# 説明変数の交互作用をペアごとに追加した結果と，
# 交互作用を含まないモデルを比較
add1(lm2, ~ .^2)

# add1関数の出力をanovaで確認
lm5 <- lm (Fertility ~ .  + Agriculture:Examination, data = swiss)
anova(lm2, lm5)







  ## ----- SECTION 151  時系列データの統計量

# 体温を模した擬似データを乱数で作成
temp <- round (rnorm (20, mean = 36.5, sd = 0.01), 2)
# 2012年1月から毎月1回測った時系列オブジェクトに変換
(tmp.ts <- ts (temp, start = c (2012, 1), frequency = 12))


# 自己相関をみる
acf (UKgas)
# 偏相関を出力させる。ただしプロットは描かない
acf (UKgas, type = "partial", plot = FALSE)

# 自己回帰モデル
(ar.UK <- ar (UKgas))

summary (ar.UK)






  ## ----- SECTION 152  検出力を求める
# 検定力を求める
power.t.test (n = 30, delta = 8, sd = 10, sig.level = 0.05,
              power = NULL, strict = TRUE)

# 必要な標本数を求める
power.t.test (n = NULL, delta = 8, sd = 10, sig.level = 0.05,
              power = 0.86, strict = TRUE)







  ## ----- SECTION 153 モデル式の基礎知識
# women データを作業スペースに登録
attach (women)
# モデル式
mdl <- weight ~ height
# 属性を確認
class (mdl); typeof (mdl)

# 回帰を求める関数の引数に適用する
lm (mdl)

# 連番からなる変数xがあるとき
x <- paste("x", 1:10, sep="")

# モデル式を作成する
(mdl2 <- as.formula (paste ("y ~ ", paste(x, collapse= "+"))))
## y ~ x1 + x2 + x3 + x4 + x5 + x6 + x7 + x8 + x9 + x10
# 交互作用をモデル化する
y <- x1 <- x2 <- 1:10
mdl3 <- y ~ x1 * x2
mdl4 <- y ~ x1 + x2 + x1:x2

# モデルとしては同等
terms (mdl3)
terms (mdl4)

#   以下にモデル式の例をいくつかあげます。


y ~ 1#, NULL モデル。全平均だけで推定するモデル（回帰で1は切片を表す。）
y ~ x#, 回帰でxは説明変数、分散分析では複数の水準からなるカテゴリカル変数
y ~ x - 1#，回帰で切片を推定しない
y ~ . #, 右辺のドットが、残りのすべての変数を「＋」で結ぶことを意味する
y  ~ x1 + x2 + x3 - x1:x2:x3#，3次の項を除くモデル。y ~ (x1 + x2 + x3)^2 に同じ
y ~ x1 / x2 / x3#, ネストモデル y ~ x1 + x2 %in% x1 + x3 %in% x2 %in% x1 に同じ
y ~ x1 * x2 * x3 + Error (x1 / x2 / 3)#, 分割区法（split-plot）で各因子ごとに誤差項を推定
y ~ s (x1) + s (x2)#, 変数を平滑化する
log (y) ~ I (1 / x1)#, ネストを表す「／」を除算演算子として扱う
y ~ x1 | x2#, 「x2」を条件して 「y」と「x1」ノ関係をみる
y ~ x1 + offset (x2)#，x2 をモデルに組み込むがパラメータの推定はしない



update (mdl3, .~. - x1:x2)
# y ~ x1 + x2

update (mdl3, .~. - x1:x2 - x2 + poly (x2,2))
# y ~ x1 + poly (x2, 2)

# 目的変数を対数化
update (mdl3, log(.) ~.)
# log(y) ~ x1 + x2 + x1:x2

