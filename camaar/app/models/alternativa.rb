class Alternativa < ApplicationRecord
  belongs_to :questaos
  has_one :resposta
  has_and_belongs_to_many :resultados, join_table: 'resultados'

  validates :texto, presence: true
end
