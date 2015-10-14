class Trip < ActiveRecord::Base
  has_many :missions
  has_many :users, through: :missions
  has_many :images

  belongs_to :album, dependent: :destroy
  has_many :albums, through: :missions

  validates_presence_of :country, :start_date, :end_date
  validates_uniqueness_of :country, scope: [:start_date, :end_date]

  accepts_nested_attributes_for :users

  after_create :create_album

  def name
    "#{country} #{start_date.strftime("%B")} #{start_date.year}"
  end

  def date_range
    "#{start_date.strftime("%m/%d/%Y")} to #{end_date.strftime("%m/%d/%Y")}"
  end

  def cover
    images.first || Image.default
  end

  private
  def create_album
    album = Album.with_imgur(title: name)
    update(album_id: album["id"])
  end
end
