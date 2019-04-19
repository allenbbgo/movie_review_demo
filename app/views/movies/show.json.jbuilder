# json.partial! "movies/movie", movie: @movie

json.extract! @movie, :title ,:description,:movie_length

# create_table "movies", force: :cascade do |t|
#     t.string "title"
#     t.text "description"
#     t.string "movie_length"
#     t.string "director"
#     t.string "rating"
#     t.datetime "created_at", null: false
#     t.datetime "updated_at", null: false
#     t.integer "user_id"
#     t.string "image_file_name"
#     t.string "image_content_type"
#     t.integer "image_file_size"
#     t.datetime "image_updated_at"
#   end