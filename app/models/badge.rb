class Badge < ActiveRecord::Base
  has_many :achievements, dependent: :destroy
  has_many :users, through: :achievements
end
