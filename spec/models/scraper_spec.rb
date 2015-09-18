require "rails_helper"

RSpec.describe Scraper do
  describe "search_for" do
    let(:genre) { "Ska" }
    let(:album) { {artist: "Foo", album: "Bar"} }
    let(:reader) { Nokogiri::HTML }
    let(:page_uri) do
        "http://rateyourmusic.com/customchart?chart_type=top&countries=&genre_include=1&genres=#{genre}&include=both&include_child_genres=t&limit=none&page=1&type=album&year=alltime"
    end
    
    let(:page_body) { <<-HTML }    
      <table class="mbgen">
        <tr>
          <span class="artist">Foo</span>
          <span class="album">Bar</span>
        </tr>
      </table>
    HTML
    

    subject { Scraper.new(reader: reader) }

    before do
      WebMock.stub_request(:get, page_uri).
         to_return(:status => 200, :body => page_body, :headers => {})
    end

    it 'returns albums that match the genre' do
      results = subject.search_for({genre: genre})
      expect(results).to match_array [album]
    end
  end
end