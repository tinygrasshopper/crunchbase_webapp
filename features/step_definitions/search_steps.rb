Given(/^I am on the home page$/) do
  visit(root_path)
end

def stub_requests_for_search(term)
  Dir.glob(Rails.root.join("features/mock_responses/search_#{term}_page_*.json")).each_with_index do |path, index|
    stub_request(:get, 'http://api.crunchbase.com/v/1/search.js').
        with(query: {query: term, api_key: APP_CONFIG['crunchbase_key'], page: index.next.to_s}).
        to_return(body: File.read(path))
  end

end

def stub_requests_for_company
  stub_request(:get, 'http://api.crunchbase.com/v/1/company/facebook.js').
      with(query: {api_key: APP_CONFIG['crunchbase_key']}).
      to_return(body: File.read(Rails.root.join('features/mock_responses/company_facebook.json')))

end

def stub_requests_for_product
  stub_request(:get, 'http://api.crunchbase.com/v/1/product/facebook-like-button.js').
      with(query: {api_key: APP_CONFIG['crunchbase_key']}).
      to_return(body: File.read(Rails.root.join('features/mock_responses/product_facebook_like_button.json')))

end

When(/^I search for "([^"]*)"$/) do |term|
  visit(root_path)
  stub_requests_for_search(term)

  fill_in 'query', with: term
  click_on 'Search'
end

Then(/^I should see (\d+) results in the (companies|products) result set$/) do |count, result_set|
  expect(all(".#{result_set} .name").size).to eq count.to_i
end
Then(/^I should see the following in the (companies|products) result set$/) do |type, table|
  table.raw.drop(1).each do |row|
    expect(find(".#{type}").all('.name').collect(&:text)).to include(row.first)
    expect(find(".#{type}").all('.description').collect(&:text)).to include(row.second) if type == 'companies'
  end
end
When(/^I click on the "([^"]*)" in the (companies|products) result set$/) do |text, type|
  if type == 'companies'
    stub_requests_for_company()
  else
    stub_requests_for_product()
  end

  find(".#{type}").click_on(text)
end
Then(/^I goto the next page$/) do
  click_on 'Next'
end