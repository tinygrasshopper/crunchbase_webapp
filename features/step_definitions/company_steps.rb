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
When(/^I should see the following in the (people|milestones) list$/) do |type, table|
  table.hashes.each do |hash|
    hash.each do |key, value|
      expect(find(".#{type}").all(".#{key}").collect(&:text)).to include(value)
    end
  end
end