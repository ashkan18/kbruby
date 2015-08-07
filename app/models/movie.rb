class Movie
	include Mongoid::Document
	attr_accessor :id, :name, :image, :artists

	field :id
	field :name
	field :image
	field :artists, type: Array
	
	def to_s
		"#@name"
	end

end