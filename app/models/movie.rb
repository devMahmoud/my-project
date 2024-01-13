class Movie < ApplicationRecord
  has_many :actors_movies
  has_many :actors, through: :actors_movies
  has_many :locations_movies
  has_many :locations, through: :locations_movies
  has_many :reviews

  def average_rating
    reviews.average(:stars)
  end
end
