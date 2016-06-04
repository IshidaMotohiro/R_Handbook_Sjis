
# 改訂第3版  2016年3月5日

############################################################
#               第13章 多変量グラフィックス                #
############################################################





  ## ----- SECTION 192  分割表をプロットする
# タイタニック号のデータ
str (Titanic)

mosaicplot (Titanic, main = "タイタニックの生存者データ",
     shade = TRUE )

# 男女別生存状況
mosaicplot (~ Sex + Survived, data = Titanic,
     shade = TRUE )

# さらに年齢を加味
mosaicplot (~ Sex + Age + Survived, data = Titanic,
     shade = TRUE )

# カラーを指定する
mosaicplot (Titanic, main = "タイタニックの生存者データ",
     color = 2:3 )


# 四分割プロット
(tx <- Titanic [Class = "1st", , Age = "Adult", ])

fourfoldplot (tx)

# 連関プロット
(ty <- HairEyeColor [,,"Female"])
assocplot (ty)




  ## ----- SECTION 193  コプロット（条件付散布図）を描画する
summary (quakes)

# 連続量を条件変数とし、パネルごとの重なりを減らしたプロット
coplot (lat ~ long | depth, overlap = 0.1, data = quakes)

# 条件変数を二つにしたプロット
coplot (lat ~ long | depth * mag, data = quakes,
        xlab = "条件変数を二つにしたコプロット")




  ## ----- SECTION 194 ヒートマップを作成する
# 乗用車の燃費デーの最初の4つの変数を抽出した行列を作成
x <- as.matrix (mtcars [, 1:4])
# 行（乗用車の種別）についてはデンドログラムを作成する
hv <- heatmap (x, col = cm.colors (256), Colv = NA,
               xlab = "specification variables",
               main = "乗用車の燃費データ")

# 距離関数を変更
distf <- function (dat) {
  dist (dat, method = "manhattan")
}

# 距離として「マンハッタン」を使う
hv <- heatmap (x, col = cm.colors (256), Colv = NA, 
               distfun = distf,
               xlab = "specification variables", 
               main = "乗用車の燃費データ(manhattan)")



  ## ----- SECTION 195  3次元データをグラフ化する
# ニュージーランドの Mt. Eden の地形データ
x <- 10 * (1:nrow (volcano))
y <- 10 * (1:ncol (volcano))
z <- 2 * volcano   # やや強調する
image (x, y, z, col = terrain.colors (100), # 大地をイメージしたカラーを利用
       axes = FALSE)

# 鳥瞰図
persp(x, y, z, theta = 135, phi = 30, col = "green3", scale = FALSE,
      ltheta = -120, shade = 0.75, border = NA, box = FALSE)

# 等高線図
contour (x, y, z)






  ## ----- SECTION 196  「lattice」グラフィックスとは

library (lattice)
# 以下で四つのグラフィックス・オブジェクトを作成
# 品種ごとにガク片の長さと幅を散布図にする
xy1 <- xyplot (Sepal.Length ~ Sepal.Width | Species, data = iris)

# 変数の水準ごとにパネルを分ける。ただしパネルは1行3列とする
xy2 <- xyplot (Sepal.Length + Sepal.Width ~ Petal.Length + Petal.Width | Species,
               layout = c(3, 1), data = iris)

# スケールをパネルごとに変更する
xy3 <- xyplot (Sepal.Length + Sepal.Width ~ Petal.Length + Petal.Width | Species, layout = c(3, 1),
     scales = "free", data = iris)

# 凡例を追加
xy4 <- xyplot (Sepal.Length + Sepal.Width ~ Petal.Length + Petal.Width | Species, 
               scales = "free", auto.key = list (x = .5, y = .7), layout = c (2, 2), data = iris)

# まとめて1枚のプロットにパネルとして並べる
# 2 行 2 列に分割されたプロット上で 1 行目 1 列目に描画


print (xy1, split = c (1,1,2,2), more = TRUE)
print (xy2, split = c (1,2,2,2), more = TRUE)
print (xy3, split = c (2,1,2,2), more = TRUE)
print (xy4, split = c (2,2,2,2))



