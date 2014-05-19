class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user, index: true
      t.references :task, index: true
      t.integer :state

      t.timestamps
    end
  end
end
