class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.references :user, index: true
      t.references :badge, index: true

      t.timestamps
    end
  end
end
