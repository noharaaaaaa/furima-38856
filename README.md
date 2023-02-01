# テーブル設計

## usersテーブル
| Column             | Type       | Options                        |
|nickname            |string      |null: false                     |
|email               |string      |null: false, unique: true       |
|encrypted_password  |string      |null: false                     |
|first_name          |string      |null: false                     |
|last_name           |string      |null: false                     |
|first_name_kana     |string      |null: false                     |
|last_name_kana      |string      |null: false                     |
|date_of_birth       |date        |null: false                     |

### Association
has_many :items
has_many :orders

## itemsテーブル
| Column             | Type       | Options                        |
|name                |string      |null: false                     |
|description         |text        |null: false                     |
|category_id         |integer     |null: false,                    |
|status_id           |integer     |null: false,                    |
|delivery_fee_id     |integer     |null: false,                    |
|prefecture_id       |integer     |null: false,                    |
|days_id             |integer     |null: false,                    |
|price               |integer     |null: false,                    |
|user                |references  |null: false, foreign_key: true  |

### Association
has_one_attached :image
has_one :order
belongs_to :user

## ordersテーブル
| Column             | Type       | Options                        |
|item                |references  |null: false, foreign_key: true  |
|user                |references  |null: false, foreign_key: true  |

### Association
belongs_to :user
belongs_to :item
has_one :address

## addresses
| Column             | Type       | Options                        |
|post_number         |string      |null: false,                    |
|prefecture_id       |integer     |null: false,                    |
|city                |string      |null: false,                    |
|address             |string      |null: false,                    |
|building            |string      |                                |
|phone_number        |string      |null: false,                    |
|order               |references  |null: false, foreign_key: true  |

### Association
belongs_to :order