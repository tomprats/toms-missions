class User < ActiveRecord::Base
  belongs_to :image, dependent: :destroy
  has_many :images
  has_many :missions
  has_many :trips, through: :missions

  has_secure_password validations: true

  validates_presence_of :name, :email, :username
  validates_uniqueness_of :email, :username

  def has_password?
    !!password_digest
  end

  def admin?
    admin
  end

  def update_profile_picture(blob)
    profile = Image.with_imgur(
      title: username,
      image: blob,
      album_id: Imgur::Album.profile["id"],
      user_id: id
    )
    image.destroy if image
    update(image_id: profile.id)
  end
end