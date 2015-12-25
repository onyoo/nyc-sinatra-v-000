class Figure < ActiveRecord::Base
  has_many :landmarks
  has_many :titles, through: :tfrelationships

end