class Artist
  include Mongoid::Document
  
  field :uid
  field :name
  field :image  
  field :films, type: Array
  
  validates_presence_of :id, :name

  def to_s
  	"#@name"
  end 
end