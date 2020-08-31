class Character < ApplicationRecord
  validates_presence_of :name
  validates_uniqueness_of :name, scope: :user

  belongs_to :user
end
