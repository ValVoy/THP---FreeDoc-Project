class CreatePatients < ActiveRecord::Migration[8.1]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.references :city, null: false, foreign_key: true

      t.timestamps
    end
  end
end
