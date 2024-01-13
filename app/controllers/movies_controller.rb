class MoviesController < ApplicationController
  def index
    @movies = Movie.joins(:reviews).group(:id).order('AVG(reviews.stars) DESC')
    
  end

  def search
    if params[:actor_name].present?
      @movies = Movie.joins(:actors).where(actors: { name: params[:actor_name] })
    else
      @movies = Movie.joins(:reviews).group(:id).order('AVG(reviews.stars) DESC')
    end
    respond_to do |format|
      format.js
      format.html { render 'index' }
    end
  end
end