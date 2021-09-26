class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.string :summary, null: false
      t.boolean :accomplished, default: 0
      t.bigint :date_added
      t.timestamps
    end
  end
end
