require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '各項目が全て正しく記入されていれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'test.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは6文字以上で入力してください")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは128文字以内で入力してください")
      end

      it 'passwordが英字だけでは登録できない' do
        @user.password = 'abcxyz'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'passwordが数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（姓）を入力してください")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（名）を入力してください")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カナ）を入力してください")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名（カナ）を入力してください")
      end

      it 'date_of_birthが空では登録できない' do
        @user.date_of_birth = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end

      #テスト追加分
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = '123abcあ'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードは不正な値です")
      end

      it '姓（全角）に半角文字が含まれていると登録できない' do
        @user.last_name = '山田a'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（姓）は不正な値です")
      end
      
      it '名（全角）に半角文字が含まれていると登録できない' do
        @user.first_name = '太郎a'
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（名）は不正な値です")
      end

      it '姓（カナ）にカタカナ以外の文字（平仮名）が含まれていると登録できない' do
        @user.last_name_kana = 'ヤマダや'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カナ）は不正な値です")
      end
      it '姓（カナ）にカタカナ以外の文字（漢字）が含まれていると登録できない' do
        @user.last_name_kana = 'ヤマダ山'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カナ）は不正な値です")
      end
      it '姓（カナ）にカタカナ以外の文字（英数字）が含まれていると登録できない' do
        @user.last_name_kana = 'ヤマダy'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カナ）は不正な値です")
      end
      it '姓（カナ）にカタカナ以外の文字（記号）が含まれていると登録できない' do
        @user.last_name_kana = 'ヤマダ/'
        @user.valid?
        expect(@user.errors.full_messages).to include("姓（カナ）は不正な値です")
      end

      it '名（カナ）にカタカナ以外の文字（平仮名）が含まれていると登録できない' do
        @user.first_name_kana = 'タロウた'
        @user.valid?
        expect(@user.errors.full_messages).to include("名（カナ）は不正な値です")
      end
      it '名（カナ）にカタカナ以外の文字（漢字）が含まれていると登録できない' do
        @user.first_name_kana = 'タロウ太'
        @user.valid?
        expect(@user.errors.full_messages).to include("名（カナ）は不正な値です")
      end
      it '名（カナ）にカタカナ以外の文字（英数字）が含まれていると登録できない' do
        @user.first_name_kana = 'タロウt'
        @user.valid?
        expect(@user.errors.full_messages).to include("名（カナ）は不正な値です")
      end
      it '名（カナ）にカタカナ以外の文字（記号）が含まれていると登録できない' do
        @user.first_name_kana = 'タロウ/'
        @user.valid?
        expect(@user.errors.full_messages).to include("名（カナ）は不正な値です")
      end
    end
  end
end