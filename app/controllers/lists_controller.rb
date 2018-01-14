class ListsController < ApplicationController
  before_action :set_list, only: [:update, :edit]

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)

    process_set(
      @list.save,
      action: :new,
      msg: 'Your list is created'
    )
  end

  def edit

  end

  def update
    process_set(
      @list.update(list_params),
      action: :edit,
      msg: 'Your list is updated'
    )
  end

  private
  
  def list_params
    params.require(:list).permit(:title)
  end

  def set_list
    @list = List.find_by(id: params[:id])

    render_404 unless @list
  end
end
