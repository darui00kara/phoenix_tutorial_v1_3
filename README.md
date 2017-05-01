# Rails tutorial for Phoenix - 実例と共に不死鳥と遊ぶ -
# Version: v1.3.0-rc.0

# Index

Phoenix Tutorial 
|> Introduction  
|> What is Phoenix-Framework?  
|> Demo application  
|> Static pages  
|> Filling in layout  
|> Modeling users  
|> Sign up  
|> Sign-in and Sign-out  
|> Updating users  
|> User microposts  
|> Following users  

# Foreword

以前、記事や本を読んでいただいた方にはお久しぶりです。新しく読んでくれた方には始めまして！
これを書いているとき、私はまだ転職できていないことでしょう。
Elixirを使って仕事をしてみたいとも思わないでもないですが、趣味のままで良いとも思っています。
それはさておき、PhoenixチュートリアルはElixir言語のWebフレームワークであるPhoenixについて書いたものです。
Elixirで仕事をしている方、趣味でElixirをやっている方、Elixirに興味はあるけどまだ手を出していない方、その他大勢の方...
その方たちにインスピレーションを与えることができたらなら、これほど素晴らしいことはありません。
そして少しでも、Elixirという言語の布教に役立つことができたら幸いです。
そんな目的があり、Phoenixチュートリアルというものを作りました。  

おそらく、この内容がPhoenixを使う上での決定版とはならないでしょう。しかし、何かの助けにはなると信じています。
本内容では、Phoenixの基本的な使い方、テスト駆動開発(TDD: Test Driven Development)との組み合わせ、Ectoの使い方など、
ElixirでWeb開発を行う上で欠かすことのできない内容が(全て無料で)載っています。(ElixirでWeb開発をするかどうかはわかりませんが...)
また、GitやGithubを使いそれぞれの章毎に作っていきます。そのため、実際の開発に近い形で学習を進めていくことができると思います。  

本内容の進め方としてオススメは、Ruby on Rails Tutorialのように一気に進めることですが、
実際には気ままにやってもらえれば良いと思っています。
一気に駆け抜けるも良し、休憩を挟みつつ少しずつ進めるも良し...やり方はひとそれぞれです。自分のペースにあったやり方で進めてみて下さい！  

それでは、楽しんでいただけたら幸いです。  

# Acknowledgments

Phoenixチュートリアルは、Elixir言語とPhoenixフレームワークがなければ、作る事さえなかったものです。
Elixir言語とPhoenixフレームワークを開発したJosé Valim氏とChris McCord氏へは敬意を表すると共に感謝を捧げたいと思います。
また、Ruby on Rails Tutorialの作者様、日本語訳を実施して下さった訳者様方にも敬意と感謝を捧げます。
この中のどなたが欠けても、本チュートリアルが完成することはなかったでしょう。  

私にインスピレーションと知識を与えてくれた@hayabusa333氏にも大いなる感謝をしたいと思います。  
「いつも私のわがままを聞いてくれてありがとう！」  

# About

本チュートリアルは、Ruby on Rails TutorialのサンプルアプリケーションをPhoenixフレームワークのv1.3.0-rc.0で作成していきます。
一応、Phoenixフレームワークの初心者、入門者を対象としています。  

#### Note: herokuは使いません。

まぁ急ぎではないので気楽にやっていきます。もしかしたら途中で内容ががらりと変わるかもしれませんので、気長に完成を待ってくださると幸いです。  

ソースコード一式はGithubへアップしています。  
Github: [darui00kara/phoenix_tutorial_v1_3 (master)](https://github.com/darui00kara/phoenix_tutorial_v1_3)  

# Dev-Environment

開発環境は下記のとおりです。  

- OS: MacOS X v10.11.6
- Erlang: Eshell V8.1, OTP-Version 19
- Elixir: v1.4.2
  * Phoenix Framework: v1.3.0-rc.0
  * Comeonin: v2.5.0
  * Scrivener: v2.1.1
  * Scrivener_html: v1.3.3
  * Scrivener_ecto: v1.0.3
- Node.js: v7.7.3
- PostgreSQL: postgres (PostgreSQL) 9.6.1

# Bibliography

参考にした書籍及びサイトの一覧は下記になります。  

[Ruby on Rails Tutorial Learn Web Development with Rails](https://www.railstutorial.org/book)  
[Ruby on Rails チュートリアル 実例を使ってRailsを学ぼう](http://railstutorial.jp/)  
[Github - riverrun/comeonin](https://github.com/riverrun/comeonin)
[Github - drewolson/scrivener](https://github.com/drewolson/scrivener)  
[Github - mgwidmann/scrivener_html](https://github.com/mgwidmann/scrivener_html)  
[Github - drewolson/scrivener_ecto](https://github.com/drewolson/scrivener_ecto)  
