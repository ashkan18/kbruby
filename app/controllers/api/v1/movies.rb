module API
	module V1
		class Movies < API::Base
      include API::V1::Defaults

      resources :movies do
      	desc 'Get All Movies'
      	get '' do
      		present $artist_service.get_all_movies()
      	end

      	desc 'Get Movie by id'
      	get ':id' do
      		present $artist_service.get_movie_by_id(params[:id])
      	end
      end
    end
	end
end