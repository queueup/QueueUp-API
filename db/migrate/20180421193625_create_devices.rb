class CreateDevices < ActiveRecord::Migration[5.1]
  def change
    create_table :devices, id: :uuid do |t|
      t.string :player_id
      t.belongs_to :user, foreign_key: true, type: :uuid

      t.timestamps
    end
  end
end
