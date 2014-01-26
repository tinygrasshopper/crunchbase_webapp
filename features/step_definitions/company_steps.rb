Then(/^I should be on the "([^"]*)" company page$/) do |id|
  expect(page.current_path).to eq(company_path(id))
end
When(/^I should see "([^"]*)" in company overview$/) do |text|
  expect(find('.overview').text).to match /#{text}/
end
When(/^I should see the following in the people list$/) do |table|
  pending
  # table is a | Founder and CEO, Board Of Directors | Mark       | Zuckerberg |
  table.raw.drop(1).each do |row|
    expect(find('.people').all('.role').collect(&:text)).to include(row.first)
    expect(find('.people').all('.first_name').collect(&:text)).to include(row.second)
    expect(find('.people').all('.last_name').collect(&:text)).to include(row.third)
  end
end