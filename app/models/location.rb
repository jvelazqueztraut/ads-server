class Location < ActiveRecord::Base
  belongs_to :tablet, :dependent => :destroy

  validates :latitude, presence: true
  validates :longitude, presence: true
end
