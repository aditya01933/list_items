require 'rails_helper'

RSpec.describe ListItems::SoftDeleteController, type: :controller do
  before(:each) do
    @list = FactoryGirl.create(:list)
    @item = FactoryGirl.create(:item, list_id: @list.id)
  end

  describe 'DELETE #destroy' do
    it 'should hide the list and items' do
      expect{
        delete :destroy, params: {
          id: @list.id,
        }
      }.to change(List, :count).by(-1)
      .and change(Item, :count).by(-1)
      
      expect(@list.reload.status).to eq('deleted')
      expect(@item.reload.status).to eq('deleted')
    end
  end
end