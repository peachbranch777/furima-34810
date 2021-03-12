require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe '新規ユーザー登録' do
    context 'ユーザー登録できる時' do
      it 'email, password, nickname, first_name, last_name, first_name_kana, last_name_kana, birthday全て存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上で英数字どちらもあれば登録できる' do
        expect(@user).to be_valid
      end
      it 'last_nameとfirst_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる' do
        expect(@user).to be_valid
      end
      it 'last_name_kanaとfirst_name_kanaが全角（カタカナ）であれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context 'ユーザー登録できない時' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Nickname can't be blank"
      end
      it 'emailが空では登録できない' do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Email can't be blank"
      end
      it 'emailに＠がないと登録できない' do
        @user.email = "fsdsfssa"
        @user.valid?
        expect(@user.errors.full_messages).to include "Email is invalid"
      end
      it 'emailが重複するとき登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Email has already been taken"
      end
      it 'passwordが空では登録できない' do
        @user.password = ""
        @user.password_confirmation = "aaaaa1"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank", "Password is too short (minimum is 6 characters)", "Password is invalid", "Password confirmation doesn't match Password"
      end
      it 'passwordが五文字以下だと登録できない' do
        @user.password = "aaaa1"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password", "Password is too short (minimum is 6 characters)", "Password is invalid"
      end
      it 'passwordが英数字どちらもないと登録できない' do
        @user.password = 111111
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password", "Password is invalid"
      end
      it 'passwordとpassword_confirmationが不一致の時登録できない' do
        @user.password = "abcde1"
        @user.password_confirmation = "aaaaa2"
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end
      it 'password_confirmationが空の時は登録できない' do
        @user.password = "aaaaa1"
        @user.password_confirmation = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password", "Password confirmation is too short (minimum is 6 characters)", "Password confirmation is invalid"
      end
      it 'last_nameが空の時登録できない' do
        @user.last_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name can't be blank", "Last name is invalid"
      end
      it 'first_nameが空の時登録できない' do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "First name can't be blank", "First name is invalid"
      end
      it 'last_name_kanaが空の時登録できない' do
        @user.last_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Last name kana can't be blank", "Last name kana is invalid"
      end
      it 'first_name_kanaが空の時登録できない' do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "First name kana can't be blank", "First name kana is invalid"
      end
      it 'birthdayが空の時登録できない' do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include "Birthday can't be blank"
      end
    end
  end
end
