require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できる場合' do
      it '各項目が全て正しく記入されていれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '出品できない場合' do

      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end

      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it 'descriptionが空では出品できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'category_idの値が---では出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it 'status_idの値が---では出品できない' do
        @item.status_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end

      it 'delivery_fee_idの値が---では出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料区分を入力してください")
      end

      it 'prefecture_idの値が---では出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元を入力してください")
      end

      it 'daysの値が---では出品できない' do
        @item.days_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end

      it 'priceが299以下では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("価格の設定を修正してください")
      end

      it 'priceが10,000,000以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("価格の設定を修正してください")
      end

      #追加テストコード
      it 'priseに半角数字以外が含まれている時出品できない' do
        @item.price = '10000０'
        @item.valid?
        expect(@item.errors.full_messages).to include("価格の設定を修正してください")
      end

      it 'userが紐づいていないと出品できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("ユーザー情報を入力してください")
      end
    end
  end
end
