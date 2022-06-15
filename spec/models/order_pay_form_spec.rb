require 'rails_helper'

RSpec.describe OrderPayForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_pay_form = FactoryBot.build(:order_pay_form, user_id: user.id, item_id: item.id)
    sleep 2 # 2秒待機 FactoryBotのインスタンス生成の記述を増やしたらエラー発生。負荷がかかって処理が止まった為、その対策。
  end

  describe '商品購入機能' do
    context 'うまくいくとき' do
      it '全ての項目が入力されていれば登録できる' do
        expect(@order_pay_form).to be_valid
      end
      it '建物名が空でも登録できる' do
        @order_pay_form.building = ''
        expect(@order_pay_form).to be_valid
      end
    end

    context 'うまくいかないとき' do
      it '郵便番号がないと購入出来ない' do
        @order_pay_form.postal_code = ''
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号は「3桁ハイフン4桁」でないと購入出来ない' do
        @order_pay_form.postal_code = '12-34567'
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it '郵便番号はハイフンがないと購入出来ない' do
        @order_pay_form.postal_code = '1234567'
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it '郵便番号は半角数字でないと購入出来ない' do
        @order_pay_form.postal_code = '１２３-１２３４'
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
      end
      it '都道府県がないと購入出来ない' do
        @order_pay_form.prefecture_id = 1
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村がないと購入出来ない' do
        @order_pay_form.city = ''
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("City can't be blank")
      end
      it '番地がないと購入出来ない' do
        @order_pay_form.addresses = ''
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Addresses can't be blank")
      end
      it '電話番号がないと購入出来ない' do
        @order_pay_form.phone_number = ''
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が9桁以下だと購入出来ない' do
        @order_pay_form.phone_number = '090123456'
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include('Phone number is invalid. Enter it as follows (e.g. 09012345678)')
      end
      it '電話番号が12桁以上だと購入出来ない' do
        @order_pay_form.phone_number = '090123456789'
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include('Phone number is invalid. Enter it as follows (e.g. 09012345678)')
      end
      it '電話番号が半角数値のみでないと購入出来ない' do
        @order_pay_form.phone_number = '０９０１２３４５６７８'
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include('Phone number is invalid. Input only number')
      end
      it 'tokenが空では購入出来ない' do
        @order_pay_form.token = nil
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Token can't be blank")
      end
      it 'userが紐付いていなければ購入できない' do
        @order_pay_form.user_id = nil
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("User can't be blank")
      end
      it 'itemが紐付いていなければ購入できない' do
        @order_pay_form.item_id = nil
        @order_pay_form.valid?
        expect(@order_pay_form.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
