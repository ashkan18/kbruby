class Movie
	include Mongoid::Document
	
	field :uid
	field :name
	field :image
	field :artists, type: Array
	
	def to_s
		"#@name"
	end

end