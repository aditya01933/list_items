class Items::RecoverController < ApplicationController
  before_action :set_unscoped_item

  def update
    process_act @item.recover, msg: 'Your item is recovered'
  end

  private

  def set_unscoped_item
    @item = Item.unscoped.find_by(id: params[:id])

    render_404 unless @item
  end
end
