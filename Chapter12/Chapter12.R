# 第3版  2016年 06 月 22 日


############################################################
#                第12章  基本グラフィックス                #
############################################################

  ## ----- SECTION 174  グラフィックスの基礎知識

library(help = "grDevices")
?Devices




  ## ----- SECTION 175 グラフ領域を設定する

# デフォルトの外部マージン
par("oma")

par ()$oma; par ()$omi; par ()$omd

par ()$mar; par ()$mai

# マージンを3行分とる。またデフォルトを「oldpar」に保存
oldpar <- par (oma = rep (3, 4), mar = rep (3, 4) )
# par ()$oma  <- c(3, 4); par("oma")

# ダミーのプロット(実際には何も描画されない)
plot (c (0, 1), c (0, 1), type = "n", ann = FALSE, axes = FALSE)
# ここから枠を描いていく
box ("plot", col = "green") # プロット領域を囲む
box ("figure", col = "blue") # その他の作図領域を囲む
# box ("inner", col = "blue")でも同じ
box ("outer", lwd = 3, col = "red")
text (.5, .5, "プロット領域(plot region)", cex = 1.6)
mtext ("作図領域(figure region)", side = 1, line = 1, adj = 0, cex = 1.6)
mtext ("デバイス領域(device margin)", side = 3 , line = 1, cex = 1.6,  adj = 1, outer = TRUE)

# 最初の状態を復元
par (oldpar)
# dev.off() でも復元される（グラフィックス・ウィンドウが消滅するので）






  ## ----- SECTION 176 点と線を描画する
# プロットを分割する
par (mfrow = c (2,3) )
# 点
plot (1:10, c (1:5,5:1), type = "p")
# 線
plot (1:10, c (1:5,5:1), type = "l")
# 線と点
plot (1:10, c (1:5,5:1), type = "b")
# 点と、それを通る線
plot (1:10, c (1:5,5:1), type = "o")
# 垂直の線
plot (1:10, c (1:5,5:1), type = "h")
# 階段
plot (1:10, c (1:5,5:1), type = "s")

# デバイスを閉じる（「par」設定は初期状態に戻る）
dev.off ()




  ## ----- SECTION 177  ダミーの（空白の）散布図を描く
# デフォルトのユーザー座標系を確認
par()$usr

# windowsデバイスは開くが何も表示されない
plot (x = 1:10, y = 1:10, type = "n", axes = FALSE, ann = FALSE)
par()$usr # 「plot」関数実行後のユーザー座標
# [1] 0.64 10.36 0.64 10.36
# ユーザー領域を塗り潰す
rect(par()$usr [1], par()$usr [3] ,par()$usr [2], par()$usr [4],  col = "gray88", border = NA)
# 軸を描く
axis (1, at = c (3,6,9), labels = c ("いち","にい","さん"),
      hadj = 0, padj = 1, col.axis = "blue", col.ticks = "red",
      cex.axis = 2.5, tck = 0.4, lwd.ticks = 2.5, las = 2) # hadj = 0,

axis (2, at = c(2,4,6,8), labels = c("AB","CD","EF","GH"),
      hadj = 2, padj = c(0,1,2,3), col.axis = "blue",
      col.ticks = "green", tcl = -0.9,
      cex.axis = 2.5, srt = 60)

# タイトル
title (main = "メインタイトル", sub = "サブタイトル",
       cex.main = 2.2, cex.sub = 1.8)




  ## ----- SECTION 178 データ点を描く
# 空のwindowsデバイスを用意
plot (x = 1:10, y = 1:10, type = "n")

# データを描く
points (1:5, 1:5, pch = 1:5, cex = 1:5)

# 文字列を描く
text (6:10, 6:10, lab = as.character (6:10), col = 1:5,
      cex = 1.5, srt = 60)




  ## ----- SECTION 179 日本語フォントを設定する

windowsFonts()
## $serif
## [1] "TT Times New Roman"

## $sans
## [1] "TT Arial"

## $mono
## [1] "TT Courier New"

windowsFonts (JP1 = windowsFont("MS Gothic"), JP2 = windowsFont ("MS Mincho"))
plot (1:10, family = "JP1", main = "MS 明朝") 
plot (1:10, family = "JP2", main = "MS ゴシック")


quartzFonts (hiraGothic = rep("HiraKakuPro-W3", 4), 
              hiraMin = rep ("HiraMinPro-W3", 4))
plot (1:10, main = "ゴシック", family = "hiraGothic")
plot (1:10, main = "明朝", family = "hiraMin")

