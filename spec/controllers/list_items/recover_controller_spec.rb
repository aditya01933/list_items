require 'rails_helper'

RSpec.describe ListItems::RecoverController, type: :controller do
  before(:each) do
    @list = FactoryGirl.create(:list)
    @item = FactoryGirl.create(:item, list_id: @list.id)
  end

  describe 'PUT #update' do
    it 'should unhide the list and items' do
      @list.delete
      expect(@item.reload.status).to eq('deleted')
      expect(@list.reload.status).to eq('deleted')

      expect{
        put :update, params: {
          id: @list.id,
        }
      }.to change(List,:count).by(1)
      .and change(Item,:count).by(1)
      
      expect(@list.reload.status).to eq('active')
      expect(@item.reload.status).to eq('active')
    end
  end
end