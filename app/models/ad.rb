class Ad < ActiveRecord::Base
	validates_format_of :destination_url, :with => URI::regexp(%w(http https))
	validates_format_of :picture_url, :with => URI::regexp(%w(http https))
	validates :description, length: { maximum: 80 }
end
