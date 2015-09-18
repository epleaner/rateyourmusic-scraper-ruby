require "rails_helper"
require 'open-uri'

RSpec.describe Album do
  describe '#where' do
    let(:genre) { "#{rand(100).ordinalize} Wave Ska" }
    let(:album) { {genre: genre} }
    let(:params) { {genre: genre} }
    let(:scraper) { double(:scraper, reader: double(:reader, search_for: nil) )}

    before do
      expect(scraper).to receive(:search_for).with(params).and_return([album])
      expect(Scraper).to receive(:new).and_return(scraper)
    end

    it 'returns albums according to the parameters' do
      expect(Album.where(params).map(&:genre)).to match_array([album[:genre]])
    end
  end
  
end