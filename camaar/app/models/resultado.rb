class Resultado < ApplicationRecord
  belongs_to :formulario
  belongs_to :template
  belongs_to :questao
  belongs_to :alternativa
  belongs_to :resposta
end
