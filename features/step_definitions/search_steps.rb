Given(/^I am on the home page$/) do
  visit(root_path)
end

def stub_requests_for_search
  stub_request(:get, 'http://api.crunchbase.com/v/1/search.js').
      with(query: {query: 'facebook', api_key: 'vnqmjpk7xb3cx5tqyh4s5j64'}).
      to_return(body: File.read(Rails.root.join('features/mock_responses/facebook_page_1.json')))
end

When(/^I search for "([^"]*)"$/) do |term|
  stub_requests_for_search()

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