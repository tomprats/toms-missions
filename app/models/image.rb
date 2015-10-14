class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  has_many :favorites, dependent: :destroy

  before_destroy :delete_image

  def self.with_imgur(options)
    trip_id = options.delete(:trip_id)
    user_id = options.delete(:user_id)
    image = Imgur::Image.create(options)
    create(
      imgur_id: image["id"],
      link: image["link"],
      trip_id: trip_id,
      user_id: user_id
    )
  end

  def self.default
    OpenStruct.new(thumbnail: "logo-square-t.jpg", destroy: false)
  end

  def thumbnail
    url "b"
  end

  def large
    url "l"
  end

  def url(size)
    array = link.split(".")
    array[array.size - 2] << size
    array.join(".")
  end

  private
  def delete_image
    Imgur::Image.delete(self.imgur_id)
  rescue
    puts "Probably already gone"
  end
end
