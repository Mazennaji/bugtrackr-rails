class Project < ApplicationRecord
  belongs_to :team
  has_many :columns, dependent: :destroy
  has_many :issues, through: :columns

  validates :name, presence: true

  def board
    columns.includes(:issues)
  end
end