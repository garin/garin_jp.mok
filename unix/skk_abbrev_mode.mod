# author : がりん <garin54@gmail.com>
# create : 2011-05-25
# update : 2011-05-26
# language: ja
# rights: (c) 2011 garin.jp
# version: 1.0.1
# publisher: garin.jp
# tag : skk emacs

= SKK の abbrev-mode を一時アスキー(英字)入力モードにする

== 概要
=== skk-abbrev-mode を一時英字(アスキー)入力モードに
((<skk-abbrev-mode|http://www.ushape.org/manuals/TEXINFO/usr/share/xemacs21/mule-packages/man/skk/skk_81.html>)) は skk の abbrev(略語展開)です。
アスキー文字を見出しとして以下のような略語展開を行います。

  ▽is → SPACE → インクリメンタル・サーチ

略語展開はとても便利な機能ですが、私は略語展開を((<HippieExpand|http://www.emacswiki.org/emacs/HippieExpand>))にすべてまかせてしまっているので、skk-abbrev-mode を使っていません。
そこで、skk-abbrev-mode を上書きして、一時的に英字を入力するためのモードとして使っています。

この一時英字入力モードは、日本で文章を書いている途中で、一時的に英字入力したい時に使用します。
例えば次のような文章です。

  Apache では設定ファイルの構文チェックをするのに apachectl configtest コマンドを使います。
    # apachectl configtest
    Syntax OK
  上記のように Syntax OK が表示されれば問題ありません。

「Apache」のような単語や「# apachectl ...」のような数行のコマンドラインの入力のたびに skk-latim モードに出たり入ったりするのは面倒です。
一時英字入力モードでは、▽モードで一時的にひらがなを漢字に変換するモードと同じように「その時だけ」英字入力モードに入ります。入力を確定すれば、ひらがな入力モードに戻ります。
また、入力中の文字の先頭を大文字にしたり(apache→Apache)、全てを大文字(apache→APACHE)にする変換する便利機能もついています。

=== 基本的な使い方
abbrev-mode の置き換えなので / で一時英字入力モードに入ります。確定するまでの間、半角英数字が入力できます(ローマ字変換しない)。

  /
  ↓
  ▽abc
通常の abbrev-mode ではスペースで確定しますが、一時英字入力モードではスペースもそのまま入力でき、モードを続けることができます。
  ▽abc def
英数字の入力が完了したら \ で確定です。ひらがな入力モードに戻ります。

  ▽abc def
  ↓
  \
  ↓
  abc def


== skk-abbrev-mode-replace
skk-abbrev-mode-replace.el は既存の skk-abbrev-mode-on を上書きし、一時英字入力モードを提供します。

=== 必要な elisp
* ((<skk|http://openlab.ring.gr.jp/skk/index-j.html>)) : SKK 本体です
* ((<HippieExpand|http://www.emacswiki.org/emacs/HippieExpand>)) : 略語展開を行います

=== 設置手順

==== ダウンロード
skk-abbrev-mode-replace.el を適当なディレクトリに配置します。
* ((<skk-abbrev-mode-replace.el(github.com)|https://github.com/garin/zatta/blob/master/lisp/skk-abbrev-mode-replace.el>))

==== 設定
.emacs で skk-abbrev-mode-replace を読み込みます。
(~/.emacs.d/skk-abbrev-mode-replace.el にファイルを配置したと想定)
++ .emacs
  (load "~/.emacs.d/skk-abbrev-mode-replace.el")

=== キーバインド
:/ (skk-abbrev-mode-on)
  一時英字入力モードに入ります。

:\ (skk-kakutei)
  入力を確定します。
  例: ▽abc → \ → abc
:C-q (skk-toggle-capitalize)
  入力中文字の最初の英字を小文字から大文字に変換して確定します。
  例: ▽abc → C-q → Abc
:C-@ (skk-toggle-uppercase)
  入力中の文字の小文字を全て大文字に変換して確定します。
  例: ▽abc → C-@ → ABC
:C-i (skk-abbrev-kautei-hippie-expand)
  入力を確定して hippie-expand を呼び出します(要:hippie-expand)。
  例: ▽is → C-i → インクリメンタル・サーチ  (※hippie で展開されるように設定している場合)
