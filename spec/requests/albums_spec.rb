require "rails_helper"

RSpec.describe "getting albums", type: :request do
  let(:expected_albums) { [ { "genre" => 'jazz' }] }
  let(:response_content) { JSON.parse(response.body) }

  before do
    expect(Album).to receive(:where).with({genre: 'jazz'}).and_return expected_albums
  end

  it "returns top albums of that genre" do
    get "/albums", genre: 'jazz'
    albums = response_content
    
    expect(albums).to match_array(expected_albums)
  end

end