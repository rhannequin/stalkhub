class CreateStalkings < ActiveRecord::Migration
  def change
    create_table :stalkings do |t|
      t.string :owner
      t.string :repo
      t.integer :user_id

      t.timestamps
    end
  end
end
