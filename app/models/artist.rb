class Artist
  attr_accessor :id, :name, :image, :films
  
  def initialize(id, name, image, films = [])
    # Instance variables  
    @id = id
    @name = name
    @image = image  
    @films = films
  end 

  def to_s
  	"#@name"
  end 
end