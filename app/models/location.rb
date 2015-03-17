class Location < ActiveRecord::Base
  belongs_to :tablet, :dependent => :destroy

  validates :a, presence: true
  validates :b, presence: true
end
