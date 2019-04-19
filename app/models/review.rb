class Review < ApplicationRecord
    belongs_to :user
    belongs_to :movie
    ratyrate_rateable "speed", "engine", "price"

    validates :rating,presence: true    
end
