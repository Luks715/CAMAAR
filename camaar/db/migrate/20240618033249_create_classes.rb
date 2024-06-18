class CreateClasses < ActiveRecord::Migration[7.1]
  def change
    create_table :classes do |t|

      t.string :class_code, null: false
      t.string :semestre, null: false
      t.string :horario, null: false

      t.string :dicentes, array: true, default: []
      t.string :formularios, array: true, default: []
      t.references :docente, null: false, foreign_key: true
      t.references :disciplina, null: false, foreign_key: true

      t.timestamps
    end
  end
end
