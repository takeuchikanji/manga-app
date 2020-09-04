# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


## authorsテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association

- has_many :mangas


## mangasテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|author_id|integer|null: false, foreign_key: true|
|image|text||
|number_of_books|integer|null: false|
|summary|text|null: false|
|review|text||

### Association

- has_many :mangas_users
- has_many :users, through: :mangas_users
- has_many :comments
- belongs_to :author


## usersテーブル

|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|

### Association

- has_many :mangas_users
- has_many :mangas, through: :mangas_users
- has_many :comments


## mangas_usersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|manga_id|integer|null: false, foreign_key: true|

### Association

- belongs_to :manga
- belongs_to :user


## genresテーブル

Column|Type|Options|
|------|----|-------|
|genre|string|null: false|

### Association

- has_many :mangas_genres
- has_many :mangas, through: :mangas_genres


## mangas_genresテーブル

|Column|Type|Options|
|------|----|-------|
|genre_id|integer|null: false, foreign_key: true|
|manga_id|integer|null: false, foreign_key: true|

### Association

- belongs_to :manga
- belongs_to :genre


## commentsテーブル

|Column|Type|Options|
|------|----|-------|
|text|text|null: false|
|user_id|integer|null: false, foreign_key: true|
|manga_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :manga