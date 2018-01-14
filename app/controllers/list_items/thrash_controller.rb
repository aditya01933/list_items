class ListItems::ThrashController < ApplicationController
  def index
    @all_list_items = List.includes(:deleted_items).only_deleted
  end
end