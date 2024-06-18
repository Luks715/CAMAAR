class CreateDisciplinas < ActiveRecord::Migration[7.1]
  def change
    create_table :disciplinas do |t|
      t.string :codigo, null: false
      t.string :nome, null: false

      t.timestamps
    end
  end
end