# 棒グラフ
# 等級と性別ごとの生存と死亡の棒グラフ
barchart (Class ~ Freq | Sex, data = as.data.frame (Titanic))

# よりわかりやすくした棒グラフ  
bc.titanic <- barchart (Class ~ Freq | Sex + Age, # プロットの作成結果を代入
                        data = as.data.frame (Titanic),
                        groups = Survived, stack = TRUE,
                        layout = c (4, 1),
                        auto.key = list (title = "生存者"),
                        scales = list (x = "free"))
# 生成したグラフ・オブジェクトを描画する
bc.titanic

# オブジェクトをアップデートすることでグラフを変更できる
update (bc.titanic,
        panel = function (...) { # パネル関数を再定義する
          panel.grid (h = 0, v = -1) # グリッド線を追加する
          panel.barchart (...)
        } )



# ドット・プロット
dotplot (variety ~ yield | year * site, data=barley)

dotplot (variety ~ yield | site, data = barley, groups = year,
         key = simpleKey (levels (barley$year), space = "right"),
         xlab = "大麦の生産量", ylab = NULL, aspect = .3,
         layout = c (1,6))

# 関数内部に「lattice」のグラフィックス関数を埋め込む
myBarChart <- function (){
  barchart (Class ~ Freq | Sex, data = as.data.frame (Titanic))
  cat ("これが関数内部の最後の行\n")
}

myBarChart () # 実行してもグラフィックスは作成されない

# 「print」関数で明示的に描画
myBarChart2 <- function (){
  myPlot <- barchart (Class ~ Freq | Sex, data = as.data.frame (Titanic))
  print (myPlot)
  cat ("これが関数内部の最後の行\n")
}
myBarChart2 () # こちらは直ちに表示される


bwplot (voice.part ~ height, data = singer, xlab = "Height(inches)")

# 変量ごとに箱ひげ図を作成する。その際、カテゴリ分けする
bwplot (Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
               ~ Species, data = iris, outer = TRUE)








  ## ----- SECTION 197  3次元散布図を作成する

# 3次元散布図
cloud (Sepal.Length ~ Petal.Length * Petal.Width | Species, data = iris,
       screen = list(x = -90, y = 70), distance = .4, zoom = .6)






  ## ----- SECTION 198  3次元平面透視図を作成する

# ニュージーランドの Mt. Eden の地形データ
# 基本グラフィックス関数の場合
filled.contour (volcano, color.palette = terrain.colors, asp = 1)

# 「lattice」で作図
# library (lattice)
wireframe (volcano, shade = TRUE)





  ## ----- SECTION 199  「ggplot2」グラフィックスとは

# パッケージをインストール
# install.packages ("ggplot2")
library (ggplot2)

# デフォルトを活用する「qplot」
data (diamonds)
qplot (carat, price, data = diamonds)

# 平滑化線を追加する
qplot (carat, price, data = diamonds,
       geom = c ("point","smooth"), method = "lm")

# 箱ひげ図
qplot (color, carat, geom = "boxplot", data = diamonds)

# ヒストグラム
qplot (carat, geom = "histogram", binwidth = .5, data = diamonds)

# 棒グラフ
qplot (carat, geom = "bar", binwidth = .5, data = diamonds)

# 「ggplot」関数によるマッピング
p1 <- ggplot (diamonds, aes (x = carat, y = price, color = cut))
# まだ描画できない
p1


# レイヤーを追加して描画
p1 + geom_point()# p1 + layer (geom = "point")に同じ

# 別の描画
p2 <- ggplot (diamonds, aes (carat))
p2 + stat_density() # p2 + layer(stat = "density")に同じ


# ファセットを使って水準ごとに分割
p2 + geom_density() + facet_wrap(~ cut)

# プロットを分けずに水準を区別
ggplot (diamonds, aes (price, fill = cut)) + geom_density (alpha = 0.2)


# ラベルの追加
p1 + geom_point() + labs (title = "メインタイトル", x = "X軸", y = "Y軸")

