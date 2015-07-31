module API
  class Base < Grape::API
  	mount API::V1::Artists
  	mount API::V1::Movies
  end
end 
