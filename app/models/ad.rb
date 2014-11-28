class Ad < ActiveRecord::Base
	validates :destination_url, :url => true
	validates :picture_url, :url => true
	validates :description, length: { maximum: 80 }
end
