class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :question_number
      t.integer :duration
      t.string :slug

      t.timestamps null: false
    end
    add_index :subjects, :slug, unique: true
  end
end
