class Mine < ApplicationRecord
  belongs_to :board

  validates :row, :col, presence: true
end
