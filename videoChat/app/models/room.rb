class Room < ActiveRecord::Base
  has_many :paintings, dependent: :destroy
  validates :name, presence: true
  def to_param
    "#{id}-#{name}"
  end
end
