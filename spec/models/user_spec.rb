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
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "ニックネームを入力してください"
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "メールアドレスを入力してください"
      end
      it 'emailに＠がないと登録できない' do
        @user.email = 'fsdsfssa'
        @user.valid?
        expect(@user.errors.full_messages).to include "メールアドレスは不正な値です"
      end
      it 'emailが重複するとき登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include "メールアドレスはすでに存在します"
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.password_confirmation = 'aaaaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードを入力してください"
      end
      it 'passwordが五文字以下だと登録できない' do
        @user.password = 'aaaa1'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは6文字以上で入力してください"
                                                      
      end
      it 'passwordが英語のみでは登録できない' do
        @user.password = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = "111111"
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワードは不正な値です"
      end
      it 'passwordとpassword_confirmationが不一致の時登録できない' do
        @user.password = 'abcde1'
        @user.password_confirmation = 'aaaaa2'
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）とパスワードの入力が一致しません"
      end
      it 'password_confirmationが空の時は登録できない' do
        @user.password = 'aaaaa1'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "パスワード（確認用）を入力してください"
      end
      it 'last_nameが空の時登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名字を入力してください"
      end
      it 'first_nameが空の時登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前を入力してください"
      end
      it 'last_name_kanaが空の時登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名字(カナ)を入力してください"
      end
      it 'first_name_kanaが空の時登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "名前(カナ)を入力してください"
      end
      it 'first_nameが漢字・平仮名・カタカナ以外では登録できないこと' do
        @user.first_name = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include "名前は不正な値です"
      end
      it 'last_nameが漢字・平仮名・カタカナ以外では登録できないこと' do
        @user.last_name = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include "名字は不正な値です"
      end
      it 'first_name_kanaが全角カタカナ以外では登録できないこと' do
        @user.first_name_kana = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include "名前(カナ)は不正な値です"
      end
      it 'last_name_kanaが全角カタカナ以外では登録できないこと' do
        @user.last_name_kana = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include "名字(カナ)は不正な値です"
      end
      it 'birthdayが空の時登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "生年月日を入力してください"
      end
    end
  end
end


