class ListItems::RecoverController < ApplicationController
  before_action :set_unscoped_list

  def update
    process_act @list.recover, msg: 'Your list is recovered'
  end

  private

  def set_unscoped_list
    @list = List.unscoped.find_by(id: params[:id])

    render_404 unless @list
  end
end