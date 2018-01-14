class Item < ApplicationRecord
  include SoftDeletable

  validates :title, presence: true

  belongs_to :list, -> { unscope(where: :status) }, touch: true
end
