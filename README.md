# FileWsh-Opal

## Version

FileWsh-Opal : Ver.0.1.0

## 概要

このクラスは、JScriptからWHS(Windows Script Host)のFile関連の機能を呼び出します。
RubyライクなプログラムをOpalでコンパイルし、RubyやNode.jsの実行環境なしにRubyライクなコードでファイルやディレクトリを
操作することができます。
HTA(HTML Application)から呼び出すことの可能なので、Bootstrap3と組み合わせることで、モダンなGUIを持ったファイル操作を行える
Ruby GUIツールを作成することができます。

## 背景

本スクリプトは、Windows環境で、かつ、Rubyの実行環境(EXEファイル)をユーザーの環境にインストールできずに困っているRubyユーザーに最適です。
また、ビルド環境など、余計な実行環境やライブラリをインストールしたくない場合や、
Micros◎ft製品しか信用しない企業がユーザーである場合に有効です。

なぜなら、Opal.jsとFileWsh.jsはWindows標準の"cscript.exe"で実行可能だからです。
オープンソースのスクリプトは使用しますが、Rubyの実行環境をユーザーのPCにインストールする必要はありません。スクリプトを配布するだけです。

(在のところ、コンパイルにはRubyのインストールが必要なので、あなたのPCにRubyをインストールする許可は必要です。
将来は、Opal.jsなどのスクリプトだけで対応したいと考えています）

## 実行環境

* Windows 7以上で確認(Windows 10は未確認)
* Windows Script Host Version 5.8
* Opal.js 0.8.0 ～ 0.8.1

## コンパイル

下記のコマンドで、filewsh.rbをコンパイルするとfilewsh.jsが作成されます。sampleなどで使用する場合は、jsフォルダへ移動して下さい。

``` fileWsh.rb
> bundle install --path vendor/bundle
> cd src
> bundle exec ruby opal_compiler.rb filewsh.rb
```

## sample

コマンドラインで使用するサンプルとHTAで動作するサンプルの２つがあります。
"sample.rb"ファイルのコンパイルと実行は次の通りです。

``` sample.rb
> cd sample
> bundle exec ruby ..\src\opal_compiler.rb sample.rb
> cscript sample.wsf
```

HTAのサンプルは"sampole-hta"の"hello_filewsh_with_bootstrap3.hta"ファイルをダブルクリックして下さい。
Bootstrap3を使ったモダンなGUIで、ファイルの読み込み、ディレクトリの操作、HTAの画面への反映が確認できます。
このサンプルは、コマンドラインよりもGUIを好むWindowsユーザー用の、「ちょっとした社内ツールのようなモノ」の作成の参考になると
思います。

（こちらは、コンパイルの必要はありません。HTAファイルに直接、Rubyプログラムコードを書きます）

## 制限

将来対応する予定ですが、現在のところ

1. UTF-8しか読み書きできません。
2. mvやcpなどのファイル、ディレクトリ操作のメソッドがRubyと異なる。
3. HTAでは、<script>タグのsrc属性でRubyの外部ソースを読み込むことはできません。
4. エラーのメッセージが不親切です。putsやalertで地道にデバックする必要があります。
5. バグがいっぱい、夢いっぱい（ぉ

## ライセンス

* MITライセンス

