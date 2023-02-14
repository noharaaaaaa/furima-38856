require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe '商品購入機能' do
    context '購入できる場合' do
      it '各項目が正しく記入されていれば購入できる' do
        expect(@order_address).to be_valid
      end

      it 'buildingが空欄でも購入できる' do
        @order_address.building = ''
        expect(@order_address).to be_valid
      end
    end

    context '購入できない場合' do
      it 'post_numberが空だと購入できない' do
        @order_address.post_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post number can't be blank")
      end

      it 'post_numberがハイフンが無いと購入できない' do
        @order_address.post_number = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post number is invalid")
      end

      it 'post_numberに全角があると購入できない' do
        @order_address.post_number = '123ー4567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post number is invalid")
      end

      it 'post_numberの前半が3桁以外だと購入できない' do
        @order_address.post_number = '12-3456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post number is invalid")
       end

      it 'post_numberの後半が4桁以外だと購入できない' do
        @order_address.post_number = '123-456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post number is invalid")
      end

      it 'post_numberに数字以外を含むと購入できない' do
        @order_address.post_number = '123-123A'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Post number is invalid")
      end

      it 'prefectureが1だと購入できない' do
        @order_address.prefecture_id = '1'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空だと購入できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空だと購入できない' do
        @order_address.address = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと購入できない' do
        @order_address.phone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下だと購入できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberが12桁以上と購入できない' do
        @order_address.phone_number = '123456789012'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberに全角文字を含むと購入できない' do
        @order_address.phone_number = '1234567890１'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'phone_numberに数字以外を含むと購入できない' do
        @order_address.phone_number = '1234567890A'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'tokenが空だと購入できない' do
        @order_address.token = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていないと購入できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと購入できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
