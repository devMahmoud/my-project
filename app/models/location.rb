class Location < ApplicationRecord
  has_many :locations_movies
  has_many :movies, through: :locations_movies
end
