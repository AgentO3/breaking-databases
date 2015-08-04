class CreateBadPrescriptions < ActiveRecord::Migration
  def change
    create_table :bad_prescriptions do |t|
      t.integer :user_id
      t.string :name

      t.timestamps null: false
    end
  end
end
