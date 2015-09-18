class AlbumsController < ApplicationController
  def index
    render json: Album.where(params)
  end
end
