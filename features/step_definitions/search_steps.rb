Given(/^I am on the home page$/) do
  visit(root_path)
end

def stub_requests_for_search
  stub_request(:get, 'http://api.crunchbase.com/v/1/search.js?api_key=vnqmjpk7xb3cx5tqyh4s5j64&query=facebook').
  #stub_request(:get, 'http://api.crunchbase.com/v/1/search.js').
  #    with(query: {query: 'facebook',
  #                 #api_key: 'test_api_key',
  #                 api_key: 'vnqmjpk7xb3cx5tqyh4s5j64',
  #                 page: 1}).
      to_return(body: File.read(Rails.root.join('features/mock_responses/facebook_page_1.json')))

  #stub_request(:get, 'http://api.crunchbase.com/v/1/search.js').
  #    with(query: {query: 'mike', api_key: 'test_api_key', page: 2}).
  #    to_return(body: File.read(Rails.root.join('features/mock_responses/mike_page_2.json')))

end

When(/^I search for "([^"]*)"$/) do |term|
  stub_requests_for_search()

  fill_in 'query', with: term
  click_on 'search'
end

Then(/^I should see (\d+) results in the (companies|products) result set$/) do |count, result_set|
  expect(all(".#{result_set} li").size).to eq count.to_i
end
Then(/^I should see the following company results$/) do |table|
  save_and_open_page
  table.raw.drop(1).each do |row|
    expect(find('.companies').all('.name').collect(&:text)).to include(row.first)
    expect(find('.companies').all('.description').collect(&:text)).to include(row.second)
  end
end