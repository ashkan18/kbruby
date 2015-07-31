module API  
  module V1
    module Defaults
      extend ActiveSupport::Concern

      included do
        prefix "api"
        version "v1", using: :header, vendor: 'Ashkan'
        format :json

      helpers do
        def logger
          Rails.logger
        end
       end

      end
    end
  end
end  