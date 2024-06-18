class Formulario < ApplicationRecord
  belongs_to :docente
  belongs_to :template
  has_many :classes

  validates :resultados, presence: true
  validates :dataDeTermino, presence: true

  validate :dataDeTermino_in_future

  private

  def dataDeTermino_in_future
    if dataDeTermino <= Date.today
      errors.add(:dataDeTermino, "data inválida")
    end
  end
end
