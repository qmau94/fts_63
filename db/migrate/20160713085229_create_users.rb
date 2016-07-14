class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.boolean :is_admin, default: false
      t.string :provider
      t.string :uid
      
      t.timestamps null: false
    end
  end
end
