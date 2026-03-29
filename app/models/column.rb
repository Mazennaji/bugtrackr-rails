class Column < ApplicationRecord
  belongs_to :project
  has_many :issues, dependent: :destroy

  validates :name, presence: true
  validates :position, presence: true

  default_scope { order(:position) }
end