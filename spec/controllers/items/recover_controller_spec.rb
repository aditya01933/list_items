require 'rails_helper'

RSpec.describe Items::RecoverController, type: :controller do
  before(:each) do
    @list = FactoryGirl.create(:list)
    @item = FactoryGirl.create(:item, list_id: @list.id)
  end

  describe 'PUT #update' do
    it 'should unhide the item' do
      @item.delete
      expect(@item.reload.status).to eq('deleted')

      expect{
        put :update, params: {
          list_id: @list.id,
          id: @item.id
        }
      }.to change(Item,:count).by(1)
      
      expect(@item.reload.status).to eq('active')
    end
  end
end