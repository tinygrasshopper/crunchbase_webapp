Then(/^I should be on the "([^"]*)" (company|product) page$/) do |id, type|
  if type == 'company'
    expect(page.current_path).to eq(company_path(id))
  else
    expect(page.current_path).to eq(product_path(id))
  end
end
When(/^I should see "([^"]*)" in overview$/) do |text|
  expect(find('.overview').text).to match /#{text}/
end
When(/^I should see the following in the people list$/) do |table|
  table.raw.drop(1).each do |row|
    expect(find('.people').all('.role').collect(&:text)).to include(row.first)
    expect(find('.people').all('.first_name').collect(&:text)).to include(row.second)
    expect(find('.people').all('.last_name').collect(&:text)).to include(row.third)
  end
end