class Resultado < ApplicationRecord
  belongs_to :formulario
  belongs_to :template
  belongs_to :questao
  belongs_to :alternativa

  validates :respostas, presence: true
  validates :respostas_discursivas, presence: true
end
