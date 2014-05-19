class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.references :user, index: true
      t.references :category, index: true
      t.integer :points
      t.integer :level

      t.timestamps
    end
  end
end
