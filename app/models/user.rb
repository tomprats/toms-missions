class User < ActiveRecord::Base
  belongs_to :image, dependent: :destroy
  has_many :tokens
  has_many :images
  has_many :missions
  has_many :trips, through: :missions
  has_many :favorites, dependent: :destroy
  has_many :favorite_images, through: :favorites, source: :image

  validates_presence_of :name, :email, :username
  validates_uniqueness_of :email, :username
  validates_format_of :email, with: /@/
  validates_format_of :username, with: /\A[a-z0-9-]+\z/, message: "can only contain letters, numbers, and dashes"

  has_secure_password validations: true

  before_validation :format
  after_create :notify_admin

  scope :admin, -> { where(admin: "super") }

  def self.default_scope
    order(images_count: :desc, name: :asc)
  end

  def has_password?
    !!password_digest
  end

  def admin?
    admin == "super"
  end

  def token
    tokens.first_or_create
  end

  def image
    image_id ? super : Image.default
  end

  def update_profile_picture(blob)
    profile = Image.with_imgur(
      title: username,
      image: blob,
      album_id: Imgur::Album.profile["id"],
      user_id: id
    )
    image.destroy if image_id
    update(image_id: profile.id)
  end

  def to_param
    username
  end

  private
  def format
    self.username = username.strip.downcase if username
    self.email = email.strip.downcase if email
  end

  def notify_admin
    User.admin.each { |admin| AdminMailer.new_user(admin, self).deliver_now }
  end
end
