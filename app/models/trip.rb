class Trip < ActiveRecord::Base
  has_many :missions
  has_many :users, through: :missions

  belongs_to :album
  has_many :albums
end
