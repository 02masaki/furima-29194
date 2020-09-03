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

#  テーブル設計

## users テーブル

| Column        | Type     | Options               |
| ------------- | -------- | --------------------- |
| first_name    | string   | null: false           |
| family_name   | string   | null: false           |
| first_name_re | string   | null: false           |
| family_name_re| string   | null: false           |
| email         | string   | null: false           |
| password      | string   | null: false           |
| nick_name     | string   | null: false           |
| birth_day     | date     | null: false           |

### Association

- has_many :items
- has_many :comments
- has_many :buys

## items テーブル

| Column    | Type      | Options                        |
| --------- | --------- | ------------------------------ |
| name      | string    | null: false                    |
| price     | integer   | null: false                    |
| content   | text      | null: false                    |
| user      | references| null: false, foreign_key: true |

### Association

- has_many :comments
- has_one :buy
- belongs_to :user

## comments テーブル

| Column    | Type      | Options                        |
| --------- | --------- | ------------------------------ |
| comment   | text      | null: false                    |
| user      | references| null: false, foreign_key: true |
| item      | references| null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

## buys テーブル

| Column    | Type      | Options                        |
| --------- | --------- | ------------------------------ |
| user      | references| null: false, foreign_key: true |
| item      | references| null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :address

## addresses テーブル

| Column     | Type      | Options                        |
| ---------- | --------- | ------------------------------ |
| postal_code| string    | null: false                    |
| prefecture | string    | null: false                    |
| city       | string    | null: false                    |
| address    | string    | null: false                    |
| building   | string    |                                |
| tel        | string    | null: false                    |

### Association

- belongs_to :buy