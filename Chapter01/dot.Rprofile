#　本書の内容に沿った設定になっています
# 一般的な設定はhttp://oku.edu.mie-u.ac.jp/~okumura/stat/Rprofile.htmlを参照してください

options (repos="http://cran.md.tsukuba.ac.jp")
setHook (packageEvent ("grDevices", "onLoad"),
         function (...) grDevices::pdf.options (family="Japan1"))
setHook (packageEvent("grDevices", "onLoad"),
         function (...) grDevices::ps.options (family="Japan1"))



.First <- function () {
    tmp <- suppressWarnings (require ("fortunes", quietly = TRUE))
    if (tmp) {
              print (fortunes::fortune())
             }
}
.Last <- function()
    if (interactive()) try (savehistory (".Rhistory"))
