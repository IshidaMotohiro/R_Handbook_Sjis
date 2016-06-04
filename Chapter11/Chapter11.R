
# 改訂第3版  2016年03月19日

############################################################
#                   第11章 応用統計解析                    #
############################################################


  ## ----- SECTION 154 CRAN Task Views

# Task Viewsを管理するパッケージを導入


# install.packages("ctv")
# install.views("Econometrics")




  ## ----- SECTION 155  一般化線形モデルを実行する

# install.packages("faraway") # farawayパッケージのデータを例に説明します
library (faraway)
data (gala)
head (gala)

# ポアソン回帰モデル
# 単純にアルファベット順に最初の2つを説明変数とする
model1 <- glm (Species ~ Adjacent + Area, data = gala, family = poisson)
summary (model1)





  ## ----- SECTION 156 一般化線形モデルを更新/比較する

# もう1つ変数を投入する
model2 <- update (model1, . ~ . + Elevation)
summary (model2)

# 2つのモデルを比較する
anova (model1, model2, test ="Chi")

## 説明変数をすべて投入したモデル
model3 <- glm (Species ~ . , data = gala, family = poisson)
summary (model3)

# 1つずつ変数を減らして逸脱度の変化をみる
drop1 (model3, test = "Chi")

# すべてを投入したモデルから自動的にモデル選択する
library (MASS)

#  scope引数の指定がない場合、デフォルトでは"backward"
stepAIC (model3)






  ## ----- SECTION 157 二項分布を仮定して、データに一般化線形モデルを適用する

# もう少し複雑な二項モデルの例
?esoph # 胸部食道癌データ
head (esoph)

# モデル式左辺に「罹患数(ncases)」と「非罹患数(ncontrols)」
# 「年代(agegp)」と「飲酒(alcgp)」、「喫煙(tobgp)」の効果を指定
binom2 <- glm (cbind (ncases, ncontrols) ~ agegp + tobgp * alcgp,
               data = esoph, family = binomial())

anova (binom2, test = "Chi")

# 自動的にモデル選択
binom2.step <- stepAIC (binom2)

#  選ばれたモデルのANOVA表
binom2.step$anova

#  既存のモデルから特定の項を除く
update (binom2, .~. - tobgp:alcgp)

binom3 <- glm (cbind (ncases, ncontrols) ~ 1,
               data = esoph, family = binomial())


binom3.step <- stepAIC (binom3, direction = "forward", 
                        scope =  list (upper =  ~ agegp * tobgp * alcgp))






  ## ----- SECTION 158 主成分分析を実行する

# 合衆国各週の犯罪率
USArrests

# 相関行列を指定
pc.cr <- princomp (USArrests, cor = TRUE)

# 説明力のある上位の主成分
summary (pc.cr, loadings = TRUE)

# 主成分得点
pc.cr$scores [1:5, ]
# 主成分負荷量と主成分得点を同時にプロット
biplot (pc.cr)





  ## ----- SECTION 159 因子分析を実行する

# 『RとS-PLUSによる多変量解析』第 4 章
# 1960 年代の世代別平均余命データ（修正版）
life <- read.table ("life.txt", row.names = 1)
head (life)

#「factanal」関数で3因子まで求める
life.fa <- factanal(life, factors = 3, scores = "regression")
# 結果を確認する
life.fa

# 因子負荷量を確認
life.fa$loadings
# loadings (life.fa)
# 因子得点を確認
life.fa$scores

# 因子得点と因子負荷量のバイプロット
biplot (life.fa$scores, life.fa$loadings)

# 斜交回転
life.fa2 <- factanal (life, factors = 3,
                       scores = "regression", rotation = "promax")

# 結果を確認する
life.fa2
biplot (life.fa2$scores, life.fa2$loadings)



# 直交回転の結果から導出することも可能
life.fa3 <- promax (loadings (life.fa), m = 4)
life.fa3

