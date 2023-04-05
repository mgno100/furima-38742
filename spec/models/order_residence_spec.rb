require 'rails_helper'

RSpec.describe OrderResidence, type: :model do
  describe '配送先の住所の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_residence = FactoryBot.build(:order_residence, user_id: user.id, item_id: item.id)
    end

    context '配送先の住所が保存できるとき' do
      it 'postal_code、prefecture_id、city、addresses、building、phone_number、user_id、item_id、tokenが存在すれば保存できる' do
        expect(@order_residence).to be_valid
      end

      it 'prefecture_idが1以外(未選択以外)であれば保存できる' do
        @order_residence.prefecture_id = '3'
        expect(@order_residence).to be_valid
      end

      it 'buildingは空でも保存できる' do
        @order_residence.building = ''
        expect(@order_residence).to be_valid
      end

      it 'postal_codeが「3桁ハイフン4桁」かつ半角文字列であれば保存できる' do
        @order_residence.postal_code = '123-4567'
        expect(@order_residence).to be_valid
      end

      it 'phone_numberが「10桁以上11桁以内」かつ半角数値であれば保存できる' do
        @order_residence.phone_number = '01234567891'
        expect(@order_residence).to be_valid
      end

      context '配送先の住所が保存できないとき' do
        it 'postal_codeが空では保存できない' do
          @order_residence.postal_code = ''
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include("Postal code can't be blank")
        end
        it 'postal_codeにハイフンがない場合は保存できない' do
          @order_residence.postal_code = '1234567'
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
        end
        it 'postal_codeが「3桁ハイフン4桁」であっても全角文字列の場合は保存できない' do
          @order_residence.postal_code = '１２３ー４５６７'
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include('Postal code is invalid. Enter it as follows (e.g. 123-4567)')
        end

        it 'prefecture_idが空では保存できない' do
          @order_residence.prefecture_id = ''
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include("Prefecture can't be blank")
        end
        it 'prefecture_idが1の場合(未選択)では保存できない' do
          @order_residence.prefecture_id = '1'
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include("Prefecture can't be blank")
        end

        it 'cityが空では保存できない' do
          @order_residence.city = ''
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include("City can't be blank")
        end

        it 'addressesが空では保存できない' do
          @order_residence.addresses = ''
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include("Addresses can't be blank")
        end

        it 'phone_numberが空では保存できない' do
          @order_residence.phone_number = ''
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include("Phone number can't be blank")
        end
        it 'phone_numberが10桁未満の場合は保存できない' do
          @order_residence.phone_number = '012345678'
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include('Phone number is invalid. Input only number')
        end
        it 'phone_numberが12桁以上の場合は保存できない' do
          @order_residence.phone_number = '012345678901'
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include('Phone number is invalid. Input only number')
        end
        it 'phone_numberに「ハイフン」がある場合は保存できない' do
          @order_residence.phone_number = '012-3456-7891'
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include('Phone number is invalid. Input only number')
        end
        it 'phone_numberが全角の場合は保存できない' do
          @order_residence.phone_number = '０１２３４５６７８９１'
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include('Phone number is invalid. Input only number')
        end

        it 'userが紐づいていない場合は保存できない' do
          @order_residence.user_id = nil
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include("User can't be blank")
        end

        it 'itemが紐づいていない場合は保存できない' do
          @order_residence.item_id = nil
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include("Item can't be blank")
        end

        it 'tokenが空では保存できない' do
          @order_residence.token = nil
          @order_residence.valid?
          expect(@order_residence.errors.full_messages).to include("Token can't be blank")
        end
      end
    end
  end
end
