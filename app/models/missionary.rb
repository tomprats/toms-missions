class Missionary < ActiveRecord::Base
  has_secure_password validations: false

  validates_uniqueness_of :email, :username
end
