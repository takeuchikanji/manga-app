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

## Production environment
* http://54.150.36.40/
* 本アプリケーションのURLになります。
* The URL for this application.

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
* 管理者専用の機能、登録ユーザーのみが利用できる機能、誰でも利用できる機能があります。管理者は全ての機能を使用可能。
* 管理者専用機能
  * 作品の投稿・編集・削除機能
  * 管理者画面の使用
* ログイン・サインアップ機能
* 登録ユーザーの機能
  * 作品のブックマーク機能
  * 紹介してほしい作品を要望する機能
* 誰でも利用可能な機能
  * 作品検索機能
* There are features for administrators only, features that are only available to registered users and features that can be used by anyone. Administrators can use all the features.
* Administrator-Only Features
  * Cartoon posting, editing, and deletion features
  * Using the Admin Screen
* Login and sign-up function
* Features for registered users
  * Cartoon bookmarking feature
  * The ability to request a work to be featured
* Features available to everyone
  * Cartoon search function

## Ruby version
* Ruby => version'2.6.5'

## System dependencies
* Ruby On Rails => version'6.0.0'

## Database design

### ER diagram
<img width="1318" alt="スクリーンショット 2020-11-23 18 09 00" src="https://user-images.githubusercontent.com/69382240/99944935-133d9480-2db7-11eb-8464-dd36b313de69.png">

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
  - has_many :requests


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


### requests table

|Column|Type|Options|
|------|----|-------|
|comicname|string|null: false|
|authorname|string|null: false|
|comment|text|null: false|
|user_id|references|null: false, foreign_key: true|

- Association

  - belongs_to :user