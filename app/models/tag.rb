class Tag < ApplicationRecord
  belongs_to :taggable, polymorphic: true
  validates :name, length: {minimum: 3}
end
