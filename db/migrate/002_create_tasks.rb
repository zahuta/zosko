class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :query
      t.text :excerpt
      t.integer :difficulty

      t.timestamps
    end
  end
end
