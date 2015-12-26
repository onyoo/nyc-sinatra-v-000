class Title < ActiveRecord::Base
  has_many :tfrelationships
  has_many :figures, through: :tfrelationships
end