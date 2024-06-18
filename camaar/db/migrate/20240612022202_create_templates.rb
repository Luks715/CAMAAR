class CreateTemplate < ActiveRecord::Migration[7.1]
  def change
    create_table :templates do |t|
      t.string :nome, null: false
      t.string :questaos, null: false, array: true, default: []

      t.references :docente, null: false, foreign_key: true

      t.timestamps
    end
  end
end
