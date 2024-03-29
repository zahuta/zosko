class Category < ActiveRecord::Base
  validates :name, presence: true

  has_and_belongs_to_many :tasks

  has_many :skills, dependent: :destroy
  has_many :users, through: :skills
end
