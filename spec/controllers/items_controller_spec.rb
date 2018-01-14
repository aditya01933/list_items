require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  before(:each) do
    @list = FactoryGirl.create(:list)
    @item = FactoryGirl.create(:item, list_id: @list.id)
  end
  
  describe 'GET #edit' do
    it 'renders the :edit template' do
      get :edit, params: { list_id: @list.id, id: @item.id }

      expect(response.status).to eq 200
      expect(response).to render_template :edit
    end

    it 'return 404 if list or item not found' do
      get :edit, params: { list_id: 'fake_id', id: 'fake_id' }

      expect(response.status).to eq 404
    end
  end
  
  describe 'GET #new' do
    it 'renders the :new template' do
      get :new, params: { list_id: @list.id }

      expect(response.status).to eq 200
      expect(response).to render_template :new
    end

    it 'return 404 if list not found' do
      get :new, params: { list_id: 'fake_id' }

      expect(response.status).to eq 404
    end
  end

  describe 'PUT update' do
    it 'changes @item attributes' do
      put :update, params:{ 
        list_id: @list.id,
        id: @item.id,
        item: FactoryGirl.attributes_for(:item, title: 'new-one')
      }

      @item.reload
      expect(@item.title).to eq('new-one')
    end
  end
  
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new item in the database' do
        expect{
          post :create,
            params: {item: FactoryGirl.attributes_for(:list), list_id: @list.id}
        }.to change(Item,:count).by(1)
      end
    end
    
    context 'with invalid attributes' do
      it 'does not save the new item in the database' do
        expect{
          post :create,
            params: {item: {title: nil}, list_id: @list.id}
        }.to change(Item,:count).by(0)
      end

      it 're-renders the :new template' do
        post :create,
          params: {item: {title: nil}, list_id: @list.id}

        expect(response).to render_template :new
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete the item' do
      expect{
        delete :destroy, params: {
          list_id: @list.id,
          id: @item.id
        }
      }.to change(Item,:count).by(-1)

      expect{ @item.reload }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
