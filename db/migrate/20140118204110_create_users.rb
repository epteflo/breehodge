class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :password_hash
      t.string :name
      t.text :comment
      t.string :role

      t.timestamps
    end
  end
end
