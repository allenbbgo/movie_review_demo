
json.movies do
    json.array!(@movies_auto) do |movie|
        json.name movie.title
         json.url movie_path(movie)
    end
end

# json.directors do  
#     json.array!(@directors) do |director|
#         json.name director.director
#     end
# end