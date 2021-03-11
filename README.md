# furima-34810のER図

## usersテーブル

| Colum           | Type   | Options     |
| ----------------| ------ | ----------- |
| email           | string | null: false |
| password        | string | null: false |
| nickname        | string | null: false |
| first_name      | string | null: false |
| last_name       | string | null: false |
| first_name_kana | string | null: false |
| last_name_kana  | string | null: false |

### Association
- has_many :items
- has_many :orders
- has_one :information

## itemsテーブル

| Colum       | Type        | Options                        |
| ----------- | ----------- | ------------------------------ |
| name        | string      | null: false                    |
| description | text        | null: false                    |
| price       | integer     | null: false                    |
| user        | references  | null: false, foreign_key: true |

### Association
- belongs_to :user
- has_one :order
- has_one :information

## ordersテーブル

| Colum | Type       | Options                        |
| ----  | ---------- | ------------------------------ |
| user  | references | null: false, foreign_key: true |
| item  | references | null: false, foreign_key: true |

### Association
- belongs_to :user
- belongs_to :item
- has_one :information

## informationテーブル

| Colum        | Type    | Options     |
| ------------ | ------- | ----------- |
| post_code    | integer | null: false |
| city         | string  | null: false |
| block        | string  | null: false |
| building     | string  |             |
| phone_number | integer | null: false |

### Association
- belongs_to :user
- belongs_to :item
- belongs_to :order