#「GPArotation」パッケージを導入
# install.packages ("GPArotation")
library (GPArotation) # このライブラリを導入すれば
life.fa3.ob <- factanal (life, factors = 3,
                         rotation = "oblimin", # オブリミン法を指定できる
                         scores = "regression")

biplot (life.fa3.ob$scores, life.fa3.ob$loadings)





  ## ----- SECTION 160  対応分析を実行する

library (MASS) #「MASS」パッケージをロード
# 髪と眼それぞれの色の対応データ
caith

(caith.ca <- corresp (caith, nf = 2))

# バイプロットを描く
biplot (caith.ca)
# 行は農場で各列は牧草地についての複数の条件を表わすデータ
head (farms)

library (MASS)
(farms.mca <- mca (farms, abbrev=TRUE))

plot (farms.mca)





  ## ----- SECTION 161 クラスター分析を実行する
# 『RとS-PLUSによる多変量解析』第 4 章
# 1960 年代の世代別平均余命データ
life <- read.table ("life.txt", row.names = 1)
head (life)

## 階層的クラスター分析
# 距離を求める。デフォルトは「ユークリッド法」
life.d <- dist (life)
# クラスター化する。デフォルトは最遠隣法(complete)
life.h <- hclust (life.d)
str (life.h)

# 結果をプロットする
plot (life.h, hang = -1)
# 樹形図の高さ。上（最後）から2つ目の値を取得2番目の
height <- tail(life.h$height, 2)[1]
# これを使って樹形図に赤い破線を描く
lines (x = c(0, length (life.h$order)),
       y = rep(height, 2), lty = 2, col = 2)

## クラスターの所属数
 # table (cutree (life.h, life.h$height[15] ))

## 非階層的クラスター分析
set.seed (123)
km <- kmeans (iris[-5], centers = 3)
table (km$cluster, iris[,5])

# なおR-3.1.0でward法の実装に修正が加えられました。修正版のward法を実行するにはmethod="ward.D2"と指定します。
# 詳細は?hclustを実行して、ヘルプを参照してください




  ## ----- SECTION 162  線形判別分析を実行する
# 組み込みの「アヤメ」データからランダムに80行抽出
set.seed (123)
extract <- sample (1:150, 80)
iris2 <- iris [extract, ]

# 抽出データを使って判別を学習
library (MASS)
(iris.lda <- lda (Species ~ ., data = iris2))

# 学習による判別結果を確認
table (iris2 [, 5], predict (iris.lda)$class)


plot (iris.lda)
plot (iris.lda, dimen = 1)

iris.lda2 <- predict (iris.lda, iris [-extract, ] )
table (iris [-extract, 5], iris.lda2$class)

# 交差妥当化
iris.lda3 <- lda (Species ~ ., data = iris, CV = TRUE)
# 結果を確認
table (iris [, 5], iris.lda3$class)




  ## ----- SECTION 163  ニューラルネットワークを実行する

library (nnet)
# 組み込みの「アヤメ」データからランダムに80行抽出
set.seed (123)
extract <- sample(1:150, 80)
iris2 <- iris [extract, ]

# 抽出データを使って学習
iris.nn <- nnet (Species ~ ., data = iris2, size = 3)


iris.pre <- predict (iris.nn, iris2, type = "class")
table (iris2[ , 5], iris.pre)


# 取りのけておいたデータを分類
iris.rest <- iris [-extract, ]
iris.pre2 <- predict (iris.nn, iris [-extract, ], type = "class")
table (iris [-extract, 5], iris.pre2)






  ## ----- SECTION 164 サポートベクターマシンを実行する
# 「kernlab」パッケージを読み込む
library (kernlab)
iris2 <- iris[1:100, ]
iris2$Species <- droplevels (iris2$Species)

# 抽出した「アヤメ」データからランダムに50行抽出
set.seed (123)
extract <- sample(1:100, 50)
iris3 <- iris2 [extract, ]

