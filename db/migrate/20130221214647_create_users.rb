class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :avatar_url
      t.string :password
      t.string :encrypted_password
      t.string :salt
      t.string :token

      t.timestamps
    end

    add_index :users, :login, :unique => true
  end
end
