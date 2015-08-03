require 'rubygems'
require 'json'
require 'securerandom'
require 'set'

class ArtistService
  def initialize
    @artists = {}
    @films = {}
    Dir["db/films/*.json"].each do |filePath| 
    	puts filePath
    	File.open(filePath, "r") { |file| readfile(file)}
    end
   
  end

  def get_all_artists
    @artists
  end 

  def get_artist_by_id(artist_id)
  	@artists[artist_id]
  end

  def get_all_movies
    @films
  end

  def get_movie_by_id(movie_id)
  	@films[movie_id]
  end

  def find_shortest_path(artist_id)
  	full_path = shortest_path(artist_id)
  	
  	full_path_populated = []
  	full_path.each do |path|
  		full_path_populated << get_movie_by_id(path.last) unless path.last.nil? 
  			
  		full_path_populated << get_artist_by_id(path.first)
  		
  	end
  	full_path_populated
  end

  private

  def shortest_path(artist_id)
  	investigated = Set.new([artist_id])
  	to_investigate = [[[artist_id, nil]]]
  	kevin_bacon_id = 'Kevin Bacon'.parameterize

  	until to_investigate.empty? do
  		current_check = to_investigate.shift			

  		# current check is a current path, get the last item artist from the path
  		artist_id = current_check[-1][0]

  		# for each movies of this artist get all co stars and check them
  		get_artist_by_id(artist_id).films.each do |movie_id|
				get_movie_by_id(movie_id).artists.each do |co_start_id|
					co_star = $artist_service.get_artist_by_id(co_start_id)

					return current_check.push([kevin_bacon_id, movie_id]) if co_star.id == kevin_bacon_id
						
					if not investigated.include?(co_star.id)
						investigated.add(co_star.id)
						new_check = current_check.clone
						new_check.push([co_star.id, movie_id])
						to_investigate.push(new_check)
					end

				end 
			end 
  		
  	end
  end

  def readfile(file)
    json = JSON.parse(file.read)
    
    movie = Movie.new(json['film']['name'].parameterize, json['film']['name'], json['film']['image'])
    @films[movie.id] = movie
    
    json['cast'].each do |cast|
    	artist_id = cast['name'].parameterize
    	@artists[artist_id] = Artist.new(artist_id, cast['name'], cast['image']) unless @artists.has_key?(artist_id)
    	
    	@artists[artist_id].films.push(movie.id) 
    	movie.artists.push(artist_id)
    end

  end
end