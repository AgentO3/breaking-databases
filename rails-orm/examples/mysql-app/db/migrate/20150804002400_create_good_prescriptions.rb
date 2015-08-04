class CreateGoodPrescriptions < ActiveRecord::Migration
  def change
    create_table :good_prescriptions do |t|
      t.integer :user_id
      t.string :name

      t.timestamps null: false
    end
    add_index :good_prescriptions, :user_id
  end
end
