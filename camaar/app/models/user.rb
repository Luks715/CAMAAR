class User < ApplicationRecord
    # Inclua os módulos do Devise necessários
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_one :docente
  has_one :dicente

  validates :nome, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates :usuario, presence: true
  validates :formacao, presence: true
end
