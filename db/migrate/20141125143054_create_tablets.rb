class CreateTablets < ActiveRecord::Migration
  def change
    create_table :tablets do |t|
      t.string :uuid
      t.string :flash_token
      t.string :salt
      t.timestamp :flash_date
      t.references :user, index: true

      t.timestamps
    end
  end
end