# 訓練データから学習
iris.train <- ksvm (Species ~ ., data = iris3, kernel = "vanilladot")

# 学習結果を使って残りデータを判別
iris.test <- predict (iris.train, iris2 [-extract, ] )
table( iris2 [-extract, ]$Species, iris.test)





  ## ----- SECTION 165 決定木を利用する
library (rpart)
# 術後の脊柱後弯症の有無データ
nrow (kyphosis)

head (kyphosis)


# 症状の有無を年齢、手術した椎骨の数、その一番上の椎骨の番号
fit <- rpart (Kyphosis ~ Age + Number + Start,
              data = kyphosis)
# 枝分れを確認する

par(xpd = NA)
plot(fit, branch = 0.8, margin = 0.05)
text(fit, use.n = TRUE)

# 狩りこみが必要な場合
z.auto <- rpart (Mileage ~ Weight, car.test.frame)
printcp (z.auto)
plotcp (z.auto)
zp <- prune(z.auto, cp = 0.1)




  ## ----- SECTION 166 自己組織化マップを作成する
# install.packages ("kohonen")

library (kohonen)
data (wines)
set.seed (7)

# 訓練データを抽出
training <- sample (nrow (wines), 120)
# 標準化する
Xtraining <- scale (wines [training, ])
# テストデータを訓練データと同じ尺度で標準化
Xtest <- scale (wines[-training, ],
                center = attr (Xtraining, "scaled:center"),
                scale = attr (Xtraining, "scaled:scale"))

# 訓練データを5×5のユニットに分類する
som.wines <- som (Xtraining,
                  grid = somgrid (xdim = 5, ydim = 5,
                    topo = "hexagonal"))

# 訓練結果をプロット
plot (som.wines)

# 等級と対応させるため「wine.classes」データと照合
plot (som.wines, type = "mapping", labels = wine.classes[training], col= wine.classes [training] )



# テストデータを分類する
som.prediction <- predict(som.wines, newdata = Xtest,
                               trainX = Xtraining,
                               trainY = factor(wine.classes[training]))
table(wine.classes[-training], som.prediction$prediction)




  ## ----- SECTION 167 ベイジアンネットワーク分析を利用する
#「deal」パッケージをインストールする
install.packages ("deal")
library (deal)
data (ksl)
head (ksl)

# 初期ネットワークを作成
ksl.nw <- network (ksl)
plot (ksl.nw)

# 初期のノードの事前分布を計算
ksl.pr <- jointprior (ksl.nw)
# 事前分布からパラメータを更新
ksl.ln <- learn (ksl.nw, ksl, ksl.pr)
# 更新結果からネットワークオブジェクトを取得
ksl.nw <- getnetwork (ksl.ln)
# 事後ネットワークの推定
ksl.as <- autosearch(ksl.nw, ksl, ksl.pr)

# ネットワークをプロットする
plot (getnetwork (ksl.as))
print (ksl.as)

# 禁則ルールの指定
# ノード番号を確認
ksl.nw

(mybanlist <- matrix (c (5, 5, 6, 6, 7, 7,
                         9, 8, 9, 8, 9, 8, 9, 8),
                      ncol = 2))

banlist (ksl.nw) <- mybanlist
ksl.nw2 <- getnetwork (learn (ksl.nw, ksl, ksl.pr))
ksl.as2 <- autosearch (ksl.nw2, ksl, ksl.pr)

# 禁則ルールに該当する場合赤い矢印で表示される
plot (getnetwork (ksl.as2), showban = FALSE)





  ## ----- SECTION 168  ベイズ統計解析を行う

#「MCMCpack」パッケージをインストールする
install.packages ("MCMCpack")
library(MCMCpack)


# 例
## 大統領支持の割合
posterior <- MCmultinomdirichlet(c(727,583,137), c(1,1,1), mc=10000)
class (posterior)
summary (posterior)

plot (posterior)


