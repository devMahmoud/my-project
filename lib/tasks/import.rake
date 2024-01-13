require 'csv'

namespace :import do
  desc "Import movies and reviews from CSV files"
  task movies_and_reviews: :environment do
    def create_associated_actors(movie, actor_names)
      actor_names.split(',').map(&:strip).uniq.each do |name|
        actor = Actor.find_or_create_by!(name: name)
        movie.actors << actor
      end
    end
  
    def create_associated_locations(movie, city, country)
      location = Location.find_or_create_by!(city: city, country: country)
      movie.locations << location
    end
    
    CSV.foreach(Rails.root.join('db', 'movies.csv'), headers: true) do |row|
      movie = Movie.find_or_create_by(
        title: row['Movie'],
        description: row['Description'],
        year: row['Year'].to_i,
        director: row['Director']
      )
      create_associated_actors(movie, row['Actor'])
      create_associated_locations(movie, row['Filming location'], row['Country'])
    end

    CSV.foreach(Rails.root.join('db', 'reviews.csv'), headers: true) do |row|
      movie = Movie.find_by(title: row['Movie'])

      Review.create(
        stars: row['Stars'].to_i,
        text: row['Review'],
        user_name: row['User'],
        movie_id: movie.id
      )
    end

    Movie.all.each do |movie|
      movie.actors.each do |actor|
        ActorsMovie.find_or_create_by(actor: actor, movie: movie)
      end

      movie.locations.each do |location|
        LocationsMovie.find_or_create_by(location: location, movie: movie)
      end
    end
  end
end