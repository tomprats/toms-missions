class Resource < ActiveRecord::Base
  belongs_to :trip

  validates_presence_of :text
  validates_format_of :url, with: /\Ahttp/, message: "should contain http(s)"
end
