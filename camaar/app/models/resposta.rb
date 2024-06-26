class Resposta < ApplicationRecord
  belongs_to :formulario
  belongs_to :alternativa
  has_and_belongs_to_many :resultados, join_table: 'resultados'

  validates :quantidade_de_alunos, presence: true
  validates :conteudo
end
