class Image < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip

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

  private
  def delete_image
    Imgur::Image.delete(self.imgur_id)
  rescue
    puts "Probably already gone"
  end
end
