class Room < ActiveRecord::Base
  validates :name, presence: true
  def to_param
    "#{id}-#{name}"
  end
end
