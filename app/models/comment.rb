class Comment < ApplicationRecord
  belongs_to :citicize
  validates :content, presence: true
end
