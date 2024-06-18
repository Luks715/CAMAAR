class Classe < ApplicationRecord
  belongs_to :disciplina
  has_many :dicentes
  has_one :docente
  has_many :formularios

  validates :class_code, presence: true;
  validates :semestre, presence: true;
  validates :horario, presence: true;

end

# este modelo é temporário e irá sofrer alterações no futuro para se adequar às especificações do trabalho
