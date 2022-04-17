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

# テーブル設計

## users テーブル

| Column                | Type    | Options                    |
| --------------------- |---------|--------------------------- |
| nickname              | string  | null: false                |
| email                 | string  | null: false, unique: true  |
| encrypted_password    | string  | null: false                |
| first-name            | string  | null: false                |
| last-name             | string  | null: false                |
| first-name-kana       | string  | null: false                |
| last-name-kana        | string  | null: false                |
| birth-year            | integer | null: false                |
| birth-month           | integer | null: false                |
| birth-day             | integer | null: false                |

### Association

- has_many :items
- has_many :orders

## items

| Column                | Type       | Options                         |
| --------------------- |------------|---------------------------------|
| item-name             | string     | null: false                     |
| item-text             | text       | null: false                     |
| category              | string     | null: false                     |
| item-status           | string     | null: false                     |
| price                 | integer    | null: false                     |
| shipping-charges      | integer    | null: false                     |
| ship-from             | string     | null: false                     |
| ship date             | integer    | null: false                     |
| user                  | references | null: false,  foreign_key: true |

### Association

- belongs_to :user
- has_one: order

## orders

| Column                | Type       | Options                         |
| --------------------- |------------|---------------------------------|
| user                  | references | null: false,  foreign_key: true |
| item                  | references | null: false,  foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item