# Linux (Ubuntu)
plot (1:10, main = "タカオ明朝", family = "TakaoMincho")

install.packages ("Cairo")
library (Cairo)

# Cairoでのフォント設定例
CairoFonts (
            regular = "IPA P明朝,IPAPMincho:style=Regular",
            bold = "IPA Pゴシック,IPAPGothic:style=Regular,Bold",
            italic = "IPA P明朝,IPAPMincho:style=Regular,Italic",
            bolditalic = "IPA Pゴシック,IPAPGothic:style=Regular,Bold Italic,BoldItalic")

# Cairoデバイスでpng画像を作成
CairoPNG (file = "cairo2.png", bg = "white")
plot (1:10, 1:10, main ="テスト", cex = 1.2)
dev.off ()


#「.Rprofile」ファイル の例
setHook (packageEvent ("grDevices", "onLoad"),
        function (...){
            grDevices::quartzFonts (serif = grDevices::quartzFont (
                c ("Hiragino Mincho Pro W3",
                   "Hiragino Mincho Pro W6",
                   "Hiragino Mincho Pro W3",
                   "Hiragino Mincho Pro W6")))
            grDevices::quartzFonts (sans = grDevices::quartzFont (
                c ("Hiragino Kaku Gothic Pro W3",
                   "Hiragino Kaku Gothic Pro W6",
                   "Hiragino Kaku Gothic Pro W3",
                   "Hiragino Kaku Gothic Pro W6")))
        }
)
attach (NULL, name = "MacJapanEnv")
assign ("familyset_hook",
       function () { if(names(dev.cur()) == "quartz") par (family = "sans")},
       pos = "MacJapanEnv")
setHook ("plot.new", get ("familyset_hook", pos = "MacJapanEnv"))

options (X11fonts = c ("-alias-gothic-%s-%s-*-*-%d-*-*-*-*-*-*-*",
                          "-adobe-symbol-*-*-*-*-%d-*-*-*-*-*-*-*"))

setHook (packageEvent ("grDevices", "onLoad"),
        function (...) grDevices::ps.options (family="Japan1Ryumin"))




  ## ----- SECTION 180 線を描く

# 「各種プロット」
# 画面を2行2列に分割
par (mfrow = c (2,2))
# 空のwindowsデバイスを用意
plot (x = 1:10, y = 1:10, cex.lab = 1.6, type = "n")

#「x」軸での範囲と「y」軸の範囲をそれぞれベクトルで指定
lines (c (0,5), c (0,5), lty = 1, lwd = 5, col = "blue")
lines (c (5,10), c (5,10), lty = "62623737", lwd = 5)

# ヒストグラム風の線分であれば「plot」で指定可能
plot (x = 1:10, y = 1:10, cex.lab = 1.6, type = "h", lwd = 5)

# 折れ線グラフ
plot (c (1,6,2,7,3,8,4,9,5,10), cex.lab = 1.6, type = "l", lwd = 5)

# 階段グラフ
 plot (c (1,6,2,7,3,8,4,9,5,10), cex.lab = 1.6, type = "s", lwd = 5)
# 最後に上部余白にタイトルを描く
title (main = list ("各種プロット", cex = 1.6), outer = TRUE)

# 作図指定をいったんクリアする
dev.off()

# 「線種プロット」
# 上部に大きめの余白を設定
 par (oma = c (1, 2, 3, 2))
 plot (x = 1:6, y = 1:6, type = "n", cex.lab = 1.6)
 # 6種類の線とカラーを使った線
for(i in 1:6){
  lines (c(1,10), c(i,i), lty = i, col = i, lwd = 5)
}
 # 最後にタイトルを描く
 title (main = list ("線種", cex = 1.6), outer = TRUE)


# 「線種その2」
par (oma = c(1, 2, 3, 2))
plot (x = 0:4, y = 0:4, type = "n", cex.lab = 1.6)
# 両端を丸める
lines (c (1,3), c (1,1), lwd = 30, lend = 0) # "round"
# 両端が矩形
lines (c (1,3), c (2,2), lwd = 30, lend = 1) # "butt"
# 矩形だが飛び出させた
lines (c (1,3), c (3,3), lwd = 30, lend = 2) # "square"
title (main = list ("線種その２", cex = 1.6), outer = TRUE)



# 「回帰直線」
# 回帰直線は「abline」関数で追加するのが簡単
# 米国人女性の身長と体重のデータ
plot (weight ~ height, women, cex = 1.8,
      cex.lab = 1.6, cex.axis = 1.4)
