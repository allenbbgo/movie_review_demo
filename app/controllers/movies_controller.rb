class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  #before_action :force_json, only: :search
  
  
  # GET /movies
  # GET /movies.json
  def index
    # @movie = Movie.all.order("created_at DESC")
    
    search = params[:term].present? ? params[:term] : nil
    @movie = if search
      Movie.where("title LIKE ?", "%#{search}%")
      # Movie.search(search)
    else
      Movie.all.order("created_at DESC")
    end

    respond_to do |format|
      format.html
      {
      }
      format.json {
        @movie = @movie.limit(1)
        #@directors = @directors.limit(5)
      }
    end

  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @reviews = Review.where(movie_id: @movie.id).order("created_at DESC")

    if @reviews.blank? 
      @avg_review = 0
    
    else
    
      @avg_review = @reviews.average(:rating).round(2)
      
    end
    

  end

  def autocomplete
    render json: Movie.search(params[:query], {
      fields: ["title^5"],
      match: :word_start,
      limit: 10,
      load: false,
      misspellings: {below: 5}
    }).map(&:title)

  end


  def search

    # search=  params[:search].present? ? params[:term] : nil
    #   @movies = if search
    #   # @movies = Movie.search(params[:search])
    #   Movie.search(search)
    # else
    #   # @movies = Movie.all
    #   Movie.all
    # end

    @movies_auto   = Movie.ransack(title_cont: params[:q]).result(distinct: true)
            # @directors =Movie.ransack(name_cont: params[:q]).result(distinct: true).limit(5)
    #render json: {movies: [], directors: []}


    respond_to do |format|
      format.html
      {
      }
      format.json {
        @movies_auto = @movies_auto.limit(2)
        #@directors = @directors.limit(5)
      }
    end
  end



  # GET /movies/new
  def new
    @movie = current_user.movies.build
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = current_user.movies.build(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def review_d
    @review = Review.find(params[:id])
    @review.delete
    redirect_back(fallback_location: root_path)
    flash[:notice] ='Comment was successfully destroyed.'

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :description, :movie_length, :director, :rating ,:image)
    end


    def force_json
      request.format = :json
    end



end
