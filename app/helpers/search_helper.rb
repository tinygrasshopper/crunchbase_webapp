module SearchHelper
  def crunchbase_image url
    "<img src='http://www.crunchbase.com/#{url}'/>".html_safe if url.present?
  end

  def entity_path type, id
    if type == 'companies'
      company_path id
    else
      product_path id
    end

  end
end