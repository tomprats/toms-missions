class Mission < ActiveRecord::Base
  belongs_to :user
  belongs_to :trip
  belongs_to :album, dependent: :destroy

  after_create :create_album
  before_destroy :destroy_images

  def images
    Image.where(user_id: user_id, trip_id: trip_id)
  end

  def cover
    images.first || Image.default
  end

  private
  def create_album
    album = Album.with_imgur(title: "#{user.name} - #{trip.name}")
    update(album_id: album["id"])
  end

  def destroy_images
    images.each { |image| image.destroy }
  end
end
