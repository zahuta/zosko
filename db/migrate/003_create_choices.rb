class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.belongs_to :task
      t.text :text
      t.text :explanation
      t.boolean :correct

      t.timestamps
    end
  end
end
