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

  def create_profile_picture(blob)
    profile = Image.with_imgur(
      title: name,
      image: blob,
      album_id: Imgur::Album.profile["id"],
      user_id: id
    )
    image.destroy if image
    update(image_id: profile.id)
  end
end
