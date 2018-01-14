require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  before(:each) do
    @list = FactoryGirl.create(:list)
  end
  
  describe 'GET #edit' do
    it 'renders the :edit template' do
      get :edit, params: { id: @list.id }

      expect(response.status).to eq 200
      expect(response).to render_template :edit
    end

    it 'return 404 if list not found' do
      get :edit, params: {id: 'fake_id' }

      expect(response.status).to eq 404
    end
  end
  
  describe 'GET #new' do
    it 'renders the :new template' do
      get :new

      expect(response.status).to eq 200
      expect(response).to render_template :new
    end
  end

  describe 'PUT update' do
    it 'changes @list attributes' do
      put :update, params:{ 
        id: @list.id,
        list: FactoryGirl.attributes_for(:list, title: 'new-one')
      }

      @list.reload
      expect(@list.title).to eq('new-one')
    end
  end
  
  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new list in the database' do
        expect{
          post :create,
            params: {list: FactoryGirl.attributes_for(:list)}
        }.to change(List,:count).by(1)
      end
    end
    
    context 'with invalid attributes' do
      it 'does not save the new list in the database' do
        expect{
          post :create,
            params: {list: {title: nil}}
        }.to change(List,:count).by(0)
      end

      it 're-renders the :new template' do
        post :create,
          params: {list: {title: nil}}

        expect(response).to render_template :new
      end
    end
  end
end
