class ListItemsController < ApplicationController
  before_action :set_unscoped_list, only: :destroy

  def index
    @all_list_items = List.includes(:items).all
  end

  def destroy
    process_act @list.destroy, msg:'Your list and items are permanent deleted'
  end

  private

  def set_unscoped_list
    @list = List.unscoped.find_by(id: params[:id])

    render_404 unless @list
  end
end