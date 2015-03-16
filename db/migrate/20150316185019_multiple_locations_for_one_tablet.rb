class MultipleLocationsForOneTablet < ActiveRecord::Migration
  def change
  		add_column :locations, :accuracy, :float
  		add_column :locations, :speed, :float
  		add_column :locations, :altitude, :float
  		add_column :locations, :is_gps_provider, :boolean
  end
end
