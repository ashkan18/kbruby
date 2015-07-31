class Movie
	attr_accessor :id, :name, :image, :artists

	def initialize(id, name, image, artists = [])
		@id = id
		@name = name
		@image = image
		@artists = artists
	end

	def to_s
		"#@name"
	end

end