class CreatePatients < ActiveRecord::Migration[7.2]
  def change
    create_table :patients do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.date :date_of_birth, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :patients, :email, unique: true
    add_index :patients, [ :last_name, :first_name ]
  end
end
