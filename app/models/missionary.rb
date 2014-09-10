class Missionary < ActiveRecord::Base
  has_secure_password validations: false

  validates_uniqueness_of :email, :username

  def has_password?
    !!password_digest
  end

  def admin?
    admin
  end
end
