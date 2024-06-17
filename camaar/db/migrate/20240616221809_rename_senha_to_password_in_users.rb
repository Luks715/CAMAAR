class RenameSenhaToPasswordInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :senha, :password
  end
end
