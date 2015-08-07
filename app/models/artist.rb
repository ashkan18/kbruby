class Artist
  include Mongoid::Document
  attr_accessor :id, :name, :image, :films
  

  field :id
  field :name
  field :image_url
  
  field :films, type: Array
  
  validates_presence_of :id, :name

  def to_s
  	"#@name"
  end 
end