class ListItems::SoftDeleteController < ApplicationController
  before_action :set_unscoped_list

  def destroy
    process_act @list.delete, msg: 'Your list is soft deleted'
  end

  private

  def set_unscoped_list
    @list = List.unscoped.find_by(id: params[:id])

    render_404 unless @list
  end
end