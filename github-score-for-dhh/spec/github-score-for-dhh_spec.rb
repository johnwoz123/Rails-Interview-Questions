require_relative 'spec_helper'

describe GithubScore::Github_Score_Abacus do

  before do
    @score = GithubScore::Github_Score_Abacus.new
    @json_url = "https://api.github.com/users/dhh/events/public"
  end

  it "Should create the Github_Score_Abacus class correctly" do
    expect(@score.kind_of? GithubScore::Github_Score_Abacus).to eq true
    expect(@score.json_url).to eq @json_url
    expect(@score.event_type_point_value.kind_of? Hash).to eq true
    expect(@score.total_score.kind_of? Integer).to eq true
  end

  it "should run the program" do
    result = @score.start
    expect(result.include?("DHH's github score is")).to eq true
  end

  it "should give the github calution of the url provided" do
    expect(@score.github_score_calculation).to eq 149
    expect(@score.github_score_calculation.kind_of? Integer).to eq true
  end
end