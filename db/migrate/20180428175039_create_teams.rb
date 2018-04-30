class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.integer :size
      t.string :players

      t.timestamps
    end
  end
end
