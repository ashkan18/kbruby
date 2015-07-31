module API
  module V1
    class Artists < API::Base
      include API::V1::Defaults

      resources :artists do
        desc "Return all the artists"
        get "" do
          present $artist_service.get_all_artists
        end

        desc "Return an Artist given an id."
        get ':id' do
          present $artist_service.get_artist_by_id(params[:id])
        end

        resources :kbdegree do
          desc "Get Kevin Bacon Degree for an artist id"
          get ':id' do
            shortest_path = $artist_service.find_shortest_path(params[:id])
          end
        end        
      end
    end 
  end
end