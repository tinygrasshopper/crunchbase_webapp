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

  def next_link results
    'disabled' if results.last?
  end


  def previous_link results
    'disabled' if results.first?
  end
end