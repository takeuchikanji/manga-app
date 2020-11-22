# README

# Comic-Remember
====
## Overview
* Comic-Rememberは、Rubyで作成した自分の読んだ漫画を紹介するアプリケーションです。
* Comic-Remember is an application created in Ruby that introduces you to the comics you've read.

## Description
* 漫画を読んでも、時間が経てば何を読んだか忘れることがあると思います。自分の読んだ作品を記録しておく備忘録としての役割があります。
* また、読んだ作品をウェブ上に公開することで、他の読者と感想を共有することもでき、利用者が読んでみたい、読み返してみたいと思えるようになっています。
* I think sometimes when you read a comic book, you forget what you read over time. It serves as a reminder to keep track of the works you read.
* Also, by posting the works you read on the web, you can share your impressions with other readers, so that they will want to read them and reread them.

## Feature
* このアプリの主なターゲットユーザーは、定期的に漫画を読んでいる人です。
* 利用者が過去に読んだことのある作品に出会って再読を促すことを目的としています。
* ユーザー登録をすればブックマーク機能、コメント投稿が可能。
* 利用者が直接漫画の投稿することはできませんが、管理者宛に紹介してほしい漫画の要望をおくることが可能。
* The main target users of this app are those who read manga on a regular basis.
* It is designed to encourage users to encounter works they have read in the past and reread them.
* If users register, they can post bookmarks and comments.
* Users can't post manga directly, but they can send the manga they want to be introduced to the administrator and request for introduction.

## Usage
* 画面から直感的に使用できるようになっている。
* トップページは以下のようになっており、作品をクリックすることで詳細画面へ遷移する。
* ユーザー登録/ログインは画面右上から行うことができる。
* It is intuitive and easy to use from the screen.
* The top page looks like the following, and by clicking on the cartoon, you will move to the details screen.
* User registration/login can be done from the top right corner of the screen.
<img width="1392" alt="スクリーンショット 2020-11-22 10 48 30" src="https://user-images.githubusercontent.com/69382240/99891743-96c08e00-2cb0-11eb-8a76-1de21db3f49e.png">

* タブを切替えることで、目的に応じて作品を確認できる。
* By switching tabs, you can check the works according to the purpose.
<img width="650" alt="スクリーンショット 2020-11-22 10 46 41" src="https://user-images.githubusercontent.com/69382240/99891806-4dbd0980-2cb1-11eb-83d1-3cd38a841ce5.png">

* 検索機能も用意しており、条件に応じて検索が可能。
* A search function is also available and allows you to search according to your criteria.
<img width="845" alt="スクリーンショット 2020-11-22 10 58 38" src="https://user-images.githubusercontent.com/69382240/99891881-f8cdc300-2cb1-11eb-8c99-fde85ef05b19.png">

* 作品詳細画面について
* 作品情報の閲覧、ブックマーク、コメントの投稿が可能。
* About the cartoon detail screen
* You can view information about the work, bookmark it, and post comments.
<img width="865" alt="スクリーンショット 2020-11-22 11 02 30" src="https://user-images.githubusercontent.com/69382240/99891907-4cd8a780-2cb2-11eb-90e2-3162601ca3bc.png">




## Ruby version
* Ruby => version'2.6.5'

## System dependencies
* Ruby On Rails => version'6.0.0'

## Database design

### ER diagram
<img width="1068" alt="スクリーンショット 2020-11-22 13 23 39" src="https://user-images.githubusercontent.com/69382240/99894161-13aa3280-2cc6-11eb-8d78-0751cbface89.png">

### authors table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

- Association

  - has_many :comics


### comics table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|name_kana|string|null: false|
|image|string||
|number_of_books|integer|null: false|
|summary|text|null: false|
|review|text|null: false|
|author_id|references|null: false, foreign_key: true|
|booknumber_id|integer|null: false|
|recommend_id|integer|null: false|

- Association

  - has_many :comics_genres
  - has_many :genres, through: :comics_genres
  - has_many :comments
  - has_many :bookmarks
  - has_many :users, through: :bookmarks
  - belongs_to :author
  - belongs_to_active_hash :booknumber
  - belongs_to_active_hash :recommend


### users table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|

- Association

  - has_many :comments
  - has_many :bookmarks
  - has_many :comics, through: :bookmarks


### bookmark table

|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false, foreign_key: true|
|comic_id|references|null: false, foreign_key: true|

- Association

  - belongs_to :user
  - belongs_to :comic


### genres table

|Column|Type|Options|
|------|----|-------|
|genre|string|null: false|

- Association

  - has_many :comics_genres
  - has_many :comics, through: :comics_genres


### comic_genres table

|Column|Type|Options|
|------|----|-------|
|genre_id|references|null: false, foreign_key: true|
|comic_id|references|null: false, foreign_key: true|

- Association

  - belongs_to :comic
  - belongs_to :genre


### comments table

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|references|null: false, foreign_key: true|
|comic_id|references|null: false, foreign_key: true|

- Association

  - belongs_to :user
  - belongs_to :comic