#パッケージの読み込み
# readrパッケージをインストールしていない場合：install.packages("readr")
library(readr)
library(dplyr)

# GitHubリポジトリからのファイルのURLを "raw" 形式に変換
url <- "https://raw.githubusercontent.com/ticmrk/cvp/main/data.csv"

# read_csv関数を使ってデータの読み込み
data <- read_csv(url)
glimpse(data) #データの確認

#売上原価と販管費の和の列をつくる
data <- mutate(data, 総原価 = data$売上原価 + data$販管費)
glimpse(data)

#ggolot2パッケージで可視化
library(ggplot2)
g <- ggplot(data = data, mapping = aes(x = 売上高, y = 総原価)) + geom_point()
g <- g + theme_gray (base_family = "HiraKakuPro-W3") #（macのみ）日本語の文字化け防止．
g <- g + xlim(0, max(data$売上高)) + ylim(0, max(data$総原価)) #両軸の設定
g <- g + geom_smooth(method = "lm", formula = y ~ x) #回帰直線の追加
plot(g)

#単回帰
result <- lm(data$総原価 ~ data$売上高)
summary(result)