# ウィンドウに表示されているグラフィックスをPDFで保存
ggsave (file = "ggplot2.pdf")


# プロットの土台を作成
p <- ggplot (iris, aes(x = Sepal.Width, y = Sepal.Length, colour = Species))
# 点を打つ
p + geom_point () 
# さらに回帰直線を加える
p + geom_point () + geom_smooth ()



p <- ggplot(iris, aes (Sepal.Length))
p + geom_histogram ()
# デフォルトではY軸は頻度(以下の命令に同じ)
# p + geom_histogram(aes(y = ..count..))


# 密度に変える
p + geom_histogram(aes(y = ..density..))

# 枠のカラー指定
p + geom_histogram(aes(colour = Species))


# 塗り潰しカラーの指定
p + geom_histogram(aes(fill = Species))


# ビンを設定
p + geom_histogram(aes(fill = Species), binwidth = 0.5)

library(help = "ggplot2")


# 品種ごとの度数を積み上げたヒストグラム
p + geom_histogram(
  aes(fill=Species),
  alpha = 0.5,
  position = "stack"
)


# 横に並べたヒストグラム
p + geom_histogram(
  aes(fill=Species),
  alpha = 0.5,
  position = "dodge"
)


# 品種ごとにヒストグラムを作成
p + geom_histogram(
  aes(fill=Species),
  alpha = 0.5,
  position = "identity"
)


p <- ggplot(iris, aes (Sepal.Length))
p + geom_histogram(color = "black", fill = NA)

library (tidyr)


# 縦長形式に整形したデータを「ggplot」に渡し「geom_boxplot」を指定
iris %>% gather (key, value, -Species ) %>%  ggplot(aes(x = key, y = value, color = key)) +   geom_boxplot()


# 軸ラベルは「labs」関数の引数として指定する以外に，「xlab」や「ylab」で指定することも可能
 iris %>% gather (key, value, -Species ) %>% ggplot(aes(x = key, y = value)) +  geom_boxplot() + xlab("品種") + ylab("") +  ggtitle("箱ひげ図")


# 品種ごとにプロットを作成
iris %>% gather (key, value, -Species ) %>% ggplot(aes(x = key, y = value)) + geom_boxplot() + facet_wrap (~Species)


# 点の形状を変更
p <- ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, shape = Species))
p + geom_point()

# 軸の幅を調整
p <- ggplot(iris, aes(x = Sepal.Width, y = Sepal.Length, colour=Species))
p + geom_point()  + xlim(c(1.0, 5.0))

# 軸を調整する
p + geom_point()  + scale_x_continuous(breaks=seq(1, 5, by=.25))

p <- ggplot(iris, aes (Sepal.Length))
p + geom_histogram() + coord_flip()


# 背景デザインの変更
p + geom_histogram() + theme_bw (base_size = 12)



## ----- SECTION 200  「rgl」パッケージによる３Dグラフィックス

install.packages ("rgl")
library (rgl)

open3d () # RGLデフォルトの作画パラメータを利用
x <- sort (rnorm (1000))
y <- rnorm (1000)
z <- rnorm (1000) + atan2 (x,y)
# ３D散布図
plot3d (x, y, z)

# 火山
z <- 2 * volcano # 大きさをやや誇張する
x <- 10 * (1:nrow (z)) # 10 meter spacing (S to N)
y <- 10 * (1:ncol (z)) # 10 meter spacing (E to W)
zlim <- range (y)
zlen <- zlim [2] - zlim [1] + 1
colorlut <- terrain.colors (zlen) # 大地風のカラーを利用
col <- colorlut [ z - zlim [1] + 1 ]

open3d () # RGLデフォルトの作画パラメータを利用

# ３D透視図
surface3d (x, y, z, color = col, back = "lines")


## ----- SECTION ***  「googleVis」パッケージ


install.packages ("googleVis")
library (googleVis)

# フルーツデータの確認
Fruits

M <- gvisMotionChart(Fruits, idvar="Fruit", timevar = "Year")
plot (M)

demo (googleVis)
# デモ一覧
demo(package='googleVis') 


