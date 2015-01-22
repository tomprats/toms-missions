class Album < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip

  before_destroy :delete_album

  def self.with_imgur(options)
    trip_id = options.delete(:trip_id)
    user_id = options.delete(:user_id)
    album = Imgur::Album.create(options)
    create(
      id: album["id"],
      link: album["link"],
      trip_id: trip_id,
      user_id: user_id
    )
  end

  private
  def delete_album
    Imgur::Album.delete(self.imgur_id)
  end
end
