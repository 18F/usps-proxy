require 'spec_helper'
 
describe USPS::Proxy::AddressStandardization do
 
  context "GET '/adddress_standardization'" do
    use_vcr_cassette #record: :new_episodes
    
    let(:address_query_string1) do
      "address1=1800%20F%20street%20NW&city=washington&state=DC&zip5=20006"
    end
    
    let(:address_query_string2) do
      "address1=1801%20F%20street%20NW&city=washington&state=DC&zip5=20006"
    end
    
    let(:return_text) do
      "Default address: The address you entered was found but more information is needed (such as an apartment, suite, or box number) to match to a specific address."
    end
    
    it "standardizes an address" do
      get "/address_standardization?#{address_query_string1}"
      
      parsed = JSON.parse(last_response.body)
      
      expect(parsed).to(be_a(Hash))
      expect(parsed).to(have_key("results"))
      
      expect(parsed["results"][0].keys).to(eq([
        "name",
        "company",
        "address1",
        "address2",
        "city",
        "state",
        "zip5",
        "zip4",
        "return_text"
      ]))
      
      expect(parsed["results"][0]["address1"]).to(eq("1800 F ST NW"))
      expect(parsed["results"][0]["zip5"]).to(eq("20405"))
      expect(parsed["results"][0]["zip4"]).to(eq("0001"))
    end
    
    it "asks for more information if necessary" do
      get "/address_standardization?#{address_query_string2}"
      
      parsed = JSON.parse(last_response.body)
      
      expect(parsed["results"][0]["return_text"]).to(eq(return_text))
    end
    
    it "returns an error when given invalid data" do
      pending("this needs to be implemented")
      
      get "/address_standardization?foo=bar&not=an_address"
      
      parsed = JSON.parse(last_response.body)
      
      expect(parsed).to(have_key("error"))
    end
  end
end
