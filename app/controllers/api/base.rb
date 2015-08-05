require 'grape-swagger'

module API
  class Base < Grape::API
    before do
      header['Access-Control-Allow-Origin'] = '*'
      header['Access-Control-Request-Method'] = '*'
    end

  	mount API::V1::Artists
  	mount API::V1::Movies

    add_swagger_documentation :format => :json,
                              :mount_path => "/api/swagger_doc",
                              :hide_documentation_path => true
  end
end 
