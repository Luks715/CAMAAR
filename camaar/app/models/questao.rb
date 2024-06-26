class Questao < ApplicationRecord
  belongs_to :template
  has_one :tipo
  has_many :alternativas, class_name: 'Alternativa', foreign_key: :questao_id, dependent: :destroy
  accepts_nested_attributes_for :alternativas, allow_destroy: true

  has_and_belongs_to_many :resultados, join_table: 'resultados'

  validates :pergunta, presence: true
end
