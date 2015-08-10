require 'rubygems'
require 'json'
require 'securerandom'
require 'set'

class ArtistService
  def initialize
  	json_files = Dir["db/films/*.json"]
  	if Movie.all.empty? 
    	json_files.each do |filePath| 
	    	puts filePath
	    	File.open(filePath, "r") { |file| readfile(file)}
	    end
	  end 
   
  end

  def get_all_artists
    Artist.all
  end 

  def get_artist_by_id(artist_id)
  	Artist.find_by(uid: artist_id)
  end

  def get_all_movies
    Movie.all
  end

  def get_movie_by_id(movie_id)
  	Movie.find_by(uid: movie_id)
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

					return current_check.push([kevin_bacon_id, movie_id]) if co_star.uid == kevin_bacon_id
						
					unless investigated.include?(co_star.uid)
						investigated.add(co_star.uid)
						new_check = current_check.clone
						new_check.push([co_star.uid, movie_id])
						to_investigate.push(new_check)
					end

				end 
			end 
  		
  	end
  end

  def readfile(file)
    json = JSON.parse(file.read)
    
    movie = Movie.find_or_create_by(uid: json['film']['name'].parameterize)
    movie.name = json['film']['name']
    movie.image = json['film']['image']

    json['cast'].each do |cast|
    	artist_id = cast['name'].parameterize
    	artist = Artist.find_or_create_by(uid: artist_id)
      artist.name = cast['name']
      artist.image = cast['image']
    	
    	artist.push(films: movie.uid)
      artist.save 
    	movie.push(artists: artist_id)
    end
    movie.save
  end
end