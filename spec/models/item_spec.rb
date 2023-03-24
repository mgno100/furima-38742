require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end
    
    context '出品した商品が保存できるとき' do
    it 'image、item_name、item_info、item_price、category_id、sales_status_id、shipping_fee_status_id、prefecture_id、scheduled_delivery_idが存在すれば登録できる' do
      expect(@item).to be_valid
    end
    
    it 'category_idが1以外(未選択)であれば保存できる' do
      @item.category_id = '3'
      expect(@item).to be_valid
    end

    it 'sales_status_idが1以外(未選択)であれば保存できる' do
      @item.sales_status_id = '3'
      expect(@item).to be_valid
    end

    it 'shipping_fee_status_idが1以外(未選択)であれば保存できる' do
      @item.shipping_fee_status_id = '3'
      expect(@item).to be_valid
    end

    it 'prefecture_idが1以外(未選択)であれば保存できる' do
      @item.prefecture_id = '3'
      expect(@item).to be_valid
    end

    it 'scheduled_delivery_idが1以外(未選択)であれば保存できる' do
      @item.scheduled_delivery_id = '3'
      expect(@item).to be_valid
    end

    it 'item_priceが、300~9999999の間であれば保存できる' do
      @item.item_price = "5000"
      expect(@item).to be_valid
    end

    context '出品した商品が保存できないとき' do
      it 'imageが存在しない場合保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'item_nameが空では保存できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end

      it 'item_infoが空では保存できない' do
        @item.item_info = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item info can't be blank")
      end
      
      it 'category_idが空では保存できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it 'category_idが1の場合(未選択)では保存できない' do
        @item.category_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Select")
      end

      it 'sales_status_idが空では保存できない' do
        @item.sales_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status can't be blank")
      end
      it 'sales_status_idが1の場合(未選択)では保存できない' do
        @item.sales_status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Sales status Select")
      end

      it 'shipping_fee_status_idが空では保存できない' do
        @item.shipping_fee_status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status can't be blank")
      end
      it 'shipping_fee_status_idが1の場合(未選択)では保存できない' do
        @item.shipping_fee_status_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping fee status Select")
      end

      it 'prefecture_idが空では保存できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'prefecture_idが1の場合(未選択)では保存できない' do
        @item.prefecture_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture Select")
      end

      it 'scheduled_delivery_idが空では保存できない' do
        @item.scheduled_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery can't be blank")
      end
      it 'scheduled_delivery_idが1の場合(未選択)では保存できない' do
        @item.scheduled_delivery_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("Scheduled delivery Select")
      end

      it 'item_priceが空では保存できない' do
        @item.item_price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price can't be blank")
      end
      it 'item_priceが300未満の場合は保存できない' do
        @item.item_price = '100'
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price is out of setting range")
      end
      it 'item_priceが9999999以上の場合は保存できない' do
        @item.item_price = '100000000'
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price is out of setting range")
      end
      it 'item_priceが全角の場合は保存できない' do
        @item.item_price = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Item price is invalid. Input half-width characters")
      end
      it 'userが紐付いていない場合は保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
    end
  end
end
