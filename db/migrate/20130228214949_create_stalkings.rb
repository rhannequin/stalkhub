class CreateStalkings < ActiveRecord::Migration
  def change
    create_table :stalkings do |t|
      t.string :owner
      t.string :repo
      t.integer :id_user

      t.timestamps
    end
  end
end
