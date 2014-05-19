class CreateJoinTableCategoryTask < ActiveRecord::Migration
  def change
    create_join_table :categories, :tasks do |t|
      t.index [:category_id, :task_id]
      t.index [:task_id, :category_id]
    end
  end
end
