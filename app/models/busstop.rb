class Busstop < ActiveRecord::Base
  validates_presence_of :kind, message: "Tipo não foi escolhido"
  validates_presence_of :lat, message: "A localização não foi determinada"
  validates_presence_of :lng
end