lm1 <- lm (weight ~ height, data = women)
abline (lm1, lwd = 5)

# 作図指定をいったんクリア
dev.off()




  ## ----- SECTION 181 複雑な図形やグラフを簡単に描く
# グリッド・パッケージを利用する
library (grid)

# 基本的なグラフィックス関数
# 円を描く
grid.circle (r = 0.5)
# 矩形を描く
grid.rect (width = 0.8, height = 0.8)
#ポリゴン
grid.polygon (x = c (0.3, 0.5, 0.7, 0.2),
              y = c (0.2, 0.4, 0.5, 0.8))



# 画面消去
grid.newpage ()

# 縦と横の8割を指定した作図領域（「viewport」）を用意
vp1 <- viewport (width = 0.8, height = 0.8,
                 xscale = c (0,10), yscale = c (0,10))
# 作図領域の設定を確認
grid.show.viewport (vp1)
# デバイスに登録する
pushViewport (vp1)
# 軸を描画
grid.xaxis ()
grid.yaxis ()

# 同じ指定のビューポート
vp2 <- viewport (w = 0.8, h = 0.8,
                 xscale = c (0, 10), yscale = c (0, 10))
# grid.show.viewport (vp2)
# 既存のデバイスに追加する
pushViewport (vp2)

# 軸を描く
grid.xaxis ()
grid.yaxis ()
# 点と直線と矢印、円
grid.points (0:10, 0:10 )
grid.lines (x = c(0.1,0.2) , y = c (0.5,0.8),
            arrow = arrow (angle = 30,
              ends = "last", type = "open"))
grid.circle (r = 0.5)

# 矩形を描く
grid.rect (width = 0.8, height = 0.8)
#ポリゴン
grid.polygon (x = c (0.3, 0.5, 0.7, 0.2),
    y = c (0.2, 0.4, 0.5, 0.8))

#「gTree」オブジェクトとして保存
gg2 <- grid.grab ()
class (gg2)
grid.draw (gg2)

# 作画設定をクリアする
dev.off ()


  ## ----- SECTION 182  グリッド・オブジェクトを一括で表示する
# 縦と横の8割を指定した作図領域（viewport）を用意
vp1 <- viewport (width = 0.8, height = 0.8,
                 xscale = c (0,10), yscale = c (0,10))
# 軸を描く
gr1 <- xaxisGrob ()
gr2 <- yaxisGrob ()
# 最初のビューポートに軸をセットした「gTree」オブジェクトを作成
gt1 <- gTree(children = gList (gr1, gr2), vp = vp1)
# 縦と横の8割を指定した作図領域を新たに用意
vp2 <- viewport (w = 0.8, h = 0.8,
     xscale = c (0, 10), yscale = c (0, 10))
# 点と直線と矢印、円
gr3 <- pointsGrob (0:10, 0:10 )
gr4 <- linesGrob (x = c (0.1,0.2) , y = c (0.5,0.8),
                  arrow = arrow (angle = 30,
                    ends = "last", type = "open"))
gr5 <- circleGrob (r = 0.5)
# 矩形を描く
gr6 <- rectGrob (width = 0.8, height = 0.8)
#ポリゴン
gr7 <- polygonGrob (x = c (0.3, 0.5, 0.7, 0.2),
     y = c (0.2, 0.4, 0.5, 0.8))
gl1 <- gList (gr1, gr2 ,gr3, gr4, gr5, gr6, gr7)
# 2つ目の作図領域に点などを追加した「gTree」オブジェクトを作成
gt2 <- gTree (children = gList (gr1, gr2, gr3, gr4, gr5, gr6, gr7), vp = vp2)
# 2つの「gTree」オブジェクトを統合して描く
gt12 <- addGrob (gt1, gt2)
# 作成されたオブジェクトをプロットする
grid.draw (gt12)

dev.off ()


  ## ----- SECTION 183  凡例を表示する

plot (1:10, main = "凡例１", pch = 1:10, cex = 2.2, cex.lab = 1.6, col = 1:10)
 # 凡例を追加
legend (1,10, legend = LETTERS [1:10],
        pch = 1:10, col = 1:10, pt.cex = 1.8, cex = 1.8)



plot (1:10, main = "凡例２", cex = 2.2, cex.lab = 1.6, type = "n")
for (i in 2:6)
  lines (c (1,10), c (i,i), lwd = 3, lty = i, col = i )
 # 凡例を追加
