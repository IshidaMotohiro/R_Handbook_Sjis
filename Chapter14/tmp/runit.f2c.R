# k華氏を摂氏に変換
f2c <- function(f) return (5/9 * f - 32)  # 正しくは # 5/9 * (f - 32)

## テスト関数
## ---------------------

test.f2c <- function() {
  checkEquals(f2c(32), 0)
   ## 文字列を与えてみる
  checkException (f2c ("xx"))
}


test.errordemo <- function() {
  stop("不正な引数です")
}

