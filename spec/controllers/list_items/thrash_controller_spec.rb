require 'rails_helper'

RSpec.describe ListItems::ThrashController, type: :controller do
  before(:each) do
    @list = FactoryGirl.create(:list)
    @item = FactoryGirl.create(:item, list_id: @list.id)
  end

  describe 'GET #index' do
    it 'should return only deleted lists' do
      list2 = FactoryGirl.create(:list, status: 'deleted') 
      
      get :index

      expect(assigns(:all_list_items)).to eq([list2])
    end
  end
end
