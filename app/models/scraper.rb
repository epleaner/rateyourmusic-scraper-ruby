require 'open-uri'

class Scraper
  constructor :reader, accessors: true
  def initialize(args={})
    super args.merge({reader: Nokogiri::HTML})
  end

  def search_for params
    doc = reader.parse(open(uri(params)))
    doc.css(".mbgen tr").map do |album_node| 
      {
        artist: album_node.css(".artist").text,
        album: album_node.css(".album").text
      }
    end
  end

  private

  def uri(params)
    rym_params = {
      page: '1',
      chart_type: 'top',
      type: 'album',
      year: 'alltime',
      genre_include: '1',
      genres: params.fetch(:genre),
      include_child_genres: 't',
      include: 'both',
      limit: 'none',
      countries: ''
    }
    
    "http://rateyourmusic.com/customchart?#{rym_params.to_query}" 
  end
end 