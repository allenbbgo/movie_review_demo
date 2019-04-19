class Movie < ApplicationRecord
    belongs_to :user 
    has_attached_file :image, :styles => { medium: "400x600#"  }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    has_many :reviews 
    searchkick word_start: [:title]

    def search_data
      {
        title: title,
      }
    end
  
    ratyrate_rateable 'visual_effects', 'original_score', 'director', 'custome_design'

end
