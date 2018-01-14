require 'rails_helper'

RSpec.describe ListItemsController, type: :controller do
  before(:each) do
    @list = FactoryGirl.create(:list)
    @item = FactoryGirl.create(:item, list_id: @list.id)
  end

  describe 'GET #index' do
    it 'should return only active lists' do
      list2 = FactoryGirl.create(:list, status: 'deleted') 
      
      get :index

      expect(assigns(:all_list_items)).to eq([@list])
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the list and items' do
      expect{
        delete :destroy, params: {
          id: @list.id,
        }
      }.to change(List,:count).by(-1)
      .and change(Item, :count).by(-1)

      expect{ @item.reload }.to raise_exception(ActiveRecord::RecordNotFound)
      expect{ @list.reload }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
