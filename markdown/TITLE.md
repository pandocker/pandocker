# まえがき {-}
このドキュメントは、技術書典3にて発表した「私的Markdown-PDF変換環境を紹介する本」の続編に当たる本です。
~~前作の売れ行きが予想を上回って冬コミ在庫が心許ない事になったので続編を書くことにしました~~
前作の予告通りDockerイメージを構築するところまでうまく行ったので、その報告です。

もちろんこの本もDockerイメージを使ってコンパイルされました。

#### 前回までの「私的Markdown-PDF変換環境を紹介する本」（海外ドラマ風紹介文） {-}
前作では、_Unix環境を対象に_ 筆者が構築したPandoc式PDFドキュメント制作環境とその機能について、
最初のパッケージマネージャ導入から解説しました。Python/NodeJS/Haskell/LaTeXをインストールし、
PandocおよびPandocフィルタをインストールし、その他便利コマンドをインストールし、やっと書き出すところまで、
骨の折れる、読者のマシン環境を汚しかねない導入でした。

#### 反省事項？と改善事項と制限事項 {-}
前作を書き上げてからもWindows環境を無視するのはいかがなものかという心の葛藤[^windows-lol]が
ありました。これはやっぱりOS依存性が低いやり方[^os-independent]としてDockerイメージ
を公開して使ってもらえばいいんじゃないかと。

しかしWindowsでDocker導入ってこれもまたどうかと思って実際に会社の**Windows7PC**での導入実験を行ったところ、
やっぱり環境依存があるっぽいです[^windows-hell]。残念ですがWindowsユーザさんは
**Fall Creators Update(2017)を適用したWindow10PC**を使って下さい。WSLは不要というかちゃんと動かないらしいので
対象外です。

Linux/Macユーザさんは前作での実績もあるし問題はほぼないものと思います。

筆者が確認したOSはUbuntu16.04LTS/MacOS Sierra/Windows10(FallUCreatorsUpdate)です。

[^windows-lol]: Windowsとかずっとオープンβ()だし無視しようよ（悪魔~~天使~~）
vs.
一応会社でも使えるしやっといたほうがいいですよ（天使~~悪魔~~）
[^os-independent]: JAVA（笑）か？
[^windows-hell]: 自分のマシンはNGでラボのマシンはOKだったのでリモートで動かしてる。Windowsきらい。

# 前作からの`pandoc_misc`改良点
## 等幅フォントの第一候補をSource Code Proに変更
とくにMacで思った通りのフォントになっていなかったので、最近流行りのSourceCodeProを最初に探すように
CSSを更新しました。最終的に`monospaced`を指すのは変わらないので問題はないと思います。

## ページを横長にする（ランドスケープ）
PDF出力のときに横長の表を引用するのが楽になりました。実現のためにTeXテンプレートに手を入れています。
`\\Startlandscape`と`\\Stoplandscape`の間の区間は横長ページになります。

- TeXで１ページだけ余白設定を変更する方法 by \@genyajoe on \@Qiita
    - <https://qiita.com/genyajoe/items/4ca0652587651593d502>

`````markdown
\\Begin{landscape}
```table
---
caption: 'SSCI_SPI_LCD BOM テーブル（抜粋）'
include: "data/SSCI_SPI_LCD.csv"
width: 1.0
---
```
\\End{landscape}
`````

\\Startlandscape
```table
---
caption: 'SSCI_SPI_LCD BOM テーブル（抜粋）'
include: "data/SSCI_SPI_LCD.csv"
table-width: 1.0
---
```
\\Stoplandscape

## ソースコード引用フィルタを拡張
前作で紹介したソースコード引用フィルタですが、インライン表記版を追加しました。
画像ではなく普通のハイパーリンク表記を使います。頭に`!`がつかない方です。
この表記をするときは前後に空行を追加し、同じ行にリンク以外何もない状態にする必要があります。
さらに、ソースコードの一部を引用することもできるようになりました。引用元ファイルの`from`行目から
`to`行目を引用します。`from=5`、`to=12`のとき5行目から引用し、12行目を _含みます_。
また、オプションの統廃合を行いました。

```table
---
caption: ListingTableフィルタオプション改
markdown: True
alignment: DCCD
---
オプション,省略可能,デフォルト値,意味
`source`^[ブロック表記のとき。インライン表記ではURL部で指定する],N,,ソースファイル名(フルパス)
~~class~~,~~N~~,,"~~ソースファイル種類(python,cpp,markdown etc.)~~**廃止**。`type`で統一"
`type`,Y,plain,"ソースファイル種類(python,cpp,markdown etc.)"
~~tex~~,~~Y~~,~~False~~,~~LaTeXを出力するとき"True"にする。case sensitive~~**廃止**
`from`,Y,1,引用元ソースの切り出し開始行
`to`,Y,max,引用元ソースの切り出し終了行
```

`````markdown
前の文章

[Sample inline listingtable](README.md){.listingtable type=markdown from=5 to=12 #lst:inline-listingtable-sample}

次の文章
`````
前の文章

[Sample inline listingtable](README.md){.listingtable type=markdown from=5 to=12 #lst:inline-listingtable-sample}

次の文章

## リポジトリにタグを打つようにした
# Dockerイメージを使ってHTML/PDFを出力する（本編）
## _pandocker_ Dockerイメージ
## pandockerを使う
### 原稿リポジトリを作る
### 原稿を書く
### 出力する
# Appendix {-}
## Dockerfileを入手して自力でビルドする {-}
### github リポジトリ {-}
### Dockerfile {-}
[`pandocker-base`のDockerfile](pandocker-base/Dockerfile){.listingtable type=dockerfile}

[`pandocker`のDockerfile](Dockerfile){.listingtable type=dockerfile}

# 更新履歴 {-}
## Revision1.0（C93）

- 前作の技術書典３での売れ行きは衝撃だった。75％は記録的（注：総部数20）
- 次は自作python製PandocフィルタをPyPiに登録する and/or CIビルドの構築かな。CircleCIが候補に挙がってる
- 最終目標はmarkdownを書いてコミットしてプッシュするとCIされてHTML／PDFがGitHubのリリースページに置かれる
というところまでです。きっと誰かすでに実現してるしそうでなくても参考情報はいっぱいあるので助かってます:)
