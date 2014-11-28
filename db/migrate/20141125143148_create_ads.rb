class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.string :picture_url
      t.string :destination_url
      t.text :description

      t.timestamps
    end
  end
end