# MCMCpack の関数一覧
# さまざまなモデル分析用の関数がある
ls ("package:MCMCpack")






  ## ----- SECTION 169  ベイズ法で線形回帰分析を行う
# 線形回帰モデル
line <- list (X = c (-2,-1,0,1,2), Y = c (1,3,3,3,5))
posterior <- MCMCregress (Y~X, data=line, verbose=1000)

summary (posterior)
raftery.diag (posterior)




  ## ----- SECTION 170 MCMCpackパッケージでユーザー定義の関数をシミュレーションする

# サンプリングしたい関数を定義
# ロジスティック・モデルの対数尤度関数
logitfun <- function (beta, y, X){
  eta <- X %*% beta
  p <- 1.0/(1.0 + exp (-eta)) # リンク関数
                                        # 対数尤度
  sum(y * log(p) + (1-y)*log (1-p))
}

# データ
x1 <- rnorm (1000)
x2 <- rnorm (1000)
Xdata <- cbind (1,x1,x2)
p <- exp (.5 - x1 + x2)/(1 + exp (.5 - x1 + x2))

# 二値データの作成
yvector <- rbinom (1000, 1, p)
head (yvector)

p <- exp(.5 - x1 + x2) / (1 + exp (.5 - x1 + x2))
# 二値データをシミュレーション
yvector <- rbinom (1000, 1, p)

# このデータと尤度関数を使ってサンプリングを行う  #  時間がかかります
post.samp <- MCMCmetrop1R (logitfun, theta.init=c (0,0,0),
                           X=Xdata, y=yvector,
                           thin=1, mcmc=40000, burnin=500,
                           tune=c (1.5, 1.5, 1.5),
                           verbose=500, logfun=TRUE)

# サンプリングの要約
summary (post.samp)

dat <- data.frame (cbind (yvector, Xdata))
# 比較として一般化線形モデルによる結果
dat.glm <- glm (yvector ~ x1 + x2, data = dat,
                family = binomial (link = "logit"))
summary (dat.glm)








## ----- SECTION 170 RStanパッケージ

install.packages("rstan")


N <- 10
y <- c(0,1,0,0,0,0,0,0,0,1)
coinModel <- '
data {
int<lower=0> N;
int<lower=0,upper=1> y[N];
}
parameters {
real<lower=0,upper=1> theta;
}
model {
theta ~ beta(1,1);
for (n in 1:N)
y[n] ~ bernoulli(theta);
}' 

library (rstan)

coinData <- list (N = N, y = y)

fit <- stan(model_code = coinModel, data = coinData, iter = 1000, chains = 4)

fit

traceplot (fit)

fit.ext <- extract(fit, "theta") 
quantile (fit.ext$theta)

# 階層モデル
schools_code <- '
data {
 int<lower=0> J; // 高校の数を表す整数
 real y[J]; // 推定された効果
 real<lower=0> sigma[J]; // その標準誤差  
}

parameters {
  real mu;           // 全体平均
  real<lower=0> tau; // 効果
  real eta[J];       // 誤差
}
transformed parameters {
  real theta[J];     // 高校ごとの効果
  for (j in 1:J)     // etaは高校ごとに異なる誤差
    theta[j] <- mu + tau * eta[j];
 }
model {
  eta ~ normal(0, 1);
  y ~ normal(theta, sigma); // ベクトル演算が適用される
 }'


# データを用意
schools_dat <- list(J = 8, y = c(28,  8, -3,  7, -1,  1, 18, 12), sigma = c(15, 10, 16, 11,  9, 11, 10, 18))


# 並列化する
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())


# rstanでサンプリング
fit <- stan(model_code = schools_code, data = schools_dat, iter = 1000, chains = 4, adapt_delta = 0.81)


# 引数を追加指定
fit <- stan(model_code = schools_code, data = schools_dat, iter = 1000, chains = 4, control = list(adapt_delta = 0.9))

install.packages("shinystan")

library (shinystan)
launch_shinystan(fit)

