class CreateFormularios < ActiveRecord::Migration[7.1]
  def change
    create_table :formularios do |t|
      t.date :dataDeTermino, null:false
      t.string :classes, array: true, default: []
      t.jsonb :resultados, default: {}

      t.references :docente, null: false, foreign_key: true
      t.references :template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
