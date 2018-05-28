class Estimate < ApplicationRecord
  belongs_to :user
  belongs_to :citicize
  validates :rate, numericality: { only_integer: true, less_than_or_equal_to: 5, greater_than_or_equal_to: 1}
end
