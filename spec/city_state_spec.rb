require 'spec_helper'
 
describe USPS::Proxy::CityState do
 
  context "GET '/city_state'" do
    use_vcr_cassette #record: :new_episodes
    
    let(:zip5)  { "20006" }
    let(:city)  { "WASHINGTON" }
    let(:state) { "DC" }
    
    it "gets a city and state from zipcode" do
      get "/city_state?zip5=#{zip5}"
      
      expect(last_response).to be_ok
      
      parsed = JSON.parse(last_response.body)
      
      expect(parsed).to(be_a(Hash))
      expect(parsed).to(be_a(Hash))
      expect(parsed["results"][zip5]["city"]).to(eq(city))
      expect(parsed["results"][zip5]["state"]).to(eq(state))
    end
    
    it "returns an error when no zip5 is provided" do
      get "/city_state"
      
      parsed = JSON.parse(last_response.body)
      
      expect(parsed).to(have_key("error"))
    end
    
    it "returns an error when an invalid zip5 is provided" do
      get "/city_state?zip5=thisIsNotAZip5"
      
      parsed = JSON.parse(last_response.body)
      
      expect(parsed).to(have_key("error"))
    end
    
  end
  
end
