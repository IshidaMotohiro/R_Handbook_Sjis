#�@�{���̓��e�ɉ������ݒ�ɂȂ��Ă��܂�
# ��ʓI�Ȑݒ��http://oku.edu.mie-u.ac.jp/~okumura/stat/Rprofile.html���Q�Ƃ��Ă�������

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
