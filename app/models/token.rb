class Token < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :uid

  before_validation :set_uid, on: :create

  def to_param
    uid
  end

  private
  def set_uid
    self.uid ||= SecureRandom.uuid
  end
end
