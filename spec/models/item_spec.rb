require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    list = FactoryGirl.create(:list)
    @item = FactoryGirl.create(:item, list_id: list.id)
  end

  it { is_expected.to validate_presence_of(:title) }

  it 'sets default scope' do
    expect(List.all.to_sql).to include('status')
  end

  it 'soft deletes the items' do
    expect(@item.status).to eq('active')
    
    @item.delete
    expect(@item.status).to eq('deleted')
  end

  it 'recovers the items' do
    expect(@item.status).to eq('active')
    
    @item.delete
    expect(@item.status).to eq('deleted')

    @item.recover
    expect(@item.status).to eq('active')
  end
end
