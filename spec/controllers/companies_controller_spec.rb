require 'spec_helper'

describe CompaniesController do
  it 'should fetch the company information using the client' do
    company = double(Company)
    expect(Company).to receive(:find).
                            with('test').
                            and_return(company)

    get :show, id: 'test'

    expect(assigns(:company)).to eq(company)
  end
end