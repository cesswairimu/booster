class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :full_name
      t.string :gender
      t.string :email
      t.integer :salary

      t.timestamps
    end
  end
end
