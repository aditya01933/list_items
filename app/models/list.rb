class List < ApplicationRecord
  include SoftDeletable

  validates :title, presence: true

  soft_delete :dependents, [:items]

  has_many :items, dependent: :destroy

  has_many :deleted_items, -> { where(status: 'deleted') }, class_name: 'Item'
end
