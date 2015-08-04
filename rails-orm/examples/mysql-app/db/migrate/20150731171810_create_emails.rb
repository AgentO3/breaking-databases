class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.integer :user_id, :limit => 11
      t.string :email
      t.timestamps null: false
    end
    add_index :emails, :user_id
  end
end
