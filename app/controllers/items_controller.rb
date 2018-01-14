class ItemsController < ApplicationController
  before_action :set_unscoped_item, only: :destroy
  before_action :set_item, only: [:edit, :update]
  before_action :set_list, only: [:new, :create, :edit]

  def new
    render_404 unless @list

    @item = Item.new
  end

  def create
    @item = @list.items.new(item_params)

    process_set(
      @item.save,
      action: :new,
      msg: 'Your item is created'
    )
  end

  def edit

  end

  def update
    process_set(
      @item.update(item_params),
      action: :edit,
      msg: 'Your item is updated'
    )
  end

  def destroy
    process_act @item.destroy, msg: 'Your item is permanent deleted'
  end

  private
  
  def item_params
    params.require(:item).permit(:title)
  end

  def set_unscoped_item
    @item = Item.unscoped.find_by(id: params[:id])

    render_404 unless @item
  end

  def set_item
    @item = Item.find_by(id: params[:id])

    render_404 unless @item
  end

  def set_list
    @list = List.find_by(id: params[:list_id])

    render_404 unless @list
  end
end
