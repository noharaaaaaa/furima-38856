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
|category            |string      |null: false,                    |
|status              |string      |null: false,                    |
|delivary_fee        |string      |null: false,                    |
|prefecture          |string      |null: false,                    |
|days                |string      |null: false,                    |
|price               |string      |null: false,                    |
|user                |reference   |foreign_key: true               |

### Association
has_one_attached :image
has_one :order
belongs_to :user

## ordersテーブル
| Column             | Type       | Options                        |
|item                |reference   |foreign_key: true               |
|user                |reference   |foreign_key: true               |

### Association
belongs_to :user
belongs_to :item
has_one :address

## addresses
| Column             | Type       | Options                        |
|post_number         |string      |null: false,                    |
|prefecture          |integer     |null: false,                    |
|city                |string      |null: false,                    |
|address             |string      |null: false,                    |
|building            |string      |                                |
|phone_number        |string      |null: false,                    |

### Association
belongs_to :order