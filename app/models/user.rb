class User < ActiveRecord::Base
  belongs_to :image
  has_many :missions
  has_many :trips, through: :missions

  has_secure_password validations: false

  validates_uniqueness_of :email, :username

  def has_password?
    !!password_digest
  end

  def admin?
    admin
  end

  def delete_image
    Imgur::Image.delete(image)
  end
end
