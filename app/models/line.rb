class Line < ActiveRecord::Base
  has_many :goings
  has_many :returns

  # def self.search
  #   @line = Line.where("")
  # end
end
