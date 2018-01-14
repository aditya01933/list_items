class Items::SoftDeleteController < ApplicationController
  before_action :set_unscoped_item

  def destroy
    process_act @item.delete, msg: 'Your item is deleted'
  end

  private

  def set_unscoped_item
    @item = Item.unscoped.find_by(id: params[:id])

    render_404 unless @item
  end
end