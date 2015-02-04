class Album < ActiveRecord::Base
  before_destroy :delete_album

  def self.with_imgur(options)
    album = Imgur::Album.create(options)
    create(imgur_id: album["id"])
  end

  def link
    "https://imgur.com/a/#{imgur_id}"
  end

  def add_images(image_ids)
    Imgur::Album.add_images(imgur_id, image_ids)
  end

  private
  def delete_album
    Imgur::Album.delete(self.imgur_id)
  end
end
