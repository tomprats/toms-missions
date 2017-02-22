class Trip < ActiveRecord::Base
  has_many :missions
  has_many :users, through: :missions
  has_many :images
  has_many :resources

  belongs_to :album, dependent: :destroy
  has_many :albums, through: :missions

  validates_presence_of :uid, :country, :start_date, :end_date
  validates_uniqueness_of :uid
  validates_uniqueness_of :country, scope: [:start_date, :end_date]

  accepts_nested_attributes_for :users, :resources

  before_validation :set_uid, on: :create
  after_create :create_album

  def self.default_scope
    order(start_date: :desc)
  end

  def name
    "#{country} #{start_date.strftime("%B")} #{start_date.year}"
  end

  def date_range
    "#{start_date.strftime("%m/%d/%Y")} to #{end_date.strftime("%m/%d/%Y")}"
  end

  def cover
    images.first || Image.default
  end

  def to_param
    uid
  end

  def description
    saved = super
    saved.blank? ? default_description : saved
  end

  def default_description
    tmp = "An exciting trip to #{country}!"
    tmp += " A great time with #{random_users.collect(&:name).join(" and ")}!" if random_users.count >= 2
    tmp
  end

  def random_users
    users.sample(2)
  end

  private
  def set_uid
    self.uid = [country.first(4), start_date.strftime("%b"), start_date.year].join("-").downcase
  end

  def create_album
    album = Album.with_imgur(title: name)
    update(album_id: album["id"])
  end
end
