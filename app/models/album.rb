require 'open-uri'

class Album
  constructor :genre, accessors: true

  def self.where(params)
    Scraper.new.search_for(params).map { |album_data| Album.new(album_data) }
  end
end