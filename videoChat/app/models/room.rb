class Room < ActiveRecord::Base
  has_many :paintings, dependent: :destroy
  accepts_nested_attributes_for :paintings, :allow_destroy =>true
  validates :name, presence: true
  def to_param
    "#{id}-#{name}"
  end
end
