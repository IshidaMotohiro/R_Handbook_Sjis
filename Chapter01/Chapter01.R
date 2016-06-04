
#  改訂第3版　2016年2月15日

############################################################
#                    第１章 R言語の基礎                    #
############################################################


  ## ----- SECTION 004  Rコンソールとスクリプトの実行
 # コンソールのプロンプトを変更する
 # 現在のプロンプトを確認する
options ("prompt")

# デフォルトの表示
plot (1:10, 1:10,
main = "プロンプト変更前")
 # プロンプトを変更する
options (prompt = "ishida: ")

op <- options (prompt = "ishida: ")
options (continue = "put: ")

# プロンプトを変更
plot (1:10, 1:10,
      main = "プロンプト変更後")


options(op) # ともに戻す



## ----- SECTION 006  Rの環境設定ファイル

## # 「.Renviron」の設定# 同封ファイルdot.Renvironを参照して下さい
## R_LIBS_USER=C:/Users/ishida/Documents/R/win-library/2.15
## R_LIBS_SITE=C:/Program Files/R/R-2.12.1/library


## # 「.Rprofile」の設定# 同封ファイルdot.Rprofileを参照して下さい
## options (repos="http://cran.md.tsukuba.ac.jp")
## setHook (packageEvent ("grDevices", "onLoad"),
##          function (...) grDevices::pdf.options (family="Japan1"))
## setHook (packageEvent("grDevices", "onLoad"),
##          function (...) grDevices::ps.options (family="Japan1"))

## .First <- function () {
##     tmp <- suppressWarnings (require ("fortunes", quietly = TRUE))
##     if (tmp) {
##               print (fortunes::fortune())
##              }
## }
## .Last <- function()
##     if (interactive()) try (savehistory (".Rhistory"))







  ## ----- SECTION 007  Rのセッション用オプションの指定
# デフォルトの表示幅
LETTERS

# 表示幅を変更
options (width = 60)
# 数値の表示幅
pi

getOption ("digits")
# 数値の表示桁数を変更
options (digits = 16 )

# 指数表示
10^5
getOption ("scipen")
options (scipen = 1)
10^5 ; 10^6
options (scipen = 3)
10^7

# 起動時にロードするパッケージ
(x <- getOption ("defaultPackages"))

# 「lattice」パッケージを追加
options (defaultPackages = c (x, "lattice"))




  ## ----- SECTION 008 作業フォルダの設定

getwd()
setwd(C:/workhome)




  ## ----- SECTION 009  利用したい機能の検索
# 「chi」（カイ）を文字列の一部に含む関数を表示する
apropos ("chi")
# 引数「mode」に「関数」を指定して検索結果を絞る
apropos ("chi", mode = "function")
#「simple.words」引数で部分一致を指定
find ("^chi", simple.words = FALSE)


  ## ----- SECTION 011  パッケージのインストール

options (repos = "http://cran.md.tsukuba.ac.jp")
install.packages ("パッケージ")

install.packages ("パッケージ", dependencies = TRUE)

pkg <- available.packages()
head (pkg [, 1])

# install.packages (pkg[,1])

.libPaths()

slib <- .libPaths()
# install.packages ("", lib = slibs[2])


install.packages("C:/Users/ishida/Documents/arm_1.6-01.02.zip", repos = NULL)

# コマンドプロンプトから
# C:\Users\ishida> R CMD INSTALL rgl_0.92.798.zip
# 

install.packages("ctv")
library (ctv)
install.views ("NaturalLanguageProcessing")
update.views ("NaturalLanguageProcessing")

# library ()

installed.packages ()

(.packages())

update.packages (checkBuilt = TRUE, ask = FALSE)

update.packages (ask = TRUE)

download.file("http://rmecab.jp/data.R", destfile = "data.R")






　## ----- SECTION 012  ヘルプの利用
# もっとも基本的な実行方法
?chisq.test
# 上と同じ結果
help ("chisq.test")
# パッケージの情報をみる
help (package = "lattice")

# 現在のヘルプの表示方法を確認
getOption ("help_type")
# 出力方法を指定してヘルプを参照
help ("chisq.test", help_type = "text")　#RStudioでは無効
# ヘルプの表示方法を変更
options (help_type = "text")

help.search ("^chi")





# Windows版Rの場合、デスクトップの標準設定のブラウザが利用されます
getOption ("browser")

options (browser = "C:/Program Files/Mozilla Firefox/firefox")




  ## ----- SECTION 013 ビニエット（簡易マニュアル）の利用
# 現在読み込んでいるパッケージに用意されたビニエット一覧

vignette (all = FALSE)　#RStudioでは無効

browseURL ("http://cran.md.tsukuba.ac.jp/",
     browser = "C:/Program Files (x86)/Mozilla Firefox/firefox")

demo ()
demo (package = .packages (all.available = TRUE))

demo (Japanese)

  ## ----- SECTION 014  Rや統計解析に関係する情報の収集
# R 関連のメーリングリストから探す
RSiteSearch ("chisq.test")

# メーリングリストの種類などを指定
RSiteSearch ( "bug", sortby = "date:late")






