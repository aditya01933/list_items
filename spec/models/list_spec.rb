require 'rails_helper'

RSpec.describe List, type: :model do
  before(:each) do
    @list = FactoryGirl.create(:list)
    @item = FactoryGirl.create(:item, list_id: @list.id)
  end

  it { is_expected.to validate_presence_of(:title) }

  it 'sets default scope' do
    expect(List.all.to_sql).to include('status')
  end

  it 'soft deletes the list and items' do
    expect(@list.status).to eq('active')
    expect(@list.items.select{|l| l.status == 'active' }.count)
      .to eq @list.items.count
    
    @list.delete
    expect(@list.reload.status).to eq('deleted')

    expect(@list.reload.items.select{|l| l.status == 'deleted' }.count)
      .to eq @list.items.count
    
    expect(@item.reload.status).to eq('deleted')
  end

  it 'recovers the list and items' do
    @item.delete
    expect(@item.reload.status).to eq('deleted')

    @item.recover
    expect(@item.reload.status).to eq('active')
    expect(@list.reload.items.select{|l| l.status == 'active' }.count)
      .to eq @list.items.count
  end
end
