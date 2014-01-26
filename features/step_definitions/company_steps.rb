Then(/^I should be on the "([^"]*)" company page$/) do |id|
  expect(page.current_path).to eq(company_path(id))
end