legend (1,10, legend = LETTERS [2:6], ncol = 2,
        title = "線種と色", title.col = 1,
        lwd = 3, text.col = 2:6, lty = 2:6, col = 2:6,
        bg = "gray88", box.lty = 3, seg.len = 5,
        pt.cex = 1.8, cex = 1.8)





  ## ----- SECTION 184 グラフに数式を表示する
# メインタイトルに数式を使う
plot (1:10, main = expression (paste (mu == 0,", ", sigma == 1)),
      cex.main = 2.6)


x <- rnorm (1000) # 正規分布に従う乱数
hist(x, main = expression (paste (mu == 0,", ", sigma == 1)),
     col = "green", ylab = "確率密度", freq = FALSE, cex.lab = 1.4,
     xlim = c (-4, 4), ylim = c (0,.8), las = 1, cex.main = 2.6)
# 密度曲線を描く
curve (dnorm, from = -4, to = 4, add = TRUE, lwd = 3,
       lty = 2, col = "red")
# 凡例の作成
legend ("left", cex = 1.8, title = expression (f(x) ==
    frac (1, sigma * sqrt (2*pi)) ~~ e^{frac (-(x - mu)^2, 2 * sigma^2)}),
        legend = c ("経験分布", "理論分布"), col = c ("green", "red"),
        lwd = 5, inset = .02, bty = "n")







  ## ----- SECTION 185  グラフにジッターを加える
(x <- rep (1:5, each = 3))

# このままだと重なってしまう（実際には15個の点がある）
plot (x, x, main ="ジッターなし",
      cex.main = 2.2, cex.lab = 1.6, cex = 1.8)

# ジッターを加える
plot (x, jitter (x), main ="ジッターあり",
      cex.main = 2.2, cex.lab = 1.6, cex = 1.8)

# 密度プロット
plot (density (faithful$eruptions, bw = 0.15),
      main ="密度プロット", cex.main = 2.2,
      cex.lab = 1.6, cex = 1.8 )
## # ラグを追加
rug (faithful$eruptions )




  ## ----- SECTION 186 グラフを分割する
lm1 <- lm (weight ~ height, data = women)
# 行方向にプロットを並べる
par (mfrow = c (3, 3))
# 診断プロット
plot (lm1, cex = 1.4, cex.main = 2, cex.sub = 1.8)

# 列方向にプロットを並べる
par (mfcol = c (3, 3))
plot (lm1, cex = 1.4, cex.main = 2, cex.sub = 1.8)
# 行列を使ってプロットを区分けする


layout (matrix (c (1, 2, 3, 4), nrow = 2))
# レイアウトを確認
layout.show (2)

# 3つ目のプロットまでの表示枠を確認
layout.show (3)

# 非対称なレイアウト1
(tmp <- matrix(1:4, ncol = 2))
nf1 <- layout (tmp,
               widths = c (2, 1),
               heights = c (1, 2)
               )
layout.show (nf1)

# 非対称なレイアウト２
(tmp <- matrix(c(1, 1, 2, 2,  0, 3, 3, 0), # 描画の順番
               nrow = 2, byrow = TRUE))
nf3 <- layout (tmp,
     heights = c (1, 1) ,
     respect= FALSE )
layout.show (nf3)




  ## ----- SECTION 187 グラフを保存する

# windowデバイスの保存
plot (1:10, main = "あいうえお")
# pdfファイルの作成。フォントファミリーの設定
dev.copy2pdf (file = "aiueo1.pdf", family = "Japan1")
dev.copy2pdf (file = "aiueo1G.pdf", family = "Japan1GothicBBB")
dev.copy2pdf (file = "aiueo1H.pdf", family = "Japan1HeiMin")
# epsファイル
dev.copy2eps (file = "aiueo1H.eps", family = "Japan1HeiMin")

# 出力先をファイルと指定する
png (file = "aiueo.png")
plot (1:10, main = "あいうえお")
dev.off()

pdf (file = "aiueo.pdf", family = "Japan1")
plot (1:10, main = "あいうえお")
dev.off()

postscript(file = "multi.ps")
plot (1:10, main = "1枚目")
plot (1:10, main = "2枚目")
plot (1:10, main = "3枚目")
dev.off ()





  ## ----- SECTION 188 対話的にデータ点を確認する
plot (1:10, pch = 1:10)

# 3箇所の座標点を取得
locator (3)

identify (1:10, labels = LETTERS [1:10])

