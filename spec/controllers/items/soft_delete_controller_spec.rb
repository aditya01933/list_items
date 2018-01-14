require 'rails_helper'

RSpec.describe Items::SoftDeleteController, type: :controller do
  before(:each) do
    @list = FactoryGirl.create(:list)
    @item = FactoryGirl.create(:item, list_id: @list.id)
  end

  describe 'DELETE #soft_delete' do
    it 'should hide the item' do
      expect{
        delete :destroy, params: {
          list_id: @list.id,
          id: @item.id
        }
      }.to change(Item,:count).by(-1)
      
      expect(@item.reload.status).to eq('deleted')
    end
  end
end