json.array! @movie.limit(1), partial: 'movies/movie', as: :movie

    # json.extract! @movie, :title ,:description,:movie_length 