# 凡例を表示する位置を指定
legend (locator (1), pch = 1:10, LETTERS [1:10])
# プロット上の任意の位置にテキストを表示
# 2箇所にテキストラベルを加える
text (locator (2), c ("あ", "ア"), cex = 1.6)





  ## ----- SECTION 189 プロットの要素にカラーを設定する
plot(1:10, col = 1:10, cex = 14, pch = 16,
     main = "カラーの設定", col.main = "red",
     sub = "数値で指定できる", col.sub = "blue",
     col.axis = "red", col.lab = "red")


dev.off()
 # 以下、出力を10個に限定する

colors ()[1:10]

pie (rep(1,10), col = colors ()[1:10] )

# 虹
rainbow (20)

pie (rep (1,10), col = rainbow (10))

# 白から赤（暖色）
heat.colors (10)

pie (rep (1,10), col = heat.colors (10))

# 白から緑
terrain.colors (10)

pie (rep (1,10), col = terrain.colors (10))

# 白から青
topo.colors (10)

pie (rep (1,10), col = topo.colors (10))

# 白から紫
cm.colors (10)

pie (rep (1,10), col = cm.colors (10))

# グレーの濃淡
gray (seq (0, 1, 0.1)) # grey ()でもよい

pie (rep (1,10), col = gray (seq(0, 1, 0.1)))

# RGBを指定。デフォルトでは0から1の値で指定
rgb (red = 0.5, green = 0.5, blue = 0.5)

# 半透過
rgb (red = 128, green = 128, blue = 128, alpha = 128,
     maxColorValue = 255)

plot (1:10, cex = 14, pch = 16,
      col = rgb(red = 0, green = 0, blue = 0, alpha = 128,
        maxColorValue = 255))






  ## ----- SECTION 190 バーチャート（棒グラフ）を作成する
# バージニア州の死亡率データ
head (VADeaths)

par (oma = c (3,2,1,2))
mp <- barplot (VADeaths, cex.names = 1.2, cex.axis = 1.2,
               names.arg = colnames (VADeaths), las = 2,
               legend = rownames(VADeaths), args.legend = list(cex = 1.2))


# 各バーの中点に，それぞれの地区の平均値を表示.Y字句の高さも平均値と同じと指定
text (mp, colMeans(VADeaths), colMeans(VADeaths), 
      col = "yellow", cex = 1.4)


# カラーや凡例を追加する
barplot(VADeaths, beside = TRUE,
        col = c ("lightblue", "mistyrose", "lightcyan",
          "lavender", "cornsilk"),
        cex.names = 1.4, args.legend = list(cex = 1.2),
        legend = rownames(VADeaths), ylim = c(0, 100))
title(main = "バージニア州での死亡率")



#  3D 風のバーチャート
# 
install.packages ("latticeExtra")
library (latticeExtra)

cloud (VADeaths, panel.3d.cloud = panel.3dbars, col.facet = "lightblue", 
       xbase = 0.4, ybase = 0.4, screen = list (z = 40, x = -30))









  ## ----- SECTION 191  パイチャート（円グラフ）を作成する

# バージニア州の死亡率データ
head (VADeaths)


pie (VADeaths[,1], col = rainbow (nrow (VADeaths)),
     clockwise = TRUE, main = "バージニア州の死亡率")



# 3D風のパイチャートを作成する
install.packages ("plotrix")
library (plotrix)
# help (package = "plotrix")
# library (help = "plotrix")

pie3D (VADeaths[,1], col = rainbow (nrow (VADeaths)),
       labels = row.names (VADeaths), main = "バージニア州の死亡率")






  ## ----- SECTION 192 箱ひげ図を作成する
# 餌の効果による鶏の体重増加効果
# head (chickwts)
x <- boxplot (weight ~ feed, data = chickwts)
# 「y」軸上の最小値
min (x$stats)

 # 軸ラベルを調整する
boxplot (weight ~ feed, data = chickwts, axes = FALSE,
         ylim = c (80, 420))
text (x = 1:6, y = 90, labels = levels (chickwts$feed),
      cex = 0.75, srt = 65)
axis (2, at = seq (100, 450, 50))
box ("plot")


boxplot (weight ~ feed, notch = TRUE, horizontal = TRUE, data = chickwts)




  ## ----- SECTION 193 Clevelandのドットチャートを作成する

dotchart (VADeaths, cex = 1.2, main = "バージニア州の死亡率")





  ## ----- SECTION 194 ストリップチャートを作成する
stripchart (decrease ~ treatment, vertical = TRUE, cex = 1.2,
            log = "y", data = OrchardSprays)




