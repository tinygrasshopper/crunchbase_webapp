module SearchHelper
  def crunchbase_image url
    "<img src='http://www.crunchbase.com/#{url}'/>".html_safe if url.present?
  end

end