class MoviesController < ApplicationController
  def index
    # search fo title using params[:query]

    @results = params[:query].present? ? PgSearch.multisearch(params[:query]) : Movie.all + TvShow.all

    # hillel's creative solution - me likey
    # @movies = Movie.all.select do |movie|
    #   movie.title.include?(params[:query])
    # end
  end

  private

  def sql_search(query)
    sql_query = "title @@ :query \
                    OR synopsis @@ :query \
                    OR directors.first_name @@ :query \
                    OR directors.last_name @@ :query"
    @movies = Movie.joins(:director).where(sql_query, query: "%#{query}%")
  end